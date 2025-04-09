#' Initialize the DFE Shiny Template Setup
#'
#' This function sets up a complete DFE Shiny template by:
#' 1. Cloning the Shiny template repository.
#' 2. Installing a Git pre-commit hook.
#' 3. Setting up a GitHub Actions workflow for deployment.
#'
#' @param path
#' @param google_analytics_key
#' @param dashboard_url
#' @param site_title
#' @param parent_pub_name
#' @param parent_publication
#' @param team_email
#' @param repo_name
#' @param feedback_form_url
#'
#' @details This function runs `init_app()`, `init_commit_hooks()`, and
#' `init_workflow()`
#' in sequence to set up a working environment for a Shiny application.
#'
#' @return No return value. The function initializes the complete template.
#' @examples
#' \dontrun{
#' init_template()
#' init_template(dashboard_name = "my-dashboard")
#' }
#' @export
create_dashboard <- function(
  path = "./",
  google_analytics_key = 'XXXXXXXXX',
  dashboard_url = "https://department-for-education.shinyapps.io/dashboard-name/",
  site_title = "Dashboard name",
  parent_pub_name = "Publication name",
  parent_publication = "https://explore-education-statistics.service.gov.uk/find-statistics/publication-name",
  team_email = "team.name@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dashboard-name",
  feedback_form_url = ""
) {
  message("Initializing the DFE Shiny template...")

  # Step 1: set up basic app structure
  init_base_app()

  # Step 2: Install Git pre-commit hooks
  init_commit_hooks()

  # Step 3: Setup GitHub Actions workflow
  init_workflow(dashboard_name = dashboard_name)

  message("DFE Shiny template setup completed successfully.")
}

#' Initialize a Shiny App Project Structure
#'
#' Creates the basic file and directory structure for a Shiny application,
#'  including:`global.R`, `ui.R`, `server.R`, a `data/` folder,
#'  and a `tests/testthat/` folder.
#'
#' @param path A character string specifying the root directory
#' where the app structure should be created. Defaults to the current
#' working directory (`"."`).
#' @inheritParams create_dashboard
#'
#' @return No return value. The function is called for
#' its side effects (i.e., file and folder creation).
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' init_app()              # Creates structure in current directory
#' init_app("myShinyApp")  # Creates structure in 'myShinyApp' directory
#' }
#'
init_base_app <- function(
  path = "./",
  google_analytics_key = 'XXXXXXXXX',
  dashboard_url = "https://department-for-education.shinyapps.io/dashboard-name/",
  site_title = "Dashboard name",
  parent_pub_name = "Publication name",
  parent_publication = "https://explore-education-statistics.service.gov.uk/find-statistics/publication-name",
  team_email = "team.name@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dashboard-name",
  feedback_form_url = ""
) {
  # Define the full paths
  files <- c("server.R")
  dirs <- c("data", "tests/testthat")

  init_global(
    path = path,
    google_analytics_key = google_analytics_key,
    dashboard_url = dashboard_url,
    site_title = site_title,
    parent_pub_name = parent_pub_name,
    parent_publication = parent_publication,
    team_email = team_email,
    repo_name = repo_name,
    feedback_form_url = feedback_form_url
  )
  init_ui(
    path = path,
    team_email = team_email
  )

  # Create files
  for (file in files) {
    file_path <- file.path(path, file)
    if (!file.exists(file_path)) {
      file.create(file_path)
      message("Created file: ", file_path)
    } else {
      message("File already exists: ", file_path)
    }
  }

  # Create directories
  for (dir in dirs) {
    dir_path <- file.path(path, dir)
    if (!dir.exists(dir_path)) {
      dir.create(dir_path, recursive = TRUE)
      message("Created directory: ", dir_path)
    } else {
      message("Directory already exists: ", dir_path)
    }
  }
}

