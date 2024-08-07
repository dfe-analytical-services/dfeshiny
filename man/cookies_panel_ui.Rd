% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cookies.R
\name{cookies_panel_ui}
\alias{cookies_panel_ui}
\title{cookies_panel_ui}
\usage{
cookies_panel_ui(id = "cookies_panel", google_analytics_key = NULL)
}
\arguments{
\item{id}{Shiny tag shared with cookies_panel_server(), can be any string set by
the user as long as it matches the id in the cookies_panel_server()}

\item{google_analytics_key}{Provide the GA 10 digit key of the form
"ABCDE12345"}
}
\value{
a standardised panel for a public R Shiny dashboard in DfE
}
\description{
Create the standard DfE R-Shiny cookies dashboard panel in the ui. The server
side functionality is provided by cookies_panel_server()
}
\examples{
if (interactive()) {
  # This example shows how to use the full family of cookie functions together
  # This will be in your global.R script =====================================

  library(shiny)
  library(shinyjs)
  library(dfeshiny)
  ga_key <- "ABCDE12345"

  # This will be what is in your ui.R script =================================

  ui <- fluidPage(
    # Place these lines above your header ------------------------------------
    dfe_cookie_script(),
    useShinyjs(),
    cookie_banner_ui(name = "My DfE R-Shiny data dashboard"),

    # Place the cookies panel under the header but in the main content -------
    cookies_panel_ui(google_analytics_key = ga_key)
  )

  # This will be in your server.R file =======================================

  server <- function(input, output, session) {
    # Server logic for the pop up banner, can be placed anywhere in server.R -
    output$cookie_status <- dfeshiny::cookie_banner_server(
      input_cookies = reactive(input$cookies),
      google_analytics_key = ga_key
    )

    # Server logic for the panel, can be placed anywhere in server.R ---------
    cookies_panel_server(
      input_cookies = reactive(input$cookies),
      google_analytics_key = ga_key
    )
  }

  # How to run the minimal app given in this example =========================
  shinyApp(ui, server)
}
}
