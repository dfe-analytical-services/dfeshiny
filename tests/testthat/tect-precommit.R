#' Initialize Pre-commit Hook
#'
#' Creates a Git pre-commit hook that runs the `commit_hooks` function.
#' If `skip_analytics` is set to TRUE, it will pass that argument to the script.
#'
#' @param skip_analytics Logical. If TRUE, skips `check_analytics_key` in the hook.
#' @return The path to the pre-commit hook file if created successfully.
#' @export
pre_commit_innit <- function(skip_analytics = FALSE) {
  hook_path <- ".git/hooks/pre-commit"

  # Define hook content
  hook_content <- sprintf("#!/usr/bin/env Rscript\ndfeshiny::commit_hooks(skip_analytics = %s)", tolower(skip_analytics))

  # Ensure the hooks directory exists
  if (!dir.exists(".git/hooks")) {
    stop("Git hooks directory not found. Are you inside a Git repository?")
  }

  # Write the hook file
  writeLines(hook_content, hook_path)

  # Make the script executable
  Sys.chmod(hook_path, mode = "0755")

  message("Pre-commit hook created at ", hook_path)
  return(hook_path)
}

#' Unit Tests for Pre-commit Hook
#'
#' Tests the `pre_commit_innit` function to ensure correct hook creation.
#' @import testthat
#' @export
test_pre_commit_innit <- function() {
  test_that("pre_commit_innit creates the correct hook file", {
    temp_git_dir <- tempfile()
    dir.create(file.path(temp_git_dir, ".git/hooks"), recursive = TRUE)
    old_wd <- setwd(temp_git_dir)

    on.exit(setwd(old_wd), add = TRUE)

    hook_path <- pre_commit_innit(skip_analytics = TRUE)

    expect_true(file.exists(hook_path))
    expect_match(readLines(hook_path), "dfeshiny::commit_hooks(skip_analytics = true)", all = FALSE)

    unlink(temp_git_dir, recursive = TRUE)
  })
}
