#' Air Format Project
#'
#' @description formats the whole project using air
#'
#' @examples
#' \dontrun{
#' air_format_project()
#' }

air_format_project <- function() {
  # check air is installed
  if ("air" %in% system("ls ~/.config/.", intern = TRUE)) {
    message("installed")
  } else {
    message("air not installed, installing now")
    dfeshiny::install_air()
  }

  system(
    "air format ."
  )
}