#' Initialise global.R
#'
#' @param google_analytics_key
#' @param site_title
#' @param parent_pub_name
#' @param parent_publication
#' @param team_email
#' @param repo_name
#' @param feedback_form_url
#'
#' @returns
#' @keywords internal
#'
#' @examples
init_global <- function(
  path = "./",
  google_analytics_key = 'XXXXXXXXX',
  dashboard_url = "https://department-for-education.shinyapps.io/dashboard-name/",
  site_title = "Dashboard name",
  parent_pub_name = "Publication name",
  parent_publication = "https://explore-education-statistics.service.gov.uk/find-statistics/publication-name",
  team_email = "team.name@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dashboard-name",
  feedback_form_url = ""
) {
  globalr_script <- paste(
    c(
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "# This is the global file.",
      "# Use it to store functions, library calls, source files etc.",
      "# Moving these out of the server file and into here improves performance as the",
      "# global file is run only once when the app launches and stays consistent",
      "# across users whereas the server and UI files are constantly interacting and",
      "# responsive to user input.",
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "",
      "# Library calls ===============================================================",
      "shhh <- suppressPackageStartupMessages # It's a library, so shhh!",

      "## Core shiny and R packages --------------------------------------------------",
      "shhh(library(shiny))",
      "shhh(library(bslib))",
      "shhh(library(shinytitle))",
      "shhh(library(metathis))",

      "## Custom packages ------------------------------------------------------------",
      "shhh(library(dfeR))",
      "shhh(library(dfeshiny))",
      "shhh(library(shinyGovstyle))",
      "shhh(library(afcolours))",

      "## Creating charts and tables--------------------------------------------------",
      "shhh(library(ggplot2))",
      "shhh(library(ggiraph))",

      "## Data and string manipulation -----------------------------------------------",
      "shhh(library(dplyr))",
      "shhh(library(stringr))",

      "## Data downloads -------------------------------------------------------------",
      "shhh(library(data.table))",

      "## Testing dependencies -------------------------------------------------------",
      "# These are not needed for the app itself but including them here keeps them in",
      "# renv but avoids the app needlessly loading them, saving on load time.",
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "if (FALSE) {",
      "  shhh(library(shinytest2))",
      "  shhh(library(testthat))",
      "  shhh(library(lintr))",
      "  shhh(library(styler))",
      "}",

      "# Source R scripts ============================================================",
      "# Source any scripts here. Scripts may be needed to process data before it gets",
      "# to the server file or to hold custom functions to keep the main files shorter.",
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",

      "# Set global variables ========================================================",
      paste0("site_title <- \"", site_title, "\""),
      paste0("parent_pub_name <- \"", parent_pub_name, "\""),
      paste0("parent_publication <- \"", parent_publication, "\""),
      paste0("team_email <- \"", team_email, "\""),
      paste0("repo_name <- \"", repo_name, "\""),
      paste0("feedback_form_url <- \"", feedback_form_url, "\""),

      "## Set the URLs that the site will be published to",
      paste0("site_primary <- \"", dashboard_url, "\""),

      ## Google Analytics tracking
      paste0("google_analytics_key <- \"", google_analytics_key, "\"")
    ),
    collapse = "\n"
  )
  sink(file.path(path, "global.R"))
  globalr_script |> cat()
  sink()
}

