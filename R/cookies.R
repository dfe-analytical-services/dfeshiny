#' dfe_cookie_script
#'
#' Calls in JavaScript dependencies to the shiny app used to set and unset the
#' cookies. Function should be placed in the ui.R script.
#'
#' @name cookies
#' @return shiny::tags$head()
#' @export
#'
#' @family cookies
#' @examples
#' if (interactive()) {
#'   # This example shows how to use the full family of cookie functions together
#'   # This will be in your global.R script =====================================
#'
#'   library(shiny)
#'   library(shinyjs)
#'   library(dfeshiny)
#'   ga_key <- "ABCDE12345"
#'
#'   # This will be what is in your ui.R script =================================
#'
#'   ui <- fluidPage(
#'     # Place these lines above your header ------------------------------------
#'     dfe_cookie_script(),
#'     useShinyjs(),
#'     cookie_banner_ui(name = "My DfE R-Shiny data dashboard"),
#'
#'     # Place the cookies panel under the header but in the main content -------
#'     cookies_panel_ui(google_analytics_key = ga_key)
#'   )
#'
#'   # This will be in your server.R file =======================================
#'
#'   server <- function(input, output, session) {
#'     # Server logic for the pop up banner, can be placed anywhere in server.R -
#'     output$cookie_status <- dfeshiny::cookie_banner_server(
#'       input_cookies = reactive(input$cookies),
#'       google_analytics_key = ga_key
#'     )
#'
#'     # Server logic for the panel, can be placed anywhere in server.R ---------
#'     cookies_panel_server(
#'       input_cookies = reactive(input$cookies),
#'       google_analytics_key = ga_key
#'     )
#'   }
#'
#'   # How to run the minimal app given in this example =========================
#'   shinyApp(ui, server)
#' }
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
#' @param id Shiny tag shared with cookie_banner_server(), can be any string set
#' by the user as long as it matches the id in the cookie_banner_server()
#' @param name Name of the dashboard on which the cookie authorisation is being
#' applied
#'
#' @family cookies
#' @return shiny::tags$div()
#' @export
#' @inherit cookies examples
cookie_banner_ui <- function(id = "cookies_banner", name = "DfE R-Shiny dashboard template") {
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
#' @param id Shiny tag shared with cookie_banner_ui(), can be any string set by
#' the user as long as it matches the id in the cookie_banner_ui()
#' @param input_cookies The cookie input passed from cookies.js (should always
#' be `reactive(input$cookies)`)
#' @param parent_session This should be the R Shiny app session
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#' @param cookie_link_panel name of the navlistPanel that the cookie banner
#' provides a link to, usually "cookies_panel_ui"
#'
#' @family cookies
#' @return NULL
#' @export
#'
#' @inherit cookies examples
cookie_banner_server <- function(
    id = "cookies_banner",
    input_cookies = reactive(input$cookies),
    parent_session = session,
    google_analytics_key = NULL,
    cookie_link_panel = "cookies_panel_ui") {
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
        selected = cookie_link_panel
      )
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

#' init_cookies
#'
#' @description
#' init_cookies() creates a local copy of the JavaScript file
#' required for cookies to work.
#' It checks whether there is already a www/ folder and if not, it creates one.
#' It then checks whether the cookie-consent.js file exists in the www/ folder.
#' If the file exists, it will print a message in the console to let you know.
#' If the file doesn't exist, it will pull a copy from the GitHub repo.
#' If it cannot connect to the repo then it will print "Download failed".
#' No input parameters are required
#' Call init_cookies() in the console to run the function
#'
#' @return NULL
#' @export
#'
#' @examples
#' if (interactive()) {
#'   init_cookies()
#' }
init_cookies <- function() {
  sub_dir <- "www"

  output_dir <- file.path(sub_dir)

  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  } else {
    message("www folder already exists!")
  }

  tryCatch(
    download.file(url = "https://raw.githubusercontent.com/dfe-analytical-services/dfeshiny/main/inst/cookie-consent.js", destfile = "www/cookie-consent.js"), # nolint: [line_length_linter]
    error = function(e) {
      return("Download failed")
    },
    message("Cookie script updated")
  )
}

#' cookies_panel_ui
#'
#' @description
#' Create the standard DfE R-Shiny cookies dashboard panel in the ui. The server
#' side functionality is provided by cookies_panel_server()
#'
#' @param id Shiny tag shared with cookies_panel_server(), can be any string set by
#' the user as long as it matches the id in the cookies_panel_server()
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#'
#' @return a standardised panel for a public R Shiny dashboard in DfE
#' @export
#' @inherit cookies examples
cookies_panel_ui <- function(id = "cookies_panel", google_analytics_key = NULL) {
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
          shiny::tags$p("Google Analytics stores anonymised information
                        about:"),
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
          shiny::br(),
          shiny::tags$div(
            class = "govuk-grid-row",
            shiny::tags$div(
              class = "govuk-grid-column-two-thirds",
              shiny::tags$h2(
                class = "govuk-heading-l",
                "Change your cookie settings"
              ),
              shiny::tags$div(
                class = "govuk-form-group",
              ),
              shiny::tags$div(
                class = "govuk-form-group",
                tags$fieldset(
                  class = "govuk-fieldset",
                  tags$legend(
                    class = "govuk-fieldset__legend govuk-fieldset__legend--s",
                    "Do you want to accept analytics cookies?"
                  ),
                  shiny::tags$div(
                    class = "govuk-radios",
                    `data-module` = "govuk-radios",
                    shiny::tags$div(
                      class = "govuk-radios__item",
                      shiny::radioButtons(shiny::NS(id, "cookies_analytics"),
                        label = NULL,
                        choices = list("Yes" = "yes", "No" = "no"),
                        selected = "no",
                        inline = TRUE
                      )
                    )
                  )
                )
              ),
              shiny::actionButton(shiny::NS(id, "submit_btn"),
                "Save cookie settings",
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
#' @param id Shiny tag shared with cookies_panel_ui(), can be any string set by
#' the user as long as it matches the id in the cookies_panel_ui()
#' @param input_cookies The cookie input passed from cookies.js (should always
#' be `reactive(input$cookies))`
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#'
#' @export
#' @inherit cookies examples
cookies_panel_server <- function(id = "cookies_panel",
                                 input_cookies = reactive(input$cookies),
                                 google_analytics_key = NULL) {
  shiny::moduleServer(id, module = function(input, output, session) {
    shiny::observeEvent(input_cookies(), {
      if (!is.null(input_cookies())) {
        if (!("dfe_analytics" %in% names(input_cookies()))) {
          shiny::updateRadioButtons(session, "cookies_analytics",
            selected = "no"
          )
        } else {
          if (input_cookies()$dfe_analytics == "denied") {
            shiny::updateRadioButtons(session, "cookies_analytics",
              selected = "no"
            )
          } else if (input_cookies()$dfe_analytics == "granted") {
            shiny::updateRadioButtons(session, "cookies_analytics",
              selected = "yes"
            )
          }
        }
      }
    })

    # Observe form submission button
    shiny::observeEvent(input$submit_btn, {
      # Update reactive values based on the selected radio buttons
      if (input$cookies_analytics == "yes") {
        msg <- list(
          name = "dfe_analytics",
          value = "granted"
        )
      } else if (input$cookies_analytics == "no") {
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
