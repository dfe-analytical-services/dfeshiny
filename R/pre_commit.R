#' Validate Data Files and Gitignore Configuration
#'
#' Performs comprehensive checks on data file tracking and gitignore configuration:
#' 1. Validates .gitignore format
#' 2. Checks data files against tracking log
#' 3. Verifies file status classifications
#'
#' @return TRUE if all checks pass, FALSE otherwise
#' @importFrom dplyr filter
#' @export
data_checker <- function(datafile_log = "datafiles_log.csv",
                         ignore_file = ".gitignore") {
  all_ok <- TRUE
  suffixes <- "xlsx$|ods$|dat$|csv$|tex$|pdf$|zip$|gz$|parquet$|rda$|rds$"
  valid_statuses <- c("published", "reference", "dummy")

  # Read tracking files
  tryCatch({
    log_files <- read.csv(datafile_log, stringsAsFactors = FALSE)
    ign_files <- read.csv(ignore_file, header = FALSE,
                          stringsAsFactors = FALSE, col.names = "filename")
  }, error = function(e) {
    message("Error reading configuration files: ", e$message)
    return(FALSE)
  })

  message("=== Gitignore Validation ===")
  # Check .gitignore format
  if (ncol(ign_files) > 1) {
    message("ERROR: Commas detected in .gitignore")
    all_ok <- FALSE
  }

  # Check for spaces in filenames
  space_files <- ign_files$filename[grepl(" ", ign_files$filename)]
  if (length(space_files) > 0) {
    message("ERROR: Spaces in .gitignore entries:\n",
            paste("-", space_files, collapse = "\n"))
    all_ok <- FALSE
  }

  message("\n=== Data File Validation ===")
  # Find relevant data files
  current_files <- data.frame(
    files = list.files("./", recursive = TRUE, full.names = TRUE)
  ) |>
    dplyr::filter(
      grepl(suffixes, files, ignore.case = TRUE),
      !grepl("renv|datafiles_log.csv", files)
    )

  # Check each file against tracking log
  for (file in current_files$files) {
    rel_path <- gsub("^./", "", file)  # Normalize path

    if (!rel_path %in% log_files$filename) {
      message("Missing entry: ", rel_path, "\n",
              "  - Add to datafiles_log.csv with status: ",
              "published, reference, or dummy\n")
      all_ok <- FALSE
      next
    }

    status <- tolower(log_files$status[log_files$filename == rel_path])
    in_ignore <- rel_path %in% ign_files$filename

    if (!status %in% valid_statuses) {
      if (!in_ignore && !grepl("unpublished", rel_path)) {
        message("Unmanaged file: ", rel_path, "\n",
                "  - Status: ", log_files$status[log_files$filename == rel_path], "\n",
                "  - Valid statuses: ", paste(valid_statuses, collapse = ", "), "\n",
                "  - Add to .gitignore if unpublished\n")
        all_ok <- FALSE
      } else {
        message("Note: ", rel_path,
                " is unpublished (ignored) but consider updating its status\n")
      }
    }
  }

  if (all_ok) {
    message("\nAll data file checks passed!")
    return(TRUE)
  }

  message("\nCommit blocked: Data validation issues detected")
  message("Required actions:")
  message("- Add missing files to datafiles_log.csv")
  message("- Set valid statuses: ", paste(valid_statuses, collapse = ", "))
  message("- Add unpublished data to .gitignore")
  return(FALSE)
}


# Modified analytics check with replacement
check_analytics_key_v2 <- function() {
  ga_file <- "google-analytics.html"
  ui_file <- "ui.R"
  ga_pattern <- "G-Z967JJVQQX"

  if (any(grepl(ga_pattern, readLines(ga_file))) &&
      !(toupper(Sys.getenv("USERNAME")) %in% c("CFOSTER4", "CRACE", "LSELBY", "RBIELBY", "JMACHIN"))) {
    xfun::gsub_file(ga_file, ga_pattern, "G-XXXXXXXXXX")
    xfun::gsub_file(ui_file, ga_pattern, "XXXXXXXXXX")
    system2("git", c("add", ga_file))
    message("Updated analytics tag")
    return(FALSE)  # Block commit to allow review
  }
  TRUE
}

# Styling with change detection
style_code_v2 <- function() {
  original <- list.files("R", full.names = TRUE) |>
    lapply(function(f) digest::digest(f, file = TRUE))

  styler::style_dir("R")

  updated <- list.files("R", full.names = TRUE) |>
    lapply(function(f) digest::digest(f, file = TRUE))

  any(original != updated)
}
