library(shiny)
library(shinyjs)
library(dfeshiny)
library(bslib)

google_analytics_key <- "ABCDE12345"

ui <- bslib::page_fluid(
  useShinyjs(),
  dfe_cookies_script(),
  cookies_banner_ui(name = "My DfE R Shiny data dashboard"),
  bslib::navset_hidden(
    id = "navlistPanel",

    bslib::nav_panel(
      "Cookies",
      value = "cookies_panel_ui",
      cookies_panel_ui(google_analytics_key = google_analytics_key)
    )
  )
)

server <- function(input, output, session) {
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

shinyApp(ui, server)
