#' dfe_cookie_script
#'
#' Calls in JavaScript dependencies to the shiny app. Function should be placed
#' in the ui.R script.
#'
#' @name cookies
#' @return shiny::tags$head()
#' @export
#'
#' @family cookies
#' @examples
#' # This will be in your global.R script
#'
#' library(shiny)
#' library(shinyjs)
#' library(dfeshiny)
#'
#' # This will be what is in your ui.R script
#'
#' ui <- fluidPage(
#'   # Place these lines above your header
#'
#'   dfe_cookie_script(),
#'   useShinyjs(),
#'   cookie_banner_ui("cookies", name = "My DfE R-Shiny data dashboard"),
#'
#'   # Use the cookies panel under the head but in the main content
#'
#'   cookies_panel()
#' )
#'
#' # This will be in your server.R file
#'
#' server <- function(input, output, session) {
#'   output$cookie_status <- dfeshiny::cookie_banner_server(
#'     "cookies",
#'     input_cookies = reactive(input$cookies),
#'     input_clear = reactive(input$cookie_consent_clear),
#'     parent_session = session,
#'     google_analytics_key = "ABCDE12345"
#'   )
#' }
#'
#' # This is just an example of how to run the minimal app in this example
#' if (interactive()) {
#'   shinyApp(ui, server)
#' }
#'
dfe_cookie_script <- function() {
  shiny::tags$head(
    shiny::tags$script(
      src = paste0(
        "https://cdn.jsdelivr.net/npm/js-cookie@rc/",
        "dist/js.cookie.min.js"
      )
    ),
    shiny::tags$script(src = "cookie-consent.js") # Tried using a copy in the
    # repo here, but it all stopped working at that point.
  )
}

#' cookie_banner_ui
#'
#' @description
#' This function provides a cookie authorisation banner on DfE R-Shiny
#' dashboards for users to be able to accept or reject cookies. The server side
#' functionality is provided by cookie_banner_server(), whilst users will also
#' need to include the dfe_cookie_script() function in their ui.R file.
#'
#' @param id Shiny tag shared with cookie_banner_server()
#' @param name Name of the dashboard on which the cookie authorisation is being
#' applied
#'
#' @family cookies
#' @return shiny::tags$div()
#' @export
#' @inherit cookies examples
cookie_banner_ui <- function(id, name = "DfE R-Shiny dashboard template") {
  shiny::tags$div(
    id = shiny::NS(id, "cookie_div"),
    class = "govuk-cookie-banner",
    `data-nosnippet role` = "region",
    `aria-label` = "Cookies on name",
    shiny::tags$div(
      id = shiny::NS(id, "cookie_main"),
      class = "govuk-cookie-banner__message govuk-width-container",
      shiny::tags$div(
        class = "govuk-grid-row",
        shiny::tags$div(
          class = "govuk-grid-column-two-thirds",
          shiny::tags$h2(
            class = "govuk-cookie-banner__heading govuk-heading-m",
            name
          ),
          shiny::tags$div(
            class = "govuk-cookie-banner__content",
            shiny::tags$p(
              class = "govuk-body",
              "We use some essential cookies to make this service work."
            ),
            shiny::tags$p(
              class = "govuk-body",
              "We'd also like to use analytics cookies so we can understand
              how you use the service and make improvements."
            )
          )
        )
      ),
      shiny::tags$div(
        class = "govuk-button-group",
        shinyGovstyle::button_Input(
          shiny::NS(id, "cookie_accept"),
          "Accept analytics cookies"
        ),
        shinyGovstyle::button_Input(
          shiny::NS(id, "cookie_reject"),
          "Reject analytics cookies"
        ),
        shiny::actionLink(
          shiny::NS(id, "cookie_link"),
          "View cookie information"
        )
      )
    )
  )
}

#' cookie_banner_server
#'
#' @description
#' cookie_banner_server() provides the server module to be used alongside
#' cookie_banner_ui(). Place cookie_banner_server() as a call in your server.R
#' file to provide the server functions to control users being able to accept or
#' reject cookie consent for the provision of Google Analytics tracking on DfE
#' R-Shiny dashboards.
#'
#' @param id Shiny tag shared with cookie_banner_ui()
#' @param input_cookies The cookie input passed from cookies.js (should always
#' be reactive(input$cookies))
#' @param input_clear The state of the cookie reset button provided by
#' dfeshiny::support_panel().
#' Should always be set to reactive(input$cookie_consent_clear).
#' @param parent_session This should be the R Shiny app session
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#'
#' @family cookies
#' @return NULL
#' @export
#'
#' @inherit cookies examples
cookie_banner_server <- function(
    id,
    input_cookies,
    input_clear,
    parent_session,
    google_analytics_key = NULL) {
  shiny::moduleServer(id, function(input, output, session) {
    if (is.null(google_analytics_key)) {
      warning("Please provide a valid Google Analytics key")
    }
    shiny::observeEvent(input_cookies(), {
      if (!is.null(input_cookies())) {
        if (!("dfe_analytics" %in% names(input_cookies()))) {
          shinyjs::show(id = "cookie_main")
        } else {
          shinyjs::hide(id = "cookie_main")
          msg <- list(
            name = "dfe_analytics",
            value = input_cookies()$dfe_analytics
          )
          session$sendCustomMessage("analytics-consent", msg)
          if ("cookies" %in% names(input)) {
            if ("dfe_analytics" %in% names(input_cookies())) {
              if (input_cookies()$dfe_analytics == "denied") {
                ga_msg <- list(name = paste0("_ga_", google_analytics_key))
                session$sendCustomMessage("cookie-clear", ga_msg)
              }
            }
          }
        }
      } else {
        shinyjs::hide(id = "cookie_main", asis = TRUE)
        shinyjs::toggle(id = "cookie_div", asis = TRUE)
      }
    })

    # Check for the cookies being authorised
    shiny::observeEvent(input$cookie_accept, {
      msg <- list(
        name = "dfe_analytics",
        value = "granted"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookie_main", asis = TRUE)
    })

    # Check for the cookies being rejected
    shiny::observeEvent(input$cookie_reject, {
      msg <- list(
        name = "dfe_analytics",
        value = "denied"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookie_main", asis = TRUE)
    })

    shiny::observeEvent(input$cookie_link, {
      # Need to link here to where further info is located.  You can
      # updateTabsetPanel to have a cookie page for instance
      shiny::updateTabsetPanel(
        session = parent_session,
        "navlistPanel",
        selected = "support_panel"
      )
    })

    shiny::observeEvent(input_clear(), {
      shinyjs::toggle(id = "cookie_main")
      msg <- list(name = "dfe_analytics", value = "denied")
      session$sendCustomMessage("cookie-clear", msg)
      session$sendCustomMessage("analytics-consent", msg)
    })

    return(shiny::renderText({
      cookie_text_stem <- "You have chosen to"
      cookie_text_tail <- "the use of cookies on this website."
      if (!is.null(input_cookies())) {
        if ("dfe_analytics" %in% names(input_cookies())) {
          if (input_cookies()$dfe_analytics == "granted") {
            paste(cookie_text_stem, "accept", cookie_text_tail)
          } else {
            paste(cookie_text_stem, "reject", cookie_text_tail)
          }
        }
      } else {
        "Cookies consent has not been confirmed."
      }
    }))
  })
}
