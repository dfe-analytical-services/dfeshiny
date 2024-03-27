#' Tidy code
#'
#' @description Script to apply styler code styling to scripts within the
#' shiny directory structure.
#'
#' @param subdirs List of sub-directories to
#' (recursively search for R scripts to be styled)
#'
#' @return TRUE if any changes have been made to any scripts, FALSE if all
#'   passed.
#' @export
#'
#' @examples
#' tidy_code()
tidy_code <- function(subdirs = c("R", "tests")) {
  message("----------------------------------------")
  message("App scripts")
  message("----------------------------------------")
  script_changes <- eval(
    styler::style_dir(
      recursive = FALSE,
      exclude_files = c("dfeshiny-Ex.R")
    )$changed
  )
  for (dir in subdirs) {
    if (dir.exists(dir)) {
      message(paste(dir, "scripts"))
      message("----------------------------------------")
      script_changes <- c(
        script_changes,
        eval(styler::style_dir(dir)$changed)
      )
    } else {
      warning(paste("Script directory not found:", dir, "- Skipping!"))
    }
  }
  if (any(script_changes)) {
    message(
      "Styling changes have been made to your scripts,
            please review any changes made."
    )
  }
  return(any(script_changes))
}
