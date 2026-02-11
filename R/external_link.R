#' External link
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' A wrapper around `shinyGovstyle::external_link()`, preserving the function
#' here in dfeshiny for backwards compatibility in upcoming versions only.
#'
#' All logic and documentation is now in `shinyGovstyle::external_link()`, so
#' please refer to that function for more information, and update your code
#' to use that function directly.
#'
#' @param ... Arguments passed to `shinyGovstyle::external_link()`.
#'
#' @return The result of `shinyGovstyle::external_link(...)`.
#'
#' @seealso [shinyGovstyle::external_link()]
#' @export
external_link <- function(...) {
  # TODO: In v1.0.0 move this to lifecycle::deprecate_stop()
  # forcing users to update their code to use the new function
  lifecycle::deprecate_warn(
    "1.0.0",
    "external_link()",
    "shinyGovstyle::external_link()"
  )
  shinyGovstyle::external_link(...)
}
