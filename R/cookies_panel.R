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
          shiny::tags$p("Cookies are small files saved on your phone, tablet or computer when you visit a website."),
          shiny::tags$p("We use cookies to collect information about how you use our service."),
          shiny::tags$h2("Essential cookies"),
          shinyGovstyle::govTable(inputId = "essential_cookies_table",
            df = data.frame(Name = "dfe_analytics",
                       Purpose = "Saves your cookie consent settings",
                       Expires = "365 days"),
            caption = "",
            caption_size = "s",
            num_col = NULL,
            width_overwrite = c("one-quarter", "one-quarter", "one-quarter")
          ),
          shiny::tags$h2("Analytics cookies"),
          shiny::tags$p("With your permission, we use Google Analytics to collect data about how you use this service. This information helps us improve our service"),
          shiny::tags$p("Google is not allowed to share our analytics data with anyone."),
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
