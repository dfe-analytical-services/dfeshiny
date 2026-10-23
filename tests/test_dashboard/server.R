server <- function(input, output, session) {
  shinyGovstyle::service_navigation_server(
    session,
    tabset_id = "dashboard_page",
    link_to_panel = unname(navigation_links) # nolint: [object_usage_linter]
  )
  shiny::observeEvent(input$dashboard_page, {
    # Tab changes from bookmarks and the cookie link also update the active link.
    shinyGovstyle::update_service_navigation(session, input$dashboard_page)
  })

  # Cookies testing ===========================================================
  shinyjs::runjs(
    'Cookies.remove("dfe_analytics");
    getCookies();'
  )

  output$cookies_status <- cookies_banner_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key, # nolint: [object_usage_linter]
    parent_session = session,
    cookies_nav_id = "dashboard_page"
  )

  cookies_panel_server(
    input_cookies = shiny::reactive(input$cookies),
    google_analytics_key = ga_key # nolint: [object_usage_linter]
  )

  output$reactable_example <- reactable::renderReactable(
    dfe_reactable(mtcars |> dplyr::select("mpg", "cyl", "hp", "gear"))
  )

  shiny::observe({
    dfeshiny::set_bookmark_include(input, bookmarking_whitelist) # nolint: [object_usage_linter]
    # Trigger this observer every time an input changes
    shiny::reactiveValuesToList(input)
    session$doBookmark()
  })
  shiny::onBookmarked(updateQueryString) # nolint: [object_usage_linter]
}
