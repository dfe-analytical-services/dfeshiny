#' Date validation
#'
#' @param date Element to be validated as a date
#'
#' @return String containing validation message
#'
validate_date <- function(date) {
  date_ld <- lubridate::dmy(date)
  if (is.na(date_ld)) {
    valid <- FALSE
    validation_message <- "not in a valid date format."
  } else if (date_ld > Sys.time()) {
    valid <- FALSE
    validation_message <- "is in the future."
  } else {
    valid <- TRUE
    validation_message <- "is a valid date."
  }
  if (!valid) {
    stop(paste(date, validation_message))
  }
}
