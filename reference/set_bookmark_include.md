# DfE bookmark include

This function allows for a whitelist of included inputs for bookmarking

## Usage

``` r
set_bookmark_include(input, bookmarking_whitelist)
```

## Arguments

- input:

  should be input, it pulls in the shiny inputs

- bookmarking_whitelist:

  list of inputs to include in bookmark

## Value

a bookmark with relevant inputs included

## Examples

``` r
# You will need a line such as this in your global.R script ================
# Here "dashboard_page" is the id of the tabsetPanel that your
# shinyGovstyle::service_navigation() links switch between
bookmarking_whitelist <- c("dashboard_page")

# In the server.R script ===================================================
shiny::observe({
  set_bookmark_include(input, bookmarking_whitelist)
  # Trigger this observer every time an input changes
  shiny::reactiveValuesToList(input)
  session$doBookmark()
  onBookmarked(function(url) {
    updateQueryString(url)
  })
})
```
