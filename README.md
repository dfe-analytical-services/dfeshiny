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

### Adding cookies to your dashboard

dfeshiny provides the facility to add a gov.uk styled cookie banner to your 
site, which is fully functional in terms of controlling the user permissions for
tracking their use of the site via Google Analytics.

Before adding the cookie consent banner, you will need to obtain a Google 
Analytics key that's both unique to your app and stored within the DfE Google
Analytics domain. You can request a key from the 
[Statistics Development team](mailto:statistics.development@education.gov.uk). 
This should then be added as a variable to your dashboard's 
[global.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/global.R) 
file (replacing `ABCDE12345` below with the key provided by the Statistics 
Development team):

```
google_analytics_key <- 'ABCDE12345'
```

Next, you should copy the javascript file
([cookie_consent.js](https://raw.githubusercontent.com/dfe-analytical-services/dfeshiny/cookie-module/js/cookie-consent.js)) 
necessary for controlling the cookie storage in the user's browser to the `www/` 
folder in your dashboards repository.

Once you've made the above updates, add the following lines to your 
[ui.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/ui.R) 
script (updating "My DfE R Shiny data dashboard" with the name of your app):

```
dfe_cookie_script(),
cookie_banner_ui("cookies", name = "My DfE R Shiny data dashboard"),
```

Putting these on the lines *just before* the `shinyGovstyle::header(...)` line 
should work well.

Then add the following code to your
[server.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/server.R) 
script somewhere *inside* the `server <- function(input, output, session) {...}` 
function (you shouldn't need 
to change anything in this one):

```
output$cookie_status <- dfeshiny::cookie_banner_server(
  "cookies",
  input_cookies = reactive(input$cookies),
  input_clear = reactive(input$cookie_consent_clear),
  parent_session = session,
  google_analytics_key = google_analytics_key
)
```

Finally, you should make sure you're using the `dfeshiny::support_panel()` 
function within the `navListPanel(...)` in your 
[ui.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/ui.R) 
script as this will provide
users with the necessary explanatory text on how we use cookies and the ability 
to change their decision on whether or not to accept the use of cookies.

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
