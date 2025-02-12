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
