# cookies_panel_ui

Create the standard DfE R-Shiny cookies dashboard panel in the ui. The
server side functionality is provided by cookies_panel_server()

## Usage

``` r
cookies_panel_ui(id = "cookies_panel", google_analytics_key = NULL)
```

## Arguments

- id:

  Shiny tag shared with cookies_panel_server(), can be any string set by
  the user as long as it matches the id in the cookies_panel_server()

- google_analytics_key:

  Provide the GA 10 digit key of the form "ABCDE12345"

## Value

a HTML div, containing standard cookies content for a public R Shiny
dashboard in DfE

## See also

Other cookies:
[`cookies`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies.md),
[`cookies_banner_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_server.md),
[`cookies_banner_ui()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_ui.md),
[`cookies_panel_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_panel_server.md)

## Examples

``` r
if (interactive()) {
  # This example shows how to use the full family of cookies functions together
  # This will be in your global.R script ===================================

  library(shiny)
  library(shinyjs)
  library(dfeshiny)
  google_analytics_key <- "ABCDE12345"

  # This will be what is in your ui.R script ===============================

  ui <- shinyGovstyle::gov_page(
    # Place these lines above your header ----------------------------------
    useShinyjs(),
    dfe_cookies_script(),
    cookies_banner_ui(name = "My DfE R-Shiny data dashboard"),

    header("My DfE R-Shiny data dashboard"),
    shinyGovstyle::service_navigation(
      links = c("Cookies" = "cookies_panel_ui")
    ),

    # Place the cookies panel under the header but in the main content -----
    # Example of placing as a panel within a hidden tabsetPanel, which the
    # service navigation links switch between
    shinyGovstyle::gov_main_layout(
      shiny::tabsetPanel(
        id = "dashboard_page",
        type = "hidden",
        ## Cookies panel ---------------------------------------------------
        shiny::tabPanel(
          value = "cookies_panel_ui",
          "Cookies",
          cookies_panel_ui(google_analytics_key = google_analytics_key)
        )
      )
    )
  )

  # This will be in your server.R file =====================================

  server <- function(input, output, session) {
    # Server logic for the service navigation links -------------------------
    shinyGovstyle::service_navigation_server(
      session,
      tabset_id = "dashboard_page",
      link_to_panel = "cookies_panel_ui"
    )
    # Keep the active navigation link in sync, including when the cookie
    # banner's link switches the page
    observeEvent(input$dashboard_page, {
      shinyGovstyle::update_service_navigation(session, input$dashboard_page)
    })

    # Server logic for the pop up banner, can be placed anywhere in server.R -
    output$cookies_status <- dfeshiny::cookies_banner_server(
      input_cookies = reactive(input$cookies),
      google_analytics_key = google_analytics_key,
      parent_session = session,
      cookies_nav_id = "dashboard_page"
    )

    # Server logic for the panel, can be placed anywhere in server.R -------
    cookies_panel_server(
      input_cookies = reactive(input$cookies),
      google_analytics_key = google_analytics_key
    )
  }

  # How to run the minimal app given in this example =======================
  shinyApp(ui, server)
}
```
