library(shiny)
library(shinyjs)
library(dfeshiny)
google_analytics_key <- "ABCDE12345"

# This will be what is in your ui.R script ===============================

ui_plain <- fluidPage(
  # Place these lines above your header ----------------------------------
  useShinyjs(),
  dfe_cookies_script(),
  cookies_banner_ui(name = "My DfE R-Shiny data dashboard"),

  # Place the cookies panel under the header but in the main content -----
  # Example of placing as a panel within navlistPanel
  shiny::navlistPanel(
    "",
    id = "navlistPanel",
    widths = c(2, 8),
    well = FALSE,
    ## Cookies panel -----------------------------------------------------
    shiny::tabPanel(
      value = "so_great",
      "My amazing dashboard",
      shiny::h1("Welcome to my amazing dashboard")
    ),

    shiny::tabPanel(
      value = "cookies_panel_ui",
      "Cookies",
      cookies_panel_ui(google_analytics_key = google_analytics_key)
    )
  )
)

# This will be in your server.R file =====================================

server_plain <- function(input, output, session) {
  # Server logic for the pop up banner, can be placed anywhere in server.R -
  output$cookies_status <- dfeshiny::cookies_banner_server(
    input_cookies = reactive(input$cookies),
    google_analytics_key = google_analytics_key,
    parent_session = session
  )

  # Server logic for the panel, can be placed anywhere in server.R -------
  cookies_panel_server(
    input_cookies = reactive(input$cookies),
    google_analytics_key = google_analytics_key
  )
}

# How to run the minimal app given in this example =======================
shinyApp(ui_plain, server_plain)
