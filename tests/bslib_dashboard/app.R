library(shiny)
library(shinyjs)
library(bslib)
library(shinyGovstyle)
devtools::load_all(".")

google_analytics_key <- "ABCDE12345"

dfe_contents_links <- function(links_list) {
  # Add the HTML around the link and make an id by snake casing
  create_sidelink <- function(link_text) {
    tags$li("—", actionLink(tolower(gsub(" ", "_", link_text)), link_text, class = "contents_link"))
  }

  # The HTML div to be returned
  tags$div(
    style = "position: sticky; top: 0.5rem; padding: 0.25rem;", # Make it stick!
    h2("Contents"),
    tags$ol(
      style = "list-style-type: none; padding-left: 0; font-size: 1rem;", # remove the circle bullets
      lapply(links_list, create_sidelink)
    )
  )
}

ui <- bslib::page_fluid(
  useShinyjs(),
  dfe_cookies_script(),
  cookies_banner_ui(name = "My DfE R Shiny data dashboard"),
  bslib::layout_columns(
    col_widths = breakpoints(sm = c(4, 8), md = c(3, 9), lg = c(2, 9)),
    # Navigation column -------------------------------------------------------
      dfe_contents_links(c("Page", "Cookies")),
    # Main panel --------------------------------------------------------------
    bslib::navset_hidden(
      id = "main_contents",
      bslib::nav_panel(
        "page",
        h1("First page of dashboard"),
        p("Isn't this great?!")
      ),
      bslib::nav_panel(
        "cookies",
        cookies_panel_ui(google_analytics_key = google_analytics_key)
      )
    )
  )
)

server <- function(input, output, session) {
  # Navigation server logic
  observeEvent(input$page, nav_select("main_contents", "page"))
  observeEvent(input$cookies, nav_select("main_contents", "cookies"))

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
