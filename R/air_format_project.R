#' Air Format Project
#'
#' @description formats the whole project or single file using air
#'
#' @param target single file target for formatting
#'
#' @export
#'
#' @examples
#' \dontrun{
#' air_format_project()
#' }

air_format_project <- function(target = ".") {
  # check air is installed
  if ("air" %in% system("ls ~/.config/.", intern = TRUE)) {
    if (target == ".") {
      system(
        "air format ."
      )
    } else {
      if (file.exists(target)) {
        # ignore warnings due to restricted areas
        path <- suppressWarnings(system(
          "find / -name air 2>/dev/null",
          intern = TRUE
        )[1])
        system(
          paste0(path, " format ", target)
        )
      } else {
        message(paste0("Target file ", target, " does not exist"))
      }
    }
  } else {
    message("air not installed, run install_air() before formatting again")
  }
}
