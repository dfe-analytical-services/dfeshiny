#' init_analytics
#'
#' @param ga_code The Google Analytics code
#' @importFrom magrittr %>%
#' @return TRUE if written, FALSE if not
#' @export
#'
#' @examples init_analytics(ga_code = "0123456789")
init_analytics <- function(ga_code) {
  is_valid_ga4_code <- function(ga_code) {
    stringr::str_length(ga_code) == 10 & typeof(ga_code) == "character"
  }

  if (is_valid_ga4_code(ga_code) == FALSE) {
    stop(
      'You have entered an invalid GA4 code in the ga_code argument.
      Please enter a 10 digit code as a character string.
      e.g. "0123QWERTY"'
    )
  }

  webpage <- getURL("https://raw.githubusercontent.com/dfe-analytical-services/dfeshiny/analytsics-init/inst/google-analytics.hml")
  html_script <- readLines(tc <- textConnection(webpage)) %>%
    gsub("XXXXXXXXXX", ga_code, .)
  close(tc)
  if (file.exists("google-analytics.html")) {
    message("Analytics file already exists.")
    message("If you have any customisations in that file, make sure you've backed
           those up before over-writing.")
    user_input <- stringr::str_trim(
    readline(
      prompt = "Are you happy to overwrite the existing analytics script (y/N) "
      )
    )
    if (user_input %in% c("y", "Y")) {
      write_out <- TRUE
    } else {
      write_out <- FALSE
    }
  } else {
    write_out <- TRUE
  }
  if (write_out) {
    cat(html_script, file = "google-analytics.html")
    message("")
    message("Google analytics script created in google-analytics.html.")
    message("You'll need to add the following line to your ui.R script to start
            recording analytics:")
    message('tags$head(includeHTML(("google-analytics.html"))),')
  } else {
    message("Original Google analytics html script left in place.")
  }
}
