#' Initialize the DFE Shiny Template Setup
#'
#' This function sets up a complete DFE Shiny template by:
#' 1. Cloning the Shiny template repository.
#' 2. Installing a Git pre-commit hook.
#' 3. Setting up a GitHub Actions workflow for deployment.
#'
#' @param dashboard_name A character string specifying the dashboard name for
#' the deployment configuration.
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
init_template <- function(dashboard_name) {
  message("Initializing the DFE Shiny template...")

  # Step 1: set up basic app structure
  init_app()

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
#'
#' @return No return value. The function is called for
#' its side effects (i.e., file and folder creation).
#'
#' @examples
#' \dontrun{
#' init_app()              # Creates structure in current directory
#' init_app("myShinyApp")  # Creates structure in 'myShinyApp' directory
#' }
#'
#' @export
init_app <- function(path = ".") {
  # Define the full paths
  files <- c("global.R", "ui.R", "server.R")
  dirs <- c("data", "tests/testthat")

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
    stop("This is not a Git repository. Please initialize a Git repository first.")
  }

  # Define the destination path for the pre-commit hook
  hook_path <- ".git/hooks/pre-commit"

  # Download and write the file
  tryCatch({
    download.file(hook_url, hook_path, mode = "wb")
    Sys.chmod(hook_path, mode = "755") # Make it executable
    message("Pre-commit hook installed successfully.")
  }, error = function(e) {
    stop("Failed to download and install the pre-commit hook: ", e$message)
  })
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
  tryCatch({
    download.file(workflow_url, workflow_file, mode = "wb")
    message("GitHub Actions workflow file downloaded successfully.")
  }, error = function(e) {
    stop("Failed to download the workflow file: ", e$message)
  })

  # Create the deployment configuration YAML file
  yaml_content <- sprintf("dashboard_name: %s\ndeploy_target: shinyapps\n", dashboard_name)

  tryCatch({
    writeLines(yaml_content, config_file)
    message("Deployment configuration file created successfully.")
  }, error = function(e) {
    stop("Failed to create the deployment configuration file: ", e$message)
  })
}
