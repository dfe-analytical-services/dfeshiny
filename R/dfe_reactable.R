#' Department for Education Reactable Wrapper
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' A wrapper around `shinyGovstyle::govReactable()`, preserving the function
#' here in dfeshiny for backwards compatibility in upcoming versions only.
#'
#' All logic and documentation is now in `shinyGovstyle::govReactable()`, so
#' please refer to that function for more information, and update your code
#' to use that function directly.
#'
#' @param data A data frame to display in the table.
#' @param ... Arguments passed to `shinyGovstyle::govReactable()`.
#'
#' @return The result of `shinyGovstyle::govReactable(...)`.
#'
#' @seealso [shinyGovstyle::govReactable()]
dfe_reactable <- function(data, ...) {
  # TODO: In v1.0.0 move this to lifecycle::deprecate_stop()
  # forcing users to update their code to use the new function
  lifecycle::deprecate_warn(
    "0.6.0",
    "dfe_reactable()",
    "shinyGovstyle::govReactable()"
  )
  shinyGovstyle::govReactable(data, ...)
}
