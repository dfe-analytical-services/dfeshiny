#' init_analytics
#'
#' @description
#' Creates the google-analytics.html script in order to allow the activation of
#' analytics via GA4. For the full steps required to set up analytics, please
#' refer to the documentation in the README.
#'
#' @param ga_code The Google Analytics code for the dashboard
#' @param create_file Boolean TRUE or FALSE, default is TRUE, false will return
#' the HTML as a character vector and used mainly for testing or comparisons
#'
#' @importFrom magrittr %>%
#' @return TRUE if written, FALSE if not, character vector of HTML if create_file = FALSE
#' @export
#'
#' @examples init_analytics(ga_code = "0123456789")
init_analytics <- function(ga_code, create_file = TRUE) {
  if(!is.logical(create_file)) {
    stop('create_file must always be TRUE or FALSE')
  }

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

  github_area <- "https://raw.githubusercontent.com/dfe-analytical-services/"
  webpage <- RCurl::getURL(
    paste0(
      github_area,
      "dfeshiny/main/inst/google-analytics.html"
    )
  )
  tryCatch(
    html_script <- gsub(
      "XXXXXXXXXX",
      ga_code,
      readLines(tc <- textConnection(webpage))
    ),
    error = function(e) {
      return("Download failed")
    },
    message("Downloaded analytics template script")
  )

  close(tc)

  if(create_file == FALSE){
    # Just return without options or messages
    html_script
  } else {
    if (file.exists("google-analytics.html")) {
      message("Analytics file already exists.")
      message("If you have any customisations in that file, make sure you've
    backed those up before over-writing.")
      user_input <- readline(
        prompt = "Are you happy to overwrite the existing analytics script (y/N) "
      ) |>
        stringr::str_trim()
      if (user_input %in% c("y", "Y")) {
        write_out <- TRUE
      } else {
        write_out <- FALSE
      }
    } else {
      write_out <- TRUE
    }
    if (write_out) {
      cat(html_script, file = "google-analytics.html", sep = "\n")
      message("")
      message("Google analytics script created as google-analytics.html.")
      message("You'll need to add the following line to your ui.R script to start using analytics:")
      message("tags$head(includeHTML((google-analytics.html))),")
    } else {
      message("Original Google analytics html script left in place.")
    }
  }
}