#' Initialise ui.R
#'
#' @inheritParams create_dashboard
#'
#' @returns
#' @keywords internal
#'
#' @examples
init_ui <- function(path = ".", team_email = "team.name@education.gov.uk") {
  uir_script <- paste(
    c(
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "# This is the ui file. Use it to call elements created in your server file into",
      "# the app, and define where they are placed, and define any user inputs.",
      "#",
      "# Other elements like charts, navigation bars etc. are completely up to you to",
      "# decide what goes in. However, every element should meet accessibility",
      "# requirements and user needs.",
      "#",
      "# This is the user-interface definition of a Shiny web application. You can",
      "# run the application by clicking 'Run App' above.",
      "#",
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "",
      "ui <- function(input, output, session) {",
      "  page_fluid(",
      "# Metadata for app ========================================================",
      "tags$html(lang = \"en\"),",
      "tags$head(HTML(paste0(\"<title>\", site_title, \"</title>\"))), # set in global.R",
      "tags$head(tags$link(rel = \"shortcut icon\", href = \"dfefavicon.png\")),",
      "# Add meta description for search engines",
      "metathis::meta() %>%",
      "meta_general(",
      "application_name = site_title,",
      "description = \"Interactive tool for exploring data\",",
      "robots = \"index,follow\",",
      "generator = \"R Shiny\",",
      "subject = \"education\",",
      "rating = \"General\",",
      "referrer = \"no-referrer\"",
      "),",
      "",
      "# Required to make the title update based on tab changes",
      "shinytitle::use_shiny_title(),",

      "## Custom CSS -------------------------------------------------------------",
      "tags$head(",
      "tags$link(",
      "rel = \"stylesheet\",",
      "type = \"text/css\",",
      "href = \"dfe_shiny_gov_style.css\"",
      ")",
      "),",
      "",
      "## Custom disconnect function ---------------------------------------------",
      "dfeshiny::custom_disconnect_message(",
      "links = site_primary,",
      "publication_name = parent_pub_name,",
      "publication_link = parent_publication",
      "),",
      "tags$head(includeHTML((\"google-analytics.html\"))),",
      "shinyjs::useShinyjs(),",
      "dfeshiny::dfe_cookies_script(),",
      "dfeshiny::cookies_banner_ui(",
      "name = site_title",
      "),",
      "",
      "## Header -----------------------------------------------------------------",
      "dfeshiny::header(",
      "header = site_title,",
      "),",
      "",
      "## Beta banner ------------------------------------------------------------",
      "shinyGovstyle::banner(",
      "\"gds_phase_banner\",",
      "\"Alpha\",",
      "paste0(",
      paste0(
        "\"This dashboard is being developed, contact",
        team_email,
        " with any feedback\""
      ),
      ")",
      "),",
      "",
      "# Page navigation =========================================================",
      "# This switches between the supporting pages in the footer and the main dashboard",
      "gov_main_layout(",
      "bslib::navset_hidden(",
      "id = \"pages\",",
      "nav_panel(",
      "\"dashboard\",",
      "## Main dashboard ---------------------------------------------------",
      "layout_columns(",
      "# Override default wrapping breakpoints to avoid text overlap",
      "col_widths = breakpoints(sm = c(4, 8), md = c(3, 9), lg = c(2, 9)),",
      "## Left navigation ------------------------------------------------",
      "dfe_contents_links(",
      "links_list = c(",
      "\"Panel 1\",",
      "\"User guide\"",
      ")",
      "),",
      "## Dashboard panels -----------------------------------------------",
      "bslib::navset_hidden(",
      "id = \"left_nav\",",
      "nav_panel(",
      "\"panel_1\",",
      "prov_breakdowns_ui(id = \"panel_1\")",
      "),",
      "nav_panel(\"user_guide\", user_guide())",
      ")",
      ")",
      "),",
      "## Footer pages -------------------------------------------------------",
      "nav_panel(\"footnotes\", footnotes_page()),",
      "nav_panel(\"support\", support_page()),",
      "nav_panel(\"accessibility_statement\", accessibility_page()),",
      "nav_panel(\"cookies_statement\", cookies_page())",
      ")",
      "),",
      "",
      "# Footer ==================================================================",
      "dfe_footer(",
      "links_list = c(",
      "\"Footnotes\",",
      "\"Support\",",
      "\"Accessibility statement\",",
      "\"Cookies statement\"",
      ")",
      ")",
      ")",
      "}"
    ),
    collapse = "\n"
  )
  sink(file.path(path, "ui.R"))
  uir_script |> cat()
  sink()
  return(uir_script)
}

#' Initialise ui.R
#'
#' @inheritParams create_dashboard
#'
#' @returns
#' @keywords internal
#'
#' @examples
init_server <- function(
  path = ".",
  team_email = "team.name@education.gov.uk"
) {
  serverr_script <- paste(
    c(
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "# This is the server file.",
      "# Use it to create interactive elements like tables, charts and text for your",
      "# app.",
      "#",
      "# Anything you create in the server file won't appear in your app until you call",
      "# it in the UI file. This server script gives examples of plots and value boxes",
      "#",
      "# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
      "",
      "server <- function(input, output, session) {",
      "# Manage cookie consent",
      "output$cookies_status <- dfeshiny::cookies_banner_server(",
      "input_cookies = shiny::reactive(input$cookies),",
      "parent_session = session,",
      "google_analytics_key = google_analytics_key",
      ")",
      "",
      "dfeshiny::cookies_panel_server(",
      "input_cookies = shiny::reactive(input$cookies),",
      "google_analytics_key = google_analytics_key",
      ")",
      "",
      "# Navigation ================================================================",
      "## Main content left navigation ---------------------------------------------",
      "observeEvent(",
      "input$panel_1,",
      "nav_select(\"left_nav\", \"panel_1\")",
      ")",
      "observeEvent(input$user_guide, nav_select(\"left_nav\", \"user_guide\"))",
      "",
      "## Footer links -------------------------------------------------------------",
      "observeEvent(input$dashboard, nav_select(\"pages\", \"dashboard\"))",
      "observeEvent(input$footnotes, nav_select(\"pages\", \"footnotes\"))",
      "observeEvent(input$support, nav_select(\"pages\", \"support\"))",
      "observeEvent(input$accessibility_statement,nav_select(\"pages\", \"accessibility_statement\"))",
      "observeEvent(input$cookies_statement,nav_select(\"pages\", \"cookies_statement\")",
      ")",
      "",
      "## Back links to main dashboard ---------------------------------------------",
      "observeEvent(input$footnotes_to_dashboard, nav_select(\"pages\", \"dashboard\"))",
      "observeEvent(input$support_to_dashboard, nav_select(\"pages\", \"dashboard\"))",
      "observeEvent(input$cookies_to_dashboard, nav_select(\"pages\", \"dashboard\"))",
      "observeEvent(",
      "input$accessibility_to_dashboard,",
      "nav_select(\"pages\", \"dashboard\")",
      ")",
      "",
      "# Update title ==============================================================",
      "# This changes the title based on the tab selections and is important for accessibility",
      "# If on the main dashboard it uses the active tab from left_nav, else it uses the page input",
      "observe({",
      "if (input$pages == \"dashboard\") {",
      "change_window_title(",
      "title = paste0(site_title, \" - \", gsub(\"_\", \" \", input$left_nav))",
      ")",
      "} else {",
      "change_window_title(",
      "title = paste0(site_title, \" - \", gsub(\"_\", \" \", input$pages))",
      ")",
      "}",
      "})",
      "",
      "}"
    ),
    collapse = "\n"
  )
  sink(file.path(path, "server.R"))
  serverr_script |> cat()
  sink()
  return(serverr_script)
}


