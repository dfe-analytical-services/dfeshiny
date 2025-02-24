test_that("pre_commit_innit creates the correct hook file", {
  temp_git_dir <- tempfile()
  dir.create(file.path(temp_git_dir, ".git/hooks"), recursive = TRUE)
  old_wd <- setwd(temp_git_dir)

  on.exit(setwd(old_wd), add = TRUE)

  hook_path <- init_hooks()

  expect_true(file.exists(hook_path))
  expect_match(readLines(hook_path), "dfeshiny::commit_hooks()", all = FALSE)

  unlink(temp_git_dir, recursive = TRUE)
})
