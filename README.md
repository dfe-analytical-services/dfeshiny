# dfeshiny <a href="http://dfe-analytical-services.github.io/dfeshiny/"><img src="man/figures/dfeshiny.png" align="right" height="138" /></a>

<!-- badges: start -->
[![R-CMD-check](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dfe-analytical-services/dfeshiny/actions/workflows/R-CMD-check.yaml)
[![Codecov test coverage](https://codecov.io/gh/dfe-analytical-services/dfeshiny/branch/main/graph/badge.svg)](https://app.codecov.io/gh/dfe-analytical-services/dfeshiny?branch=main)
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

An R package to support analysts in developing official DfE dashboards and help 
them meet the necessary standards required of public facing government services.

## Installation

dfeshiny is not currently available on CRAN. For the time being you can
install the development version from GitHub.

If you are using
[renv](https://rstudio.github.io/renv/articles/renv.html) in your
project (recommended):

``` r
renv::install("dfe-analytical-services/dfeR")
```

Otherwise:

``` r
# install.packages("devtools")
devtools::install_github("dfe-analytical-services/dfeR")
```

To install a specific branch, use @<branch> for example:
```r
renv::install("dfe-analytical-services/dfeshiny@branch_name")
```

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

Ideas for dfeshiny should first be raised as a [GitHub
issue](https://github.com/dfe-analytical-services/dfeshiny) after which
anyone is free to write the code and create a pull request for review.

For more details on contributing to dfeshiny, see our [contributing
guidelines](https://dfe-analytical-services.github.io/dfeshiny/CONTRIBUTING.html).
