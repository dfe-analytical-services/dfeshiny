# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is the ui file. Use it to call elements created in your server file into
# the app, and define where they are placed, and define any user inputs.
#
# Other elements like charts, navigation bars etc. are completely up to you to
# decide what goes in. However, every element should meet accessibility
# requirements and user needs.
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ui <- function(input, output, session) {
  page_fluid(
    # Metadata for app ========================================================
    tags$html(lang = "en"),
    tags$head(HTML(paste0("<title>", site_title, "</title>"))), # set in global.R
    tags$head(tags$link(rel = "shortcut icon", href = "dfefavicon.png")),
    # Add meta description for search engines
    metathis::meta() %>%
      meta_general(
        application_name = site_title,
        description = "Interactive tool for exploring data",
        robots = "index,follow",
        generator = "R Shiny",
        subject = "education",
        rating = "General",
        referrer = "no-referrer"
      ),

    # Required to make the title update based on tab changes
    shinytitle::use_shiny_title(),

    ## Custom CSS -------------------------------------------------------------
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "dfe_shiny_gov_style.css"
      )
    ),

    ## Custom disconnect function ---------------------------------------------
    dfeshiny::custom_disconnect_message(
      links = site_primary,
      publication_name = parent_pub_name,
      publication_link = parent_publication
    ),
    tags$head(includeHTML(("google-analytics.html"))),
    shinyjs::useShinyjs(),
    dfeshiny::dfe_cookies_script(),
    dfeshiny::cookies_banner_ui(
      name = site_title
    ),

    ## Header -----------------------------------------------------------------
    dfeshiny::header(
      header = site_title
    ),

    ## Beta banner ------------------------------------------------------------
    shinyGovstyle::banner(
      "gds_phase_banner",
      "Alpha",
      paste0(
        "This dashboard is being developed, contact",
        team_email,
        " with any feedback"
      )
    ),

    # Page navigation =========================================================
    # This switches between the supporting pages in the footer and the main dashboard
    gov_main_layout(
      bslib::navset_hidden(
        id = "pages",
        nav_panel(
          "dashboard",
          ## Main dashboard ---------------------------------------------------
          layout_columns(
            # Override default wrapping breakpoints to avoid text overlap
            col_widths = breakpoints(sm = c(4, 8), md = c(3, 9), lg = c(2, 9)),
            ## Left navigation ------------------------------------------------
            dfe_content_links(
              links_list = c(
                "Panel 1",
                "User guide"
              )
            ),
            ## Dashboard panels -----------------------------------------------
            bslib::navset_hidden(
              id = "left_nav",
              nav_panel(
                "panel_1",
                dashboard_page(id = "panel_1")
              ),
              nav_panel("user_guide", user_guide())
            )
          )
        ),
        ## Footer pages -------------------------------------------------------
        nav_panel("footnotes", footnotes_page()),
        nav_panel("support", support_page()),
        nav_panel("accessibility_statement", accessibility_page()),
        nav_panel("cookies_statement", cookies_page())
      )
    ),

    # Footer ==================================================================
    dfe_footer(
      links_list = c(
        "Footnotes",
        "Support",
        "Accessibility statement",
        "Cookies statement"
      )
    )
  )
}
