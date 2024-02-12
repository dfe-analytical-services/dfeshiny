#' dfe_cookie_script
#'
#' @return tags$head()
#' @export
#'
#' @examples
#' dfe_cookie_script()
dfe_cookie_script <- function() {
  tags$head(
    tags$script(
      src = paste0(
        "https://cdn.jsdelivr.net/npm/js-cookie@rc/",
        "dist/js.cookie.min.js"
      )
    ),
    tags$script(src = "cookie-consent.js")
  )
}

#' cookieBannerUI
#'
#' @description
#' This function provides a cookie authorisation banner on DfE R-Shiny
#' dashboards for users to be able to accept or reject cookies. The server side
#' functionality is provided by cookieBannerServer(), whilst users will also
#' need to include the dfe_cookie_script() function in their ui.R file.
#'
#' @param id Shiny tag shared with cookieBannerServer()
#' @param name Name of the dashboard on which the cookie authorisation is being
#' applied
#'
#' @return tags$div()
#' @export
#'
#' @examples
#' cookieBannerUI("cookies", name = "My DfE R-Shiny data dashboard")
cookieBannerUI <- function(id, name = "DfE R-Shiny dashboard template") {
  tags$div(
    id = NS(id, "cookieDiv"),
    class = "govuk-cookie-banner",
    `data-nosnippet role` = "region",
    `aria-label` = "Cookies on name",
    tags$div(
      id = NS(id, "cookieMain"),
      class = "govuk-cookie-banner__message govuk-width-container",
      tags$div(
        class = "govuk-grid-row",
        tags$div(
          class = "govuk-grid-column-two-thirds",
          tags$h2(
            class = "govuk-cookie-banner__heading govuk-heading-m",
            name
          ),
          tags$div(
            class = "govuk-cookie-banner__content",
            tags$p(
              class = "govuk-body",
              "We use some essential cookies to make this service work."
            ),
            tags$p(
              class = "govuk-body",
              "We'd also like to use analytics cookies so we can understand
              how you use the service and make improvements."
            )
          )
        )
      ),
      tags$div(
        class = "govuk-button-group",
        actionButton(NS(id, "cookieAccept"), label = "Accept analytics cookies"),
        actionButton(NS(id, "cookieReject"), label = "Reject analytics cookies"),
        actionButton(NS(id, "cookieLink"), label = "View cookies")
      )
    )
  )
}

#' cookieBannerServer
#'
#' @description
#' cookieBannerServer() provides the server module to be used alongside
#' cookieBannerUI(). Place cookieBannerServer() as a call in your server.R file
#' to provide the server functions to control users being able to accept or
#' reject cookie consent for the provision of Google Analytics tracking on DfE
#' R-Shiny dashboards.
#'
#' @param id Shiny tag shared with cookieBannerUI()
#' @param input.cookies The cookie input passed from cookies.js (should always
#' be reactive(input$cookies))
#' @param input.remove The state of the cookie reset button provided by
#' dfeshiny::support_panel(). Should always be set to reactive(input$remove).
#'
#' @return NULL
#' @export
#'
#' @examples
#' cookieBannerServer("cookies", input.cookies = reactive(input$cookies), input.remove = reactive(input$remove))
cookieBannerServer <- function(id, input.cookies = NULL, input.remove = NULL) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input.cookies(), {
      if (!is.null(input.cookies())) {
        if (!("dfe_analytics" %in% names(input.cookies()))) {
          shinyjs::show(id = "cookieMain")
        } else {
          shinyjs::hide(id = "cookieMain")
          msg <- list(
            name = "dfe_analytics",
            value = input.cookies()$dfe_analytics
          )
          session$sendCustomMessage("analytics-consent", msg)
          if ("cookies" %in% names(input)) {
            if ("dfe_analytics" %in% names(input.cookies())) {
              if (input.cookies()$dfe_analytics == "denied") {
                ga_msg <- list(name = paste0("_ga_", google_analytics_key))
                session$sendCustomMessage("cookie-remove", ga_msg)
              }
            }
          }
        }
      } else {
        shinyjs::hide(id = "cookieMain", asis = TRUE)
        shinyjs::toggle(id = "cookieDiv", asis = TRUE)
      }
    })

    # Check for the cookies being authorised
    observeEvent(input$cookieAccept, {
      msg <- list(
        name = "dfe_analytics",
        value = "granted"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookieMain", asis = TRUE)
      shinyjs::show(id = "cookieAcceptDiv", asis = TRUE)
    })

    # Check for the cookies being rejected
    observeEvent(input$cookieReject, {
      msg <- list(
        name = "dfe_analytics",
        value = "denied"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookieMain", asis = TRUE)
      shinyjs::show(id = "cookieRejectDiv", asis = TRUE)
    })

    observeEvent(input$cookieLink, {
      # Need to link here to where further info is located.  You can
      # updateTabsetPanel to have a cookie page for instance
      updateTabsetPanel(session, "navlistPanel", selected = "Support and feedback")
    })

    observeEvent(input.remove(), {
      shinyjs::toggle(id = "cookieMain")
      msg <- list(name = "dfe_analytics", value = "denied")
      session$sendCustomMessage("cookie-remove", msg)
      session$sendCustomMessage("analytics-consent", msg)
    })
  })
}
