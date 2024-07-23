# dfeshiny <a href="https://dfe-analytical-services.github.io/dfeshiny/"><img src="man/figures/logo.png" align="right" height="120" alt="dfeshiny website" /></a>

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

## Installing functionality in development from a branch

It can be useful when developing the package in particular to trial new or updated functionality in a shiny app. To do this, you can install the required branch using (replacing `branch-name` with the name of the branch you wish to install):

`renv::install("dfe-analytical-services/dfeshiny@branch-name")`

That will install the code from the named branch as dfeshiny in your app. You will need to restart your R session before it will start using the latest version that you've installed.

## Potential errors when installing

If you get `ERROR [curl: (22) The requested URL returned error: 401]`, and don't know why, try running `Sys.unsetenv("GITHUB_PAT")` to temporarily clear your GitHub PAT variable.

Then try to install again. 

If this works, then you will need to look for where that "GITHUB_PAT" variable is being set from and remove it to permanently fix the issue, contact us for support if you need help with this or have any other issues installing.

## Using this package in a DfE data dashboard

### Adding analytics to your dashboard

For analytics to function on your dashboard, you will need to:

- request a Google Analytics key from the [Explore Educaion Statisics platforms team](mailto:explore.statistics@education.gov.uk)
- create a html file with the javascript required for your dashboard to connect to Google Analytics
- add the line: `tags$head(includeHTML(("google-analytics.html"))),` to the ui.R file.

To create the latter, we provide the function `dfeshiny::init_analytics()`. You should run this code from the R console providing your Google Analytics code as follows (replacing `ABCDE12345` with the code obtained from the [Explore Education Statistics platforms](explore.statistics@education.gov.uk) team):

```
init_analytics("ABCDE12345")
```

This will create the file [google-analytics.html](google-analytics.html) within the home directory of your R project. This html file can be edited to add customised analytics recorders for different shiny elements in your dashboard. Feel free to contact our team if you need support in adding additional functionality.

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
