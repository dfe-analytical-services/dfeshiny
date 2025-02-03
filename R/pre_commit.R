#' Initialize Pre-commit Hook
#'
#' Creates a Git pre-commit hook that runs the `commit_hooks` function.
#' If `skip_analytics_key_check` is set to TRUE, it will pass that argument to the script.
#'
#' @param skip_analytics_key_check Logical. If TRUE, skips `check_analytics_key` in the hook.
#' @return The path to the pre-commit hook file if created successfully.
#' @export
pre_commit_innit <- function(skip_analytics_key_check = FALSE) {
  hook_path <- ".git/hooks/pre-commit"

  # Define hook content
  hook_content <- sprintf("#!/usr/bin/env Rscript\ndfeshiny::commit_hooks(skip_analytics_key_check = %s)", skip_analytics_key_check)

  # Ensure the hooks directory exists
  if (!dir.exists(".git/hooks")) {
    stop("Git hooks directory not found. Are you inside a Git repository?")
  }

  # Write the hook file
  writeLines(hook_content, hook_path)

  # Make the script executable
  Sys.chmod(hook_path, mode = "0755")

  message("Pre-commit hook created at ", hook_path)
  return(hook_path)
}

#' Commit Hooks for Data Validation, Analytics Check, and Code Styling
#'
#' This wrapper function executes a series of pre-commit checks, including:
#' - Data file validation (`data_checker`)
#' - Google Analytics key validation (`check_analytics_key`, can be skipped)
#' - Code styling check (`style_code`)
#'
#' @param skip_analytics_key_check Logical. If TRUE, skips `check_analytics_key`.
#' @return TRUE if all checks pass, FALSE otherwise.
#' @export
commit_hooks <- function(skip_analytics_key_check = FALSE) {
  all_pass <- TRUE

  message("Running data file validation...")
  if (!data_checker()) {
    all_pass <- FALSE
  }

  if (!skip_analytics_key_check) {
    message("Running Google Analytics check...")
    if (!check_analytics_key()) {
      all_pass <- FALSE
    }
  } else {
    message("Skipping Google Analytics check...")
  }

  message("Running code styling check...")
  if (style_code()) {
    message("Code formatting was updated. Please review changes.")
    all_pass <- FALSE
  }

  if (all_pass) {
    message("\nAll commit checks passed!")
    return(TRUE)
  }

  message("\nCommit blocked: Issues detected.")
  return(FALSE)
}

#' Validate Data Files and Gitignore Configuration
#'
#' Performs comprehensive checks on data file tracking and .gitignore configuration:
#' 1. Validates .gitignore format
#' 2. Checks data files against tracking log
#' 3. Verifies file status classifications
#'
#' @param datafile_log path to data log file
#' @param ignore_file path to gitignore file
#' @return TRUE if all checks pass, FALSE otherwise
#' @importFrom dplyr filter
#' @export
data_checker <- function(datafile_log = "datafiles_log.csv",
                         ignore_file = ".gitignore") {
  files <- NULL # assigning null variable to avoid rcmdcheck dplyr variable assignment error
  all_ok <- TRUE
  suffixes <- "xlsx$|ods$|dat$|csv$|tex$|pdf$|zip$|gz$|parquet$|rda$|rds$"
  valid_statuses <- c("published", "reference", "dummy")

  # Read tracking files
  tryCatch(
    {
      log_files <- utils::read.csv(datafile_log, stringsAsFactors = FALSE)
      ign_files <- utils::read.csv(ignore_file,
        header = FALSE,
        stringsAsFactors = FALSE, col.names = "filename"
      )
    },
    error = function(e) {
      message("Error reading configuration files: ", e$message)
      return(FALSE)
    }
  )

  message("=== Gitignore Validation ===")
  if (ncol(ign_files) > 1) {
    message("ERROR: Commas detected in .gitignore")
    all_ok <- FALSE
  }

  space_files <- ign_files$filename[grepl(" ", ign_files$filename)]
  if (length(space_files) > 0) {
    message(
      "ERROR: Spaces in .gitignore entries:\n",
      paste("-", space_files, collapse = "\n")
    )
    all_ok <- FALSE
  }

  message("\n=== Data File Validation ===")
  current_files <- data.frame(
    files = list.files("./", recursive = TRUE, full.names = TRUE)
  ) |>
    dplyr::filter(
      grepl(suffixes, files, ignore.case = TRUE),
      !grepl("renv|datafiles_log.csv", files)
    )

  for (file in current_files$files) {
    rel_path <- gsub("^./", "", file)

    if (!rel_path %in% log_files$filename) {
      message(
        "Missing entry: ", rel_path, "\n",
        "  - Add to datafiles_log.csv with status: ",
        "published, reference, or dummy\n"
      )
      all_ok <- FALSE
      next
    }

    status <- tolower(log_files$status[log_files$filename == rel_path])
    in_ignore <- rel_path %in% ign_files$filename

    if (!status %in% valid_statuses) {
      if (!in_ignore && !grepl("unpublished", rel_path)) {
        message(
          "Unmanaged file: ", rel_path, "\n",
          "  - Status: ", log_files$status[log_files$filename == rel_path], "\n",
          "  - Valid statuses: ", paste(valid_statuses, collapse = ", "), "\n",
          "  - Add to .gitignore if unpublished\n"
        )
        all_ok <- FALSE
      } else {
        message(
          "Note: ", rel_path,
          " is unpublished (ignored) but consider updating its status\n"
        )
      }
    }
  }

  if (all_ok) {
    message("\nAll data file checks passed!")
    return(TRUE)
  }

  message("\nCommit blocked: Data validation issues detected")
  return(FALSE)
}

#' Check for and Replace Google Analytics Keys
#'
#' Reads `google-analytics.html` and `ui.R` to check for Google Analytics keys.
#' If found, replaces them with placeholder values and stages the files in git.
#'
#' @param ga_file Path to the Google Analytics file.
#' @param ui_file Path to the UI script file.
#' @return TRUE if no issues found, FALSE if replacements were made.
#' @importFrom xfun gsub_file
#' @export
check_analytics_key <- function(ga_file = "google-analytics.html",
                                ui_file = "ui.R") {
  ga_pattern <- "(G-[A-Z0-9]{10}|UA-\\d{6,9}-\\d+)"

  ga_content <- readLines(ga_file)
  ui_content <- readLines(ui_file)

  if (any(grepl(ga_pattern, ga_content))) {
    xfun::gsub_file(ga_file, ga_pattern, "G-XXXXXXXXXX")
    xfun::gsub_file(ui_file, ga_pattern, "XXXXXXXXXX")

    system2("git", c("add", ga_file, ui_file))

    message("Updated analytics tag")
    return(FALSE)
  }
  TRUE
}

#' Check and Apply Code Styling
#'
#' Styles R code in the `R` directory and detects changes.
#' If changes are made, warns the user before committing.
#'
#' @return TRUE if changes were made, FALSE otherwise.
#' @importFrom digest digest
#' @export
style_code <- function() {
  original <- list.files("R", full.names = TRUE) |>
    lapply(function(f) digest::digest(f, file = TRUE))

  styler::style_dir("R")

  updated <- list.files("R", full.names = TRUE) |>
    lapply(function(f) digest::digest(f, file = TRUE))

  any(original != updated)
}
