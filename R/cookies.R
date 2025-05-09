#' dfe_cookies_script
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
#'   # This example shows how to use the full family of cookies functions together
#'   # This will be in your global.R script ===================================
#'
#'   library(shiny)
#'   library(shinyjs)
#'   library(dfeshiny)
#'   google_analytics_key <- "ABCDE12345"
#'
#'   # This will be what is in your ui.R script ===============================
#'
#'   ui <- fluidPage(
#'     # Place these lines above your header ----------------------------------
#'     useShinyjs(),
#'     dfe_cookies_script(),
#'     cookies_banner_ui(name = "My DfE R-Shiny data dashboard"),
#'
#'     # Place the cookies panel under the header but in the main content -----
#'     # Example of placing as a panel within navlistPanel
#'     shiny::navlistPanel(
#'       "",
#'       id = "navlistPanel",
#'       widths = c(2, 8),
#'       well = FALSE,
#'       ## Cookies panel -----------------------------------------------------
#'       shiny::tabPanel(
#'         value = "cookies_panel_ui",
#'         "Cookies",
#'         cookies_panel_ui(google_analytics_key = google_analytics_key)
#'       )
#'     )
#'   )
#'
#'   # This will be in your server.R file =====================================
#'
#'   server <- function(input, output, session) {
#'     # Server logic for the pop up banner, can be placed anywhere in server.R -
#'     output$cookies_status <- dfeshiny::cookies_banner_server(
#'       input_cookies = reactive(input$cookies),
#'       google_analytics_key = google_analytics_key,
#'       parent_session = session
#'     )
#'
#'     # Server logic for the panel, can be placed anywhere in server.R -------
#'     cookies_panel_server(
#'       input_cookies = reactive(input$cookies),
#'       google_analytics_key = google_analytics_key
#'     )
#'   }
#'
#'   # How to run the minimal app given in this example =======================
#'   shinyApp(ui, server)
#' }
dfe_cookies_script <- function() {
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

#' cookies_banner_ui
#'
#' @description
#' This function provides a cookie authorisation banner on DfE R-Shiny
#' dashboards for users to be able to accept or reject cookies. The server side
#' functionality is provided by cookies_banner_server(), whilst users will also
#' need to include the dfe_cookies_script() function in their ui.R file.
#'
#' @param id Shiny tag shared with cookies_banner_server(), can be any string set
#' by the user as long as it matches the id in the cookies_banner_server()
#' @param name Name of the dashboard on which the cookie authorisation is being
#' applied
#'
#' @family cookies
#' @return shiny::tags$div()
#' @export
#' @inherit cookies examples
cookies_banner_ui <- function(
  id = "cookies_banner",
  name = "DfE R-Shiny dashboard template"
) {
  # Attach CSS from inst/www/css/cookie-banner.css
  dependency <- htmltools::htmlDependency(
    name = "cookie-banner",
    version = as.character(utils::packageVersion("dfeshiny")[[1]]),
    src = c(href = "dfeshiny/css"),
    stylesheet = "cookie-banner.css"
  )
  shiny::tags$div(
    id = shiny::NS(id, "cookies_div"),
    class = "govuk-cookie-banner",
    `data-nosnippet role` = "region",
    `aria-label` = "Cookies on name",
    shiny::tags$div(
      id = shiny::NS(id, "cookies_main"),
      class = "govuk-cookie-banner__message govuk-width-container",
      shiny::tags$div(
        class = "govuk-grid-row",
        shiny::tags$div(
          class = "govuk-grid-column-two-thirds",
          shiny::tags$div(
            class = "govuk-cookie-banner__content",
            shiny::tags$h2(
              class = "govuk-cookie-banner__heading govuk-heading-m",
              name
            ),
            shiny::tags$p(
              class = "govuk-body",
              "We use some essential cookies to make this service work."
            ),
            shiny::tags$p(
              class = "govuk-body",
              "We'd also like to use analytics cookies so we can understand
              how you use the service and make improvements."
            ),
            shiny::tags$p(
              class = "govuk-body",
              shiny::actionLink(
                shiny::NS(id, "cookies_link"),
                "View cookie information"
              )
            ),
            shiny::tags$div(
              class = "govuk-button-group",
              shinyGovstyle::button_Input(
                shiny::NS(id, "cookies_accept"),
                "Accept analytics cookies"
              ),
              shinyGovstyle::button_Input(
                shiny::NS(id, "cookies_reject"),
                "Reject analytics cookies"
              )
            )
          )
        )
      )
    )
  ) |>
    htmltools::attachDependencies(dependency, append = TRUE)
}

#' cookies_banner_server
#'
#' @description
#' cookies_banner_server() provides the server module to be used alongside
#' cookies_banner_ui(). Place cookies_banner_server() as a call in your server.R
#' file to provide the server functions to control users being able to accept or
#' reject cookie consent for the provision of Google Analytics tracking on DfE
#' R-Shiny dashboards.
#'
#' @param id Shiny tag shared with cookies_banner_ui(), can be any string set by
#' the user as long as it matches the id in the cookies_banner_ui()
#' @param input_cookies The cookie input passed from cookies.js (should always
#' be `reactive(input$cookies)`)
#' @param parent_session This should be the R Shiny app session, expect it to
#' always be `parent_session = session`
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#' @param cookies_link_panel name of the navigation panel that the cookie banner
#' provides a link to, usually "cookies_panel_ui"
#' @param cookies_nav_id ID of the navigation panel the cookie panel page is
#' within, defaults to "navlistPanel"
#'
#' @family cookies
#' @return NULL
#' @export
#'
#' @inherit cookies examples
cookies_banner_server <- function(
  id = "cookies_banner",
  input_cookies,
  parent_session,
  google_analytics_key = NULL,
  cookies_link_panel = "cookies_panel_ui",
  cookies_nav_id = "navlistPanel"
) {
  shiny::moduleServer(id, function(input, output, session) {
    if (is.null(google_analytics_key)) {
      warning("Please provide a valid Google Analytics key")
    }
    shiny::observeEvent(input_cookies(), {
      if (!is.null(input_cookies())) {
        if (!("dfe_analytics" %in% names(input_cookies()))) {
          shinyjs::show(id = "cookies_main")
        } else {
          shinyjs::hide(id = "cookies_main")
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
        shinyjs::hide(id = "cookies_main", asis = TRUE)
        shinyjs::toggle(id = "cookies_div", asis = TRUE)
      }
    })

    # Check for the cookies being authorised
    shiny::observeEvent(input$cookies_accept, {
      msg <- list(
        name = "dfe_analytics",
        value = "granted"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookies_main", asis = TRUE)
    })

    # Check for the cookies being rejected
    shiny::observeEvent(input$cookies_reject, {
      msg <- list(
        name = "dfe_analytics",
        value = "denied"
      )
      session$sendCustomMessage("cookie-set", msg)
      session$sendCustomMessage("analytics-consent", msg)
      shinyjs::hide(id = "cookies_main", asis = TRUE)
    })

    shiny::observeEvent(input$cookies_link, {
      # Need to link here to where further info is located.  You can
      # updateTabsetPanel to have a cookie page for instance
      shiny::updateTabsetPanel(
        session = parent_session,
        inputId = cookies_nav_id,
        selected = cookies_link_panel
      )
    })

    return(shiny::renderText({
      cookies_text_stem <- "You have chosen to"
      cookies_text_tail <- "the use of cookies on this website."
      if (!is.null(input_cookies())) {
        if ("dfe_analytics" %in% names(input_cookies())) {
          if (input_cookies()$dfe_analytics == "granted") {
            paste(cookies_text_stem, "accept", cookies_text_tail)
          } else {
            paste(cookies_text_stem, "reject", cookies_text_tail)
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
#' init_cookies() creates a local copy of the JavaScript file required for
#' cookies to work. It checks whether there is already a www/ folder and if
#' not, it creates one. It then checks whether the cookie-consent.js file
#' exists in the www/ folder. If the file exists, it will print a message in
#' the console to let you know it has overwritten it. If the file doesn't
#' exist, it will make one and confirm it has done so.
#'
#' No input parameters are required, run `init_cookies()` in the console to run
#' the function
#'
#' @param create_file Boolean, TRUE by default, if FALSE then will print to
#' the console rather than create a new file
#'
#' @return NULL
#' @export
#'
#' @examples
#' if (interactive()) {
#'   init_cookies()
#' }
init_cookies <- function(create_file = TRUE) {
  if (!is.logical(create_file)) {
    stop("create_file must always be TRUE or FALSE")
  }

  # Create the JS for the file ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  cookie_js <- "function getCookies(){
  var res = Cookies.get();
  Shiny.setInputValue('cookies', res);
}

Shiny.addCustomMessageHandler('cookie-set', function(msg){
  Cookies.set(msg.name, msg.value);
  getCookies();
})

Shiny.addCustomMessageHandler('cookie-clear', function(msg){
  Cookies.remove(msg.name);
  getCookies();
})

$(document).on('shiny:connected', function(ev){
  getCookies();
})

Shiny.addCustomMessageHandler('analytics-consent', function(msg){
  gtag('consent', 'update', {
    'analytics_storage': msg.value
  });
})"
  # End of JS for the file ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  if (create_file == TRUE) {
    sub_dir <- "www"

    output_dir <- file.path(sub_dir)

    if (!dir.exists(output_dir)) {
      dir.create(output_dir)
    }

    if (file.exists("www/cookie-consent.js")) {
      message("www/cookie-consent.js already exists, updating file...")
      cat(cookie_js, file = "www/cookie-consent.js", sep = "\n")
      message("...file successfully updated")
    } else {
      cat(cookie_js, file = "www/cookie-consent.js", sep = "\n")
      message("Created cookies script as www/cookie-consent.js")
    }
  } else {
    cat(cookie_js, file = "", sep = "\n")
  }
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
#' @family cookies
#' @return a HTML div, containing standard cookies content for a public R
#' Shiny dashboard in DfE
#' @export
#' @inherit cookies examples
cookies_panel_ui <- function(
  id = "cookies_panel",
  google_analytics_key = NULL
) {
  shiny::tags$div(
    style = "margin-top: 50px; margin-bottom: 50px;",
    shiny::tags$h1("Cookies"),
    shiny::tags$p(
      "Cookies are small files saved on your phone, tablet or
                        computer when you visit a website."
    ),
    shiny::tags$p(
      "We use cookies to collect information about how you
                        use our service."
    ),
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
    shiny::tags$p(
      "With your permission, we use Google Analytics to
                        collect data about how you use this service. This
                        information helps us improve our service."
    ),
    shiny::tags$p(
      "Google is not allowed to share our analytics data with
                        anyone."
    ),
    shiny::tags$p(
      "Google Analytics stores anonymised information
                        about:"
    ),
    shiny::tags$ul(
      shiny::tags$li("How you got to this service"),
      shiny::tags$li(
        "The pages you visit on this service and how long you
                         spend on them"
      ),
      shiny::tags$li("How you interact with these pages")
    ),
    shinyGovstyle::govTable(
      inputId = "ga_cookies_table",
      df = data.frame(
        Name = c("_ga", paste0("_ga_", google_analytics_key)),
        Purpose = c(
          "Used to distinguish users",
          "Used to persist
                          session state"
        ),
        Expires = c("13 months", "13 months")
      ),
      caption = "",
      caption_size = "s",
      num_col = NULL,
      width_overwrite = c("one-quarter", "one-quarter", "one-quarter")
    ),
    shiny::br(),
    shiny::tags$h2("Change your cookie settings"),
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
            shiny::radioButtons(
              shiny::NS(id, "cookies_analytics"),
              label = NULL,
              choices = list("Yes" = "yes", "No" = "no"),
              selected = "no",
              inline = TRUE
            )
          )
        )
      )
    ),
    shiny::actionButton(
      shiny::NS(id, "submit_btn"),
      "Save cookie settings",
      class = "govuk-button"
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
#' be `reactive(input$cookies)`)
#' @param google_analytics_key Provide the GA 10 digit key of the form
#' "ABCDE12345"
#'
#' @family cookies
#' @export
#' @inherit cookies examples
cookies_panel_server <- function(
  id = "cookies_panel",
  input_cookies,
  google_analytics_key = NULL
) {
  shiny::moduleServer(id, module = function(input, output, session) {
    shiny::observeEvent(input_cookies(), {
      if (!is.null(input_cookies())) {
        if (!("dfe_analytics" %in% names(input_cookies()))) {
          shiny::updateRadioButtons(
            session,
            "cookies_analytics",
            selected = "no"
          )
        } else {
          if (input_cookies()$dfe_analytics == "denied") {
            shiny::updateRadioButtons(
              session,
              "cookies_analytics",
              selected = "no"
            )
          } else if (input_cookies()$dfe_analytics == "granted") {
            shiny::updateRadioButtons(
              session,
              "cookies_analytics",
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
