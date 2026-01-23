# Department for Education Reactable Wrapper

A wrapper around the `reactable` function for creating styled,
accessible, and user-friendly tables tailored to the Department for
Education's requirements.

## Usage

``` r
dfe_reactable(data, ...)
```

## Arguments

- data:

  A data frame to display in the table.

- ...:

  Additional arguments passed to
  [`reactable::reactable`](https://glin.github.io/reactable/reference/reactable.html).

## Value

A `reactable` HTML widget object.

## Details

The `dfe_reactable` function provides a pre-configured version of the
`reactable` function with:

- **Highlighting**: Row highlighting enabled.

- **Borderless Table**: Removes borders for a clean look.

- **Sort Icons Hidden**: Sort icons are not displayed by default.

- **Resizable Columns**: Users can resize columns.

- **Full Width**: Table expands to the full width of the container.

- **Default Column Definition**: Custom column header styles, NA value
  handling, and alignment.

- **Custom Search Input**: A search bar styled to the Department for
  Education's specifications.

- **Custom Language**: Provides a user-friendly search placeholder text.

## Examples

``` r
if (interactive()) {
  library(shiny)
  library(dfeshiny)
  ui <- fluidPage(
    h1("Example of dfe_reactable in a Shiny app"),
    dfe_reactable(mtcars)
  )
  server <- function(input, output, session) {}
  shinyApp(ui, server)
}
```
