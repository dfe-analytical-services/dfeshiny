#' Air Format Project
#'
#' @description formats the whole project using air
#'
#'
#' @examples
#' \dontrun{
#' air_format_project()
#' }

air_format_project <- function() {
  # check air is installed
  if ("air" %in% system("ls ~/.config/.", intern = TRUE)) {
    system(
      "air format ."
    )
  } else {
    message("air not installed, run install_air() before formatting again")
  }
}
