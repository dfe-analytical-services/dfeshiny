# DfE header banner

This function uses
[`shinyGovstyle::header()`](https://rdrr.io/pkg/shinyGovstyle/man/header.html)
to create a header banner using the DfE logo.

## Usage

``` r
header(header, ...)
```

## Arguments

- header:

  Text to use for the header of the dashboard

- ...:

  Further arguments passed to shinyGovstyle::header()

## Value

a header html shiny object

## See also

[`shinyGovstyle::header()`](https://rdrr.io/pkg/shinyGovstyle/man/header.html)

## Examples

``` r
if (interactive()) {
  ui <- fluidPage(
    dfeshiny::header(
      header = "User Examples"
    )
  )

  server <- function(input, output, session) {}

  shinyApp(ui = ui, server = server)
}
```
