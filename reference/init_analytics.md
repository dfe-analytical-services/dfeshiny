# init_analytics

Creates the google-analytics.html script in order to allow the
activation of analytics via GA4. For the full steps required to set up
analytics, please refer to the documentation in the README.

## Usage

``` r
init_analytics(ga_code, create_file = TRUE)
```

## Arguments

- ga_code:

  The Google Analytics code for the dashboard

- create_file:

  Boolean TRUE or FALSE, default is TRUE, false will return the HTML in
  the console and is used mainly for testing or comparisons

## Examples

``` r
if (interactive()) {
  init_analytics(ga_code = "0123456789")
}
```
