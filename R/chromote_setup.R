#' shinytest2 set up
#'
#' @description
#' This sets up chromote for use with shinytest2. We've had some issues with
#' changes to Chrome headless mode and other issues with connecting to Chrome /
#' Edge, so this aims to sidestep having to provide convoluted guidance to
#' analysts and allow them to run a single function to get set up.
#'
#' @returns NULL
#' @export
#'
#' @examples
#' shinytest2_setup()
shinytest2_setup <- function(){
  chromote::local_chrome_version(
    binary = "chrome-headless-shell",
    quiet = TRUE
  )
}
