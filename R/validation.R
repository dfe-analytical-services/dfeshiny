#' Date validation
#'
#' @param date Element to be validated as a date
#'
#' @return String containing validation message
#'
validate_date <- function(date){
  date.ld <- lubridate::dmy(date)
  if(is.na(date.ld)){
    validation_message <- "not in a valid date format."
  } else if (date.ld > Sys.time()){
    validation_message <- "is in the future."
  } else {
    validation_message <- "is a valid date."
  }
  return(validation_message)
}
