 <!-- badges: start -->
  [![R-CMD-check](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/dfe-analytical-services/dfeshiny/branch/main/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/dfeshiny?branch=main)

  <!-- badges: end -->

# dfeshiny
R package containing preferred methods for creating official DfE R-Shiny dashboards 

# Contributing

Try and make use of the `usethis` package wherever relevant: [https://usethis.r-lib.org/](https://usethis.r-lib.org/)

When you initially clone the package, the first thing you'll need to do is install `devtools`:

`install.packages("devtools")`

Then to load in the package in its current form:

`devtools::load_all()`

## Run the unit tests

Once the package is loaded in you can run the tests locally in a couple of ways:

`Ctrl-Shft-T`

or via the function that triggers

`devtools::test()`

## Adding a package/dependency

`usethis::use_package(<package_name>)`

This will create a new script within the package R/ folder.

## Creating a new script

`usethis::use_r(name = <script_name>)`

This will create a new script within the package R/ folder.


## Updating the package version

Once changes have been completed, reviewed and are ready for use in the wild, you
can increment the package version using:

`usethis::use_version()`

Once you've incremented the version number, it'll offer to perform a commit on your behalf, so all you then need to do is push to GitHub.

# Installing the package
To install, run `renv::install("dfe-analytical-services/dfeshiny")`.

## Potential errors when installing
If you get `ERROR [curl: (22) The requested URL returned error: 401]`, and don't know why, try running `Sys.unsetenv("GITHUB_PAT")` to temporarily clear your GitHub PAT variable.

Then try to install again. 

If this works, then you will need to look for where that "GITHUB_PAT" variable is being set from and remove it to permanently fix the issue, contact us for support if you need help with this or have any other issues installing.
