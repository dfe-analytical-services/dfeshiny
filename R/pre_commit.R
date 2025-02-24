#' Initialize Pre-commit Hook
#'
#' Creates a Git pre-commit hook that runs the `commit_hooks` function.
#' @return The path to the pre-commit hook file if created successfully.
#' @export
init_hooks <- function() {
  hook_path <- ".git/hooks/pre-commit"

  # Define hook content
  hook_content <- sprintf("#!/usr/bin/env Rscript\ndfeshiny::commit_hooks()")

  # Ensure the hooks directory exists
  if (!dir.exists(".git")) {
    stop(".git directory not found. Are you inside a Git repository?")
  }

  # Write the hook file
  writeLines(hook_content, hook_path)

  # Make the script executable
  Sys.chmod(hook_path, mode = "0755")

  message("Pre-commit hook created at ", hook_path)
  hook_path
}

#' Commit Hooks for Data Validation, Analytics Check, and Code Styling
#'
#' This wrapper function executes a series of pre-commit checks, including:
#' - Data file validation (`data_checker`)
#' - Google Analytics key validation (`check_analytics_key`, skipped if running
#' in shiny_template repo)
#' - Code styling check (`style_code`)
#'
#' @return TRUE if all checks pass, FALSE otherwise.
#' @export
#' @export
#' @examples
#' \dontrun{
#' commit_hooks()
#' }
commit_hooks <- function() {
  all_pass <- TRUE

  message("Running data file validation...")
  if (!data_checker()) {
    all_pass <- FALSE
  }

  if (!file.exists("shiny_template.Rproj")) {
    message("Running Google Analytics check...")
    if (!check_analytics_key()) {
      all_pass <- FALSE
    }
  } else {
    message("Exectuing in shiny_template repo, Skipping Google Analytics check...")
  }

  message("Running code styling check...")
  if (style_code()) {
    message("Warning: Code failed styling checks.
  \n`styler::style_dir()` has been run for you.
  \nPlease check your files and dashboard still work.
  \nThen re-stage and try committing again.")
    all_pass <- FALSE
    quit(save = "no", status = 1, runLast = FALSE)
  }

  if (all_pass) {
    message("\nAll commit checks passed!")
    return(TRUE)
  }

  message("\nCommit blocked: Issues detected.")
  FALSE
}

#' Validate Data Files and Gitignore Configuration
#'
#' Performs comprehensive checks on data file tracking and .gitignore
#' configuration:
#' 1. Validates .gitignore format
#' 2. Checks data files against tracking log
#' 3. Verifies file status classifications
#'
#' @param datafile_log path to data log file
#' @param ignore_file path to gitignore file
#' @return TRUE if all checks pass, FALSE otherwise
#' @importFrom dplyr filter
#' @keywords internal
data_checker <- function(datafile_log = "datafiles_log.csv",
                         ignore_file = ".gitignore") {
  # assigning null variable to avoid rcmdcheck dplyr variable assignment error
  files <- NULL
  all_ok <- TRUE
  suffixes <- "xlsx$|ods$|dat$|csv$|tex$|pdf$|zip$|gz$|parquet$|rda$|rds$"
  valid_statuses <- c("published", "reference", "dummy")

  message("=== .gitignore validation ===")
  if (file.exists(ignore_file)) {
    ign_files <- utils::read.csv(ignore_file,
      header = FALSE,
      stringsAsFactors = FALSE, col.names = "filename"
    )
    ign_text <- readr::read_file(".gitignore")
  } else {
    stop(".gitignore file not detected, please add a .gitignore file to your project folder.")
  }

  if (grepl(",", ign_text)) {
    stop("ERROR: Commas detected in .gitignore")
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

  if (length(ign_text) > 0) {
    if (substring(ign_text, nchar(ign_text)) != "\n") {
      message("ERROR: .gitignore does not end with a newline character.")
      all_ok <- FALSE
    }
  }
  if (all_ok) {
    message("Initial .gitignore validation passed")
  }

  message("\n=== Data file validation ===")
  if (!file.exists(datafile_log)) {
    stop(
      "Error reading configuration file: ", datafile_log, "\n",
      "To protect against accidental publication of sensitive data, ",
      "we require all dashboard repositories to contain a data files log (datafiles_log.csv), ",
      "which should list all data files in the repository and their current status, e.g.:\n\n",
      "filename,status\n",
      "data/data_file.csv,published\n",
      "data/unpublished_data.csv,unpublished\n",
      "data/reference_data.csv,reference\n\n",
      "Any files containing sensitive or unpublished data must also be listed in the .gitignore."
    )
  } else {
    log_files <- readr::read_csv(datafile_log)
    if (!all(c("filename", "status") %in% colnames(log_files))) {
      stop("The data logfile must contain the columns filename and status")
    }
  }

  current_files <- data.frame(
    files = list.files("./", recursive = TRUE, full.names = TRUE)
  ) |>
    dplyr::filter(
      grepl(suffixes, files, ignore.case = TRUE),
      !grepl("renv|datafiles_log.csv", files)
    )

  file_status_list <- list()

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

    file_status_list[[rel_path]] <- status

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
    message("\nThe following data files will all be included as part of this commit:")
    for (file in names(file_status_list)) {
      message("  - ", file, " (Status: ", file_status_list[[file]], ")")
    }
    message("\nThe above data files will all be included as part of this commit,
            please double check the listed status for each file is as expected..")
    message("\nAll data file checks passed!")
    return(TRUE)
  } else {
    message("\nCommit blocked: Data validation issues detected")
    quit(save = "no", status = 1, runLast = FALSE)
  }

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
#' @keywords internal
check_analytics_key <- function(ga_file = "google-analytics.html",
                                ui_file = "ui.R") {
  ga_pattern <- "Z967JJVQQX"
  if (!file.exists(ga_file)) {
    message("skipping check for google analytics keys...")
    return(TRUE)
  }
  ga_content <- readLines(ga_file)

  if (any(grepl(ga_pattern, ga_content))) {
    xfun::gsub_file(ga_file, paste0("G-", ga_pattern), "G-XXXXXXXXXX")
    xfun::gsub_file(ui_file, ga_pattern, "XXXXXXXXXX")

    system2("git", c("add", ga_file, ui_file))

    message("Updated analytics tag")
    return(FALSE)
  }
  TRUE
}

#' Check and Apply Code Styling
#'
#' Styles all R scripts in the project and detects changes.
#'
#' @return TRUE if changes were made, FALSE otherwise.
#' @importFrom magrittr %>%
#' @keywords internal
style_code <- function() {
  styler::style_dir() |>
    magrittr::extract2("changed") |>
    any()
}
