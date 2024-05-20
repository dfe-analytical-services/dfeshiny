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
          shiny::tags$p("Google Analytics stores anonymised information about:"),
          shiny::tags$li("How you got to this service"),
          shiny::tags$li("The pages you visit on this service and how long you spend on them"),
          shiny::tags$li("How you interact with these pages"),
          shinyGovstyle::govTable(inputId = "ga_cookies_table",
                                  df = data.frame(Name = c("_ga", paste0("_ga_", google_analytics_key)),
                                                  Purpose = c("Used to distinguish users", "Used to persist session state"),
                                                  Expires = c("13 months", "13 month")),
                                  caption = "",
                                  caption_size = "s",
                                  num_col = NULL,
                                  width_overwrite = c("one-quarter", "one-quarter", "one-quarter")
          ),
          # shiny::tags$h2("Cookie status"),
          # shiny::textOutput(cookie_status_output),
          br(),
          #shiny::actionButton("cookie_consent_clear", "Reset cookie consent"),
          div(class = "govuk-grid-row",
              div(class = "govuk-grid-column-two-thirds",
                  h2(class = "govuk-heading-l", "Change your cookie settings"),
                  div(class = "govuk-form-group",
                      tags$fieldset(class = "govuk-fieldset",
                                    tags$legend(class = "govuk-fieldset__legend govuk-fieldset__legend--s",
                                                "Do you want to accept functional cookies?"),
                                    div(class = "govuk-radios",
                                        `data-module` = "govuk-radios",
                                        div(class = "govuk-radios__item",
                                            radioButtons("cookies_functional",
                                                         label = NULL,
                                                         choices = list("Yes" = "yes", "No" = "no"),
                                                         selected = "no",
                                                         inline = TRUE)
                                        )
                                    )
                      )
                  ),
                  div(class = "govuk-form-group",
                      tags$fieldset(class = "govuk-fieldset",
                                    tags$legend(class = "govuk-fieldset__legend govuk-fieldset__legend--s",
                                                "Do you want to accept analytics cookies?"),
                                    div(class = "govuk-radios",
                                        `data-module` = "govuk-radios",
                                        div(class = "govuk-radios__item",
                                            radioButtons("cookies_analytics",
                                                         label = NULL,
                                                         choices = list("Yes" = "yes", "No" = "no"),
                                                         selected = "no",
                                                         inline = TRUE)
                                        )
                                    )
                      )
                  ),
            actionButton("submit_btn", "Save cookie settings", class = "govuk-button")
          ),
          h3("Selected Cookie Settings:"),
          verbatimTextOutput("cookieSettings")
        )
      )
    )
  )
)
}
