#' Initialize the DFE Shiny Template Setup
#'
#' This function sets up a complete DFE Shiny template by:
#' 1. Cloning the Shiny template repository.
#' 2. Installing a Git pre-commit hook.
#' 3. Setting up a GitHub Actions workflow for deployment.
#'
#' @param path The root directory where the app should be created. String, default: `"."`.
#' @param google_analytics_key 10 digit Google Analytics key if available. String, default:
#' `"XXXXXXXXXX"`
#' @param publication_name The name of the parent publication. String, default:
#' `"Publication name"`
#' @param publication_link Full URL for the publication on Explore Education. String, default: `
#' "https://explore-education-statistics.service.gov.uk/find-statistics/publication-name"`
#' Statistics
#' @param site_title Site title for the dashboard. String, default: `"Shiny template"`
#' @param dashboard_link Full URL of the dashboard. String, default:
#' `"https://department-for-education.shinyapps.io/shiny-template/"`
#' @param team_email Email address for support contact. String, default:
#' `"explore.statistics@@education.gov.uk"`
#' @param repo_name The repository URL, must be a valid URL for the dfe-analytical-services GitHub
#' area or the dfe-gov-uk Azure DevOps. String, default:
#' `"https://github.com/dfe-analytical-services/dfeshiny"`
#' @param feedback_form_url
#'
#' @details This function runs `init_app()`, `init_commit_hooks()`, and
#' `init_workflow()`
#' in sequence to set up a working environment for a Shiny application.
#'
#' @return No return value. The function initializes the complete template.
#' @examples
#' \dontrun{
#' create_dashboard()
#' }
#' @export
create_dashboard <- function(
  path = "./",
  site_title = "dfeshiny template",
  google_analytics_key = "XXXXXXXXXX",
  dashboard_url = "https://department-for-education.shinyapps.io/dfeshiny-template/",
  parent_pub_name = "Publication name",
  parent_publication = paste0(
    "https://explore-education-statistics.service.gov.uk/find-statistics/",
    "publication-name"
  ),
  team_email = "explore.statistics@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dfeshiny",
  feedback_form_url = "",
  verbose = FALSE
) {
  message("Initializing the DFE Shiny template...")

  # Set up basic app structure
  init_base_app(
    path = path,
    google_analytics_key = google_analytics_key,
    dashboard_url = dashboard_url,
    site_title = site_title,
    parent_pub_name = parent_pub_name,
    parent_publication = parent_publication,
    team_email = team_email,
    repo_name = repo_name,
    feedback_form_url = feedback_form_url,
    verbose = verbose
  )

  # Install Git pre-commit hooks
  init_commit_hooks(path = path)

  # Set up GitHub Actions workflow
  init_workflow(
    path = path,
    site_title = site_title
  )

  # Set up Google Analytics
  init_analytics(
    path = path,
    ga_code = google_analytics_key
  )

  message("DFE Shiny template setup completed successfully.")
}

#' Initialize a Shiny App Project Structure
#'
#' Creates the basic file and directory structure for a Shiny application,
#'  including:`global.R`, `ui.R`, `server.R`, a `data/` folder,
#'  and a `tests/testthat/` folder.
#'
#' @inheritParams create_dashboard
#'
#' @return No return value. The function is called for
#' its side effects (i.e., file and folder creation).
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' init_base_app()              # Creates structure in current directory
#' }
#'
init_base_app <- function(
  path = "./",
  google_analytics_key = "XXXXXXXXX",
  dashboard_url = "https://department-for-education.shinyapps.io/dashboard-name/",
  site_title = "Dashboard name",
  parent_pub_name = "Publication name",
  parent_publication = paste0(
    "https://explore-education-statistics.service.gov.uk/find-statistics/",
    "publication-name"
  ),
  team_email = "team.name@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dashboard-name",
  feedback_form_url = "",
  verbose = FALSE
) {
  # Create directories
  dirs <- c("data", "R/footer_pages", "tests/testthat")
  for (dir in dirs) {
    dir_path <- file.path(path, dir)
    if (!dir.exists(dir_path)) {
      dir.create(dir_path, recursive = TRUE)
      dfeR::toggle_message("Created directory: ", dir_path, verbose = verbose)
    } else {
      dfeR::toggle_message(
        "Directory already exists: ",
        dir_path,
        verbose = verbose
      )
    }
  }

  init_global(
    path = path,
    google_analytics_key = google_analytics_key,
    dashboard_url = dashboard_url,
    site_title = site_title,
    parent_pub_name = parent_pub_name,
    parent_publication = parent_publication,
    team_email = team_email,
    repo_name = repo_name,
    feedback_form_url = feedback_form_url,
    verbose = verbose
  )
  init_ui(
    path = path,
    verbose = verbose
  )
  init_server(
    path = path,
    verbose = verbose
  )
}

