ui <- function(input, output, session) {
  shiny::fluidPage(
    shinyjs::useShinyjs(),

    # header function ---------------------------------------------------------

    dfeshiny::header("Header Example"),

    # Custom disconnect =======================================================
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
      ),
      publication_name = "Explore Education Statistics Publication",
      publication_link =
        "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
    ),

    # Cookies =================================================================
    dfe_cookies_script(),
    cookies_banner_ui(name = "The dfeshiny test dashboard"),

    # Panels ==================================================================
    shiny::navlistPanel(
      "",
      id = "navlistPanel",
      widths = c(2, 8),
      well = FALSE,
      ## Support panel --------------------------------------------------------
      shiny::tabPanel(
        value = "support_panel",
        "Support and feedback",
        support_panel(
          team_email = "explore.statistics@education.gov.uk",
          repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
          form_url = "https://forms.office.com"
        )
      ),
      ## Accessibility panel --------------------------------------------------------
      shiny::tabPanel(
        value = "a11y_panel",
        "Accessibility",
        a11y_panel(
          "DfE Shiny template",
          "https://department-for-education.shinyapps.io/dfe-shiny-template",
          "26th November 2023",
          "28th November 2023",
          "12th March 2024",
          issues_contact = "https://github.com/dfe-analytical-services/shiny-template"
        )
      ),

      ## Cookies panel --------------------------------------------------------
      shiny::tabPanel(
        value = "cookies_panel_ui",
        "Cookies",
        cookies_panel_ui(google_analytics_key = ga_key) # nolint: [object_usage_linter]
      ),

      ## Example text panel ---------------------------------------------------
      shiny::tabPanel(
        value = "text_example",
        "Text example",
        shiny::tags$h2("Hey, here's a heading"),
        shiny::tags$p(
          "Hey ",
          external_link(
            "https://shiny.posit.co/",
            "R Shiny"
          ),
          " is so great we should show it off more."
        ),
        shiny::tags$p(
          "Hey I think the greatest thing ever is ",
          external_link(
            "https://shiny.posit.co/",
            "R Shiny"
          ),
          "."
        ),
        shiny::tags$p(
          "Sometimes you just want to be in a cave without distractions",
          " when writing code in ",
          external_link(
            "https://shiny.posit.co/",
            "R Shiny",
            add_warning = FALSE
          ),
          "."
        ),
        shiny::tags$p(
          "Sometimes you just want to be writing ",
          external_link(
            "https://shiny.posit.co/",
            "R Shiny",
            add_warning = FALSE
          ),
          " code in a cave without distractions."
        )
      ),

      ## Example table panel --------------------------------------------------------
      shiny::tabPanel(
        value = "table_panel_ui",
        "Table example",
        shiny::tags$h1("Reactable example"),
        reactable::reactableOutput("reactable_example")
      )
    )
  )
}
