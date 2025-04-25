# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is the server file.
# Use it to create interactive elements like tables, charts and text for your
# app.
#
# Anything you create in the server file won't appear in your app until you call
# it in the UI file. This server script gives examples of plots and value boxes
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

server <- function(input, output, session) {
  # Manage cookie consent
  output$cookies_status <- dfeshiny::cookies_banner_server(
    input_cookies = shiny::reactive(input$cookies),
    parent_session = session,
    google_analytics_key = google_analytics_key
  )

  dfeshiny::cookies_panel_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = google_analytics_key
  )

  # Navigation ================================================================
  ## Main content left navigation ---------------------------------------------
  observeEvent(
    input$panel_1,
    nav_select("left_nav", "panel_1")
  )
  observeEvent(input$user_guide, nav_select("left_nav", "user_guide"))

  ## Footer links -------------------------------------------------------------
  observeEvent(input$dashboard, nav_select("pages", "dashboard"))
  observeEvent(input$footnotes, nav_select("pages", "footnotes"))
  observeEvent(input$support, nav_select("pages", "support"))
  observeEvent(
    input$accessibility_statement,
    nav_select("pages", "accessibility_statement")
  )
  observeEvent(
    input$cookies_statement,
    nav_select("pages", "cookies_statement")
  )

  ## Back links to main dashboard ---------------------------------------------
  observeEvent(input$footnotes_to_dashboard, nav_select("pages", "dashboard"))
  observeEvent(input$support_to_dashboard, nav_select("pages", "dashboard"))
  observeEvent(input$cookies_to_dashboard, nav_select("pages", "dashboard"))
  observeEvent(
    input$accessibility_to_dashboard,
    nav_select("pages", "dashboard")
  )

  # Update title ==============================================================
  # This changes the title based on the tab selections and is important for accessibility
  # If on the main dashboard it uses the active tab from left_nav, else it uses the page input
  observe({
    if (input$pages == "dashboard") {
      change_window_title(
        title = paste0(site_title, " - ", gsub("_", " ", input$left_nav))
      )
    } else {
      change_window_title(
        title = paste0(site_title, " - ", gsub("_", " ", input$pages))
      )
    }
  })
}