#' Initialize Git Pre-Commit Hook for a Shiny App
#'
#' This function checks if the current directory is a Git repository, then
#' downloads a pre-commit hook script from the
#' "dfe-analytical-services/shiny-template" repository and
#' places it in `.git/hooks/pre-commit`, overwriting if necessary.
#'
#' @details The function verifies that the working directory is part of a
#' Git repository before proceeding. If Git is not installed or the directory
#' is not a Git repository, it stops with an error message.
#' The downloaded script ensures best practices before committing changes.
#'
#' @return No return value. The function installs the pre-commit hook.
#' @examples
#' \dontrun{
#' init_commit_hooks()
#' }
#' @export
init_commit_hooks <- function() {
  # Define the Git pre-commit hook file URL
  hook_url <- "https://raw.githubusercontent.com/dfe-analytical-services/shiny-template/main/.hooks/pre-commit.R"

  # Check if this is a Git repository
  if (system("git rev-parse --is-inside-work-tree", intern = TRUE) != "true") {
    stop(
      "This is not a Git repository. Please initialize a Git repository first."
    )
  }

  # Define the destination path for the pre-commit hook
  hook_path <- ".git/hooks/pre-commit"

  # Download and write the file
  tryCatch(
    {
      download.file(hook_url, hook_path, mode = "wb")
      Sys.chmod(hook_path, mode = "755") # Make it executable
      message("Pre-commit hook installed successfully.")
    },
    error = function(e) {
      stop("Failed to download and install the pre-commit hook: ", e$message)
    }
  )
}

#' Initialize GitHub Actions Workflow for Shiny App Deployment
#'
#' This function sets up a GitHub Actions workflow for deploying a Shiny app.
#' It ensures that the `.github/workflows/` directory exists, downloads a
#' deployment workflow file, and creates a configuration YAML file.
#'
#' @param dashboard_name A character string specifying the dashboard name.
#' default value is `"dfe-shiny-template"`.
#'
#' @details If the `.github/workflows/` directory does not exist, it is created.
#' The function then downloads the deployment workflow file and places it inside
#' `.github/workflows/`. Additionally, it generates a YAML file containing
#' deployment settings, allowing customization of the `dashboard_name`.
#'
#' @return No return value. The function sets up the workflow and configuration.
#' @examples
#' \dontrun{
#' init_workflow()
#' init_workflow(dashboard_name = "my-custom-dashboard")
#' }
#' @export
init_workflow <- function(dashboard_name) {
  # Define paths
  workflows_dir <- ".github/workflows"
  workflow_file <- file.path(workflows_dir, "deploy-shiny.yaml")
  config_file <- "deployment-config.yaml"

  # Define GitHub workflow file URL
  workflow_url <- "https://raw.githubusercontent.com/dfe-analytical-services/shiny-template/main/.github/workflows/deploy-shiny.yaml"

  # Ensure the .github/workflows directory exists
  if (!dir.exists(workflows_dir)) {
    dir.create(workflows_dir, recursive = TRUE)
    message(".github/workflows directory created.")
  }

  # Download and save the workflow file
  tryCatch(
    {
      download.file(workflow_url, workflow_file, mode = "wb")
      message("GitHub Actions workflow file downloaded successfully.")
    },
    error = function(e) {
      stop("Failed to download the workflow file: ", e$message)
    }
  )

  # Create the deployment configuration YAML file
  yaml_content <- sprintf(
    "dashboard_name: %s\ndeploy_target: shinyapps\n",
    dashboard_name
  )

  tryCatch(
    {
      writeLines(yaml_content, config_file)
      message("Deployment configuration file created successfully.")
    },
    error = function(e) {
      stop("Failed to create the deployment configuration file: ", e$message)
    }
  )
}
