ui <- function(input, output, session) {
  # bslib page ================================================================
  bslib::page_fluid(
    shinyjs::useShinyjs(),
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "custom-dfeshiny.css"
      )
    ),

    # Custom disconnect =======================================================
    custom_disconnect_message(
      links = c(
        "https://department-for-education.shinyapps.io/dfe-shiny-template/",
        "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
      ),
      publication_name = "source publication",
      publication_link =
        "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
    ),

    # Cookies =================================================================
    dfe_cookies_script(),
    cookies_banner_ui(name = "The dfeshiny test dashboard"),

    # header function =========================================================
    dfeshiny::header("Header Example"),

    # Core content ============================================================
    bslib::layout_column_wrap(
      width = NULL,
      heights_equal = NULL,
      style = htmltools::css(grid_template_columns = "min-content 1fr"),

      # Left navigation =========================================================
      shinyGovstyle::gov_box(

        #fill = FALSE
        id = "nav", # DO NOT REMOVE ID
        shiny::tags$div(
          id = "govuk-contents-box", # DO NOT REMOVE ID
          class = "govuk-contents-box", # DO NOT REMOVE CLASS
          shiny::tags$h2("Contents"),
          shinyGovstyle::contents_link(
            link_text = "Support panel",
            input_id = "support_nav"
          ),
          shinyGovstyle::contents_link(
            link_text = "Accessibility",
            input_id = "accessibility_nav"
          ),
          shinyGovstyle::contents_link(
            link_text = "Cookies",
            input_id = "cookies_nav"
          ),
          shinyGovstyle::contents_link(
            link_text = "Example text",
            input_id = "text_example_nav"
          )
        )
      ),

      # Panels =================================================================
        shinyGovstyle::gov_main_layout(
          id = "main-col", # DO NOT REMOVE ID

          bslib::navset_hidden(
            id = "left_nav",

            # Support panel =======================================================
            bslib::nav_panel(
              "support_panel", dfeshiny::support_panel(
                team_email = "explore.statistics@education.gov.uk",
                repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
                form_url = "https://forms.office.com"
              )
            ),

            # Accessibility panel =================================================
            bslib::nav_panel(
              "accessibility_panel",
              dfeshiny::a11y_panel(
                "DfE Shiny template",
                "https://department-for-education.shinyapps.io/dfe-shiny-template",
                "26th November 2023",
                "28th November 2023",
                "12th March 2024",
                issues_contact = "https://github.com/dfe-analytical-services/shiny-template"
              )
            ),

            # Cookies panel =======================================================
            bslib::nav_panel(
              "cookies_panel",
              dfeshiny::cookies_panel_ui(google_analytics_key = ga_key) # nolint: [object_usage_linter]
            ),

            # Example text panel for testing ======================================
            bslib::nav_panel(
              "text_example_panel",
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
            )
          )
      )
    )
  )
}