#' Initialise global.R
#'
#' @inheritParams create_dashboard
#'
#' @returns NULL
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' init_global()
#' }
init_global <- function(
  path = "./",
  google_analytics_key = "XXXXXXXXX",
  dashboard_url = "https://department-for-education.shinyapps.io/dashboard-name/",
  site_title = "Dashboard name",
  parent_pub_name = "Publication name",
  parent_publication = paste0(
    "https://explore-education-statistics.service.gov.uk/find-statistics/",
    "publication-name"
  ),
  team_email = "team.name@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/dashboard-name",
  feedback_form_url = "",
  verbose = FALSE
) {
  globalr_script <- paste(
    c(
      readLines("inst/global_template.r"),
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
  globalr_script |>
    cat(file = file.path(path, "global.R"))
  dfeR::toggle_message(
    "create_dashboard: global.R created",
    verbose = verbose
  )
  return(NULL)
}

#' Initialise ui.R
#'
#' @inheritParams create_dashboard
#'
#' @returns NULL
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' init_ui()
#' }
init_ui <- function(
  path = ".",
  verbose = FALSE
) {
  uir_script <- readLines("inst/ui_template.r") |>
    paste(collapse = "\n")
  uir_script |> cat(file = file.path(path, "ui.R"))
  dfeR::toggle_message(
    "create_dashboard: ui.R created",
    verbose = verbose
  )
  return(NULL)
}

#' Initialise server.R
#'
#' @inheritParams create_dashboard
#'
#' @returns NULL
#' @keywords internal
#'
#' @examples
#' \dontrun{
#' init_server()
#' }
init_server <- function(
  path = ".",
  verbose = FALSE
) {
  serverr_script <- readLines("inst/server_template.r") |>
    paste(collapse = "\n")
  serverr_script |> cat(file = file.path(path, "server.R"))
  dfeR::toggle_message(
    "create_dashboard: server.R created",
    verbose = verbose
  )
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
#' @inheritParams create_dashboard
#'
#' @return No return value. The function installs the pre-commit hook.
#' @examples
#' \dontrun{
#' init_commit_hooks()
#' }
#' @export
init_commit_hooks <- function(path = "./") {
  # Define the Git pre-commit hook file URL
  hook_url <- "https://raw.githubusercontent.com/dfe-analytical-services/shiny-template/main/.hooks/pre-commit.R"

  # Check if this is a Git repository
  if (system("git rev-parse --is-inside-work-tree", intern = TRUE) != "true") {
    stop(
      "This is not a Git repository. Please initialize a Git repository first."
    )
  }

  # Define the destination path for the pre-commit hook
  hook_path <- file.path(path, ".git/hooks/pre-commit")

  # Download and write the file
  tryCatch(
    {
      utils::download.file(hook_url, hook_path, mode = "wb")
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
#' @inheritParams create_dashboard
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
init_workflow <- function(site_title, path = "./") {
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
      utils::download.file(workflow_url, workflow_file, mode = "wb")
      message("GitHub Actions workflow file downloaded successfully.")
    },
    error = function(e) {
      stop("Failed to download the workflow file: ", e$message)
    }
  )

  # Create the deployment configuration YAML file
  yaml_content <- sprintf(
    "dashboard_name: %s\ndeploy_target: shinyapps\n",
    site_title
  )

  tryCatch(
    {
      writeLines(yaml_content, file.path(path, config_file))
      message("Deployment configuration file created successfully.")
    },
    error = function(e) {
      stop("Failed to create the deployment configuration file: ", e$message)
    }
  )
}
