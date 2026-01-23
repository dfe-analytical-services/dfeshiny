# cookies_banner_ui

This function provides a cookie authorisation banner on DfE R-Shiny
dashboards for users to be able to accept or reject cookies. The server
side functionality is provided by cookies_banner_server(), whilst users
will also need to include the dfe_cookies_script() function in their
ui.R file.

## Usage

``` r
cookies_banner_ui(
  id = "cookies_banner",
  name = "DfE R-Shiny dashboard template"
)
```

## Arguments

- id:

  Shiny tag shared with cookies_banner_server(), can be any string set
  by the user as long as it matches the id in the
  cookies_banner_server()

- name:

  Name of the dashboard on which the cookie authorisation is being
  applied

## Value

shiny::tags\$div()

## See also

Other cookies:
[`cookies`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies.md),
[`cookies_banner_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_server.md),
[`cookies_panel_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_panel_server.md),
[`cookies_panel_ui()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_panel_ui.md)

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

  ui <- fluidPage(
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
        value = "cookies_panel_ui",
        "Cookies",
        cookies_panel_ui(google_analytics_key = google_analytics_key)
      )
    )
  )

  # This will be in your server.R file =====================================

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

  # How to run the minimal app given in this example =======================
  shinyApp(ui, server)
}
```
