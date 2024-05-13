<!-- badges: start -->
[![R-CMD-check](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/dfe-analytical-services/dfeshiny/branch/main/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/dfeshiny?branch=main)
<!-- badges: end -->

<a href="http://dfe-analytical-services.github.io/dfeshiny/"><img src="man/figures/dfeshiny.png" align="right" width="120" /></a>

# dfeshiny  

An R package to support analysts in developing official DfE dashboards and help 
them meet the necessary standards required of public facing government services.

## Installing the package

To install, run `renv::install("dfe-analytical-services/dfeshiny")`.

### Potential errors when installing

If you get `ERROR [curl: (22) The requested URL returned error: 401]`, and don't know why, try running `Sys.unsetenv("GITHUB_PAT")` to temporarily clear your GitHub PAT variable.

Then try to install again. 

If this works, then you will need to look for where that "GITHUB_PAT" variable is being set from and remove it to permanently fix the issue, contact us for support if you need help with this or have any other issues installing.

## Using this package in a DfE data dashboard

### Adding a custom disconect message to your dashboard

dfeshiny provides a function to add a custom disconnect message to your dashboard - this will appear when a dashboard would otherwise 'grey-screen' and will include options to refresh the page, go to overflow sites or visit the publication directly on Explore education statistics. 

The following parameters should be defined and up-to-date in the global.R script: 

- sites_list
- ees_pub_name
- ees_publication

To include a custom disconnect message, you should insert the following line into the ui.R script: 

```
custom_disconnect_message( 
   links = sites_list, 
   publication_name = ees_pub_name, 
   publication_link = ees_publication
 ),
```

Putting this on the lines *just before* the `shinyGovstyle::header(...)` line 
should work well.


## Contributing

Try and make use of the [usethis](https://usethis.r-lib.org/) package wherever possible.

When you initially clone the package, the first thing you'll need to do is install [devtools](https://devtools.r-lib.org/):

```
install.packages("devtools")
```

Then to load in the package in its current form:

```
devtools::load_all()
```

### Adding a package/dependency

`usethis::use_package(<package_name>)`

This will create a new script within the package R/ folder.

Note that when adding a function from another package into one of the dfeshiny functions you will need to explicitly state the package in the function call, e.g.:

```package::function()```

Alternatively, if there's a lot of uses of a single function within one of our R scripts, you can call that function once at the top of the R script, e.g:

```
@' importFrom package function
```

For more information see the [roxygen2 documentation on declaring dependencies](https://roxygen2.r-lib.org/articles/namespace.html).

### Creating a new function script

`usethis::use_r(name = <script_name>)`

This will create a new script within the package R/ folder.

### Creating a new function test script

`usethis::use_test(name = <script_name>)`

This will create a new test script within the package testthat/ folder.

### Updating the package version

Once changes have been completed, reviewed and are ready for use in the wild, you
can increment the package version using:

`usethis::use_version()`

Once you've incremented the version number, it'll add a new heading to news.md.

Add a summary under news.md and then accept it's offer to commit on your behalf.

Once pushed and on the main branch, create a new release in GitHub itself.

### Running tests

You should run the following lines to test the package locally:
``` 
# To check functionality
devtools::check() # Ctrl-Shft-E
shinytest2::test_app("tests/test_dashboard") # important as not currently ran in CI checks, need to move this over

# For code styling
styler::style_pkg() # currently has a known error on cookies.R
lintr::lint_package()
```
