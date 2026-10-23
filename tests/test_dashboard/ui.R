ui <- function(input, output, session) {
  shinyGovstyle::gov_page(
    width = "full",
    shinyjs::useShinyjs(),

    # Cookies =================================================================
    dfe_cookies_script(),
    cookies_banner_ui(name = "The dfeshiny test dashboard"),

    # header function ---------------------------------------------------------
    dfeshiny::header("Header Example"),
    shinyGovstyle::service_navigation(
      links = navigation_links, # nolint: [object_usage_linter]
      page_title_suffix = "dfeshiny test dashboard"
    ),

    # Custom disconnect =======================================================
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
      ),
      publication_name = "Explore Education Statistics Publication",
      publication_link = paste0(
        "https://explore-education-statistics.service.gov.uk",
        "/find-statistics/apprenticeships"
      )
    ),

    # Panels ==================================================================
    shinyGovstyle::gov_main_layout(
      shiny::tabsetPanel(
        id = "dashboard_page",
        type = "hidden",
        ## Support panel --------------------------------------------------------
        shiny::tabPanel(
          value = "support_panel",
          "Support and feedback",
          support_panel(
            team_email = "explore.statistics@education.gov.uk",
            contact_name = "Rich Bielby",
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
          shinyGovstyle::heading_text("Hey, here's a heading", size = "l", level = 2),
          shinyGovstyle::gov_text(
            "Hey ",
            shinyGovstyle::external_link(
              "https://shiny.posit.co/",
              "R Shiny"
            ),
            " is so great we should show it off more."
          ),
          shinyGovstyle::gov_text(
            "Hey I think the greatest thing ever is ",
            shinyGovstyle::external_link(
              "https://shiny.posit.co/",
              "R Shiny"
            ),
            "."
          ),
          shinyGovstyle::gov_text(
            "Sometimes you just want to be in a cave without distractions",
            " when writing code in ",
            shinyGovstyle::external_link(
              "https://shiny.posit.co/",
              "R Shiny",
              add_warning = FALSE
            ),
            "."
          ),
          shinyGovstyle::gov_text(
            "Sometimes you just want to be writing ",
            shinyGovstyle::external_link(
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
          shinyGovstyle::heading_text(
            "Reactable example",
            id = "reactable_example_heading"
          ),
          reactable::reactableOutput("reactable_example")
        )
      )
    )
  )
}
