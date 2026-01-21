#' deps_shinytest2
#'
#' @description
#' This function installs the dependencies required by shinytest2.
#'
#' @return NULL
#'
#' @export
#' @examples
#' if (interactive()) {
#'   deps_shinytest2()
#' }
deps_shinytest2 <- function() {
  chromote::local_chrome_version(binary = "chrome-headless-shell", quiet = TRUE)
  if (system.file(package = 'diffviewer') != "") {
    install.packages("diffviewer")
  }
}
