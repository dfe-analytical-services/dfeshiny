library(shiny)
library(shinyjs)
library(bslib)
library(dfeshiny)
google_analytics_key <- "ABCDE12345"

# This will be what is in your ui.R script ===============================

ui <- bslib::page_fluid(
  # Place these lines above your header ----------------------------------
  useShinyjs(),
  dfe_cookies_script(),
  cookies_banner_ui(name = "My DfE R Shiny data dashboard"),

  # Place the cookies panel under the header but in the main content -----
  bslib::navset_bar(
    id = "left_nav",

    # UI panels ==========================================================
    bslib::nav_panel(
      title = "My amazing dashboard",
      id = "so_great",
      shiny::tags$h1("Welcome to my amazing dashboard")
    ),
    bslib::nav_panel(
      title = "Cookies",
      id = "cookies_panel",
      dfeshiny::cookies_panel_ui(google_analytics_key = ga_key)
    )
  )
)

# This will be in your server.R file =====================================

server <- function(input, output, session) {
  output$cookies_status <- dfeshiny::cookies_banner_server(
    input_cookies = reactive(input$cookies),
    google_analytics_key = google_analytics_key,
    parent_session = session,
    cookies_nav_id = "left_nav",
    cookies_link_panel = "cookies_panel"
  )

  cookies_panel_server(
    input_cookies = reactive(input$cookies),
    google_analytics_key = google_analytics_key
  )

  shiny::observeEvent(input$`cookies_banner-cookies_link`, {
    bslib::nav_select("left_nav", selected = "cookies_panel")
  })
}

# How to run the minimal app given in this example =======================
shinyApp(ui, server)
