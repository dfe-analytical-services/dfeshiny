server <- function(input, output, session) {
  output$cookie_status <- cookie_banner_server(
    "cookies",
    input_cookies = shiny::reactive(input$cookies),
    input_clear = shiny::reactive(input$cookie_consent_clear),
    parent_session = session,
    google_analytics_key = google_analytics_key # # nolint: [object_usage_linter]
  )

  # Reactive values to store form inputs
  cookie_settings <- reactiveValues(
    functional = "no",  # Default values
    analytics = "no"    # Default values
  )

  # Observe form submission button
  observeEvent(input$submit_btn, {
    # Update reactive values based on the selected radio buttons
    cookie_settings$functional <- input$cookies_functional
    cookie_settings$analytics <- input$cookies_analytics
  })

  # Display the selected cookie settings
  output$cookieSettings <- renderPrint({
    list(
      Functional_Cookies = cookie_settings$functional,
      Analytics_Cookies = cookie_settings$analytics
    )
  })
}
