#' cookies_panel_ui
#'
#' @description
#' Create the standard DfE R-Shiny cookies dashboard panel in the ui. The server
#' side functionality is provided by cookies_panel_server()
#'
#' @param cookie_status_output Name of cookie status output object, often
#' "cookie_status"
#' @param id ID shared with cookies_panel_server()
#'
#' @return a standardised panel for a public R Shiny dashboard in DfE
#' @export
#'
#' @examples
#' \dontrun{
#' cookies_panel_ui(
#'   "cookies_panel",
#'   cookie_status_output = "cookie_status"
#' )
#' }
cookies_panel_ui <- function(
    id, cookie_status_output = "cookie_status") {
  # Build the support page ----------------------------------------------------
  shiny::tabPanel(
    id = shiny::NS(id, "cookies_panel"),
    value = "cookies_panel_ui",
    "Cookies",
    shinyGovstyle::gov_main_layout(
      shinyGovstyle::gov_row(
        shiny::column(
          width = 12,
          shiny::tags$h1("Cookies"),
          shiny::tags$p("Cookies are small files saved on your phone, tablet or
                        computer when you visit a website."),
          shiny::tags$p("We use cookies to collect information about how you
                        use our service."),
          shiny::tags$h2("Essential cookies"),
          shinyGovstyle::govTable(
            inputId = "essential_cookies_table",
            df = data.frame(
              Name = "dfe_analytics",
              Purpose = "Saves your cookie consent settings",
              Expires = "365 days"
            ),
            caption = "",
            caption_size = "s",
            num_col = NULL,
            width_overwrite = c("one-quarter", "one-quarter", "one-quarter")
          ),
          shiny::tags$h2("Analytics cookies"),
          shiny::tags$p("With your permission, we use Google Analytics to
                        collect data about how you use this service. This
                        information helps us improve our service"),
          shiny::tags$p("Google is not allowed to share our analytics data with
                        anyone."),
          shiny::tags$p("Google Analytics stores anonymised information about:"),
          shiny::tags$li("How you got to this service"),
          shiny::tags$li("The pages you visit on this service and how long you
                         spend on them"),
          shiny::tags$li("How you interact with these pages"),
          shinyGovstyle::govTable(
            inputId = "ga_cookies_table",
            df = data.frame(
              Name = c("_ga", paste0("_ga_", google_analytics_key)),
              Purpose = c("Used to distinguish users", "Used to persist
                          session state"),
              Expires = c("13 months", "13 months")
            ),
            caption = "",
            caption_size = "s",
            num_col = NULL,
            width_overwrite = c("one-quarter", "one-quarter", "one-quarter")
          ),
          br(),
          div(
            class = "govuk-grid-row",
            div(
              class = "govuk-grid-column-two-thirds",
              h2(class = "govuk-heading-l", "Change your cookie settings"),
              div(
                class = "govuk-form-group",
              ),
              div(
                class = "govuk-form-group",
                tags$fieldset(
                  class = "govuk-fieldset",
                  tags$legend(
                    class = "govuk-fieldset__legend govuk-fieldset__legend--s",
                    "Do you want to accept analytics cookies?"
                  ),
                  div(
                    class = "govuk-radios",
                    `data-module` = "govuk-radios",
                    div(
                      class = "govuk-radios__item",
                      radioButtons(NS(id, "cookies_analytics"),
                        label = NULL,
                        choices = list("Yes" = "yes", "No" = "no"),
                        selected = "no",
                        inline = TRUE
                      )
                    )
                  )
                )
              ),
              actionButton(NS(id, "submit_btn"), "Save cookie settings",
                class = "govuk-button"
              )
            )
          )
        )
      )
    )
  )
}

#' cookies_panel_server
#'
#' @description
#' Create the server module of DfE R-Shiny cookies dashboard panel to be used
#' alongside cookies_panel_ui().
#'
#' @param id ID shared with cookies_panel_ui()
#'
#' @export
#'
#' @examples
#' \dontrun{
#' cookies_panel_server(
#'   "cookies_panel",
#'   input_cookies = reactive(input$cookies),
#'   google_analytics_key = "ABCDE12345"
#' )
#' }
cookies_panel_server <- function(
    id,
    input_cookies,
    google_analytics_key = NULL) {
  shiny::moduleServer(id, module = function(input, output, session) {

    shiny::observeEvent(input_cookies(), {
      if (!is.null(input_cookies())) {
        message("Found input cookies")
        if (!("dfe_analytics" %in% names(input_cookies()))) {
          message("updating radio button to no")
          updateRadioButtons(session, "cookies_analytics", selected = "no")
        } else {
          print(input_cookies())
              message("Found permission cookie")
              if (input_cookies()$dfe_analytics == "denied") {
                message("updating radio button to no (2)")
                updateRadioButtons(session, "cookies_analytics", selected = "no")
              } else if (input_cookies()$dfe_analytics == "granted"){
                message("updating radio button to yes")
                updateRadioButtons(session, "cookies_analytics", selected = "yes")
              }
        }
      }
    })

    # Observe form submission button
    observeEvent(input$submit_btn, {
      # Update reactive values based on the selected radio buttons
      if(input$cookies_analytics == "yes"){
        msg <- list(
          name = "dfe_analytics",
          value = "granted"
        )
      } else if(input$cookies_analytics == "no"){
        msg <- list(
          name = "dfe_analytics",
          value = "denied"
        )
        ga_msg <- list(name = paste0("_ga_", google_analytics_key))
        session$sendCustomMessage("cookie-clear", ga_msg)
      }
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
    })
  })
}
