#' Cookies panel
#'
#' @description
#' Create the standard DfE R-Shiny cookies dashboard panel.
#'
#' @param cookie_status_output Name of cookie status output object, often
#' "cookie_status"
#'
#' @return a standardised panel for a public R Shiny dashboard in DfE
#' @export
#'
#' @examples
#' cookies_panel(
#'   cookie_status_output = "cookie_status"
#' )
cookies_panel <- function(
    cookie_status_output = "cookie_status") {
  # Build the support page ----------------------------------------------------
  shiny::tabPanel(
    value = "cookies_panel",
    "Cookies",
    shinyGovstyle::gov_main_layout(
      shinyGovstyle::gov_row(
        shiny::column(
          width = 12,
          shiny::tags$h1("Cookies"),
          shiny::tags$h2("Essential cookies"),
          shiny::tags$h2("Analytics cookies"),
          shiny::tags$h2("Use of cookies"),
          shiny::tags$p("To better understand the reach of our dashboard tools,
            this site uses cookies to identify numbers of unique users
            as part of Google Analytics."),
          shiny::textOutput(cookie_status_output),
          shiny::actionButton("cookie_consent_clear", "Reset cookie consent"),
        )
      )
    )
  )
}
