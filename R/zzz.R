#' Adds the content of www to dfeshiny/
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('dfeshiny',
                         system.file('www', package = 'dfeshiny')
  )
}
