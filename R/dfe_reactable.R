#' Department for Education Reactable Wrapper
#'
#' A wrapper around the `reactable` function for creating styled, accessible,
#' and user-friendly tables tailored to the Department for Education's
#' requirements.
#'
#' @param data A data frame to display in the table.
#' @param ... Additional arguments passed to `reactable::reactable`.
#'
#' @details
#' The `dfe_reactable` function provides a pre-configured version of
#' the `reactable` function with:
#' \itemize{
#'   \item **Highlighting**: Row highlighting enabled.
#'   \item **Borderless Table**: Removes borders for a clean look.
#'   \item **Sort Icons Hidden**: Sort icons are not displayed by default.
#'   \item **Resizable Columns**: Users can resize columns.
#'   \item **Full Width**: Table expands to the full width of the container.
#'   \item **Default Column Definition**: Custom column header styles,
#'   NA value handling,
#'         and alignment.
#'   \item **Custom Search Input**: A search bar styled to the Department
#'   for Education's specifications.
#'   \item **Custom Language**: Provides a user-friendly search placeholder
#'   text.
#' }
#'
#' @return A `reactable` HTML widget object.
#'
#' @examples
#' if (interactive()) {
#'   library(shiny)
#'   library(dfeshiny)
#'   ui <- fluidPage(
#'     h1("Example of dfe_reactable in a Shiny app"),
#'     dfe_reactable(mtcars)
#'   )
#'   server <- function(input, output, session) {}
#'   shinyApp(ui, server)
#' }
dfe_reactable <- function(data, ...) {
  reactable::reactable(
    data,
    highlight = TRUE,
    borderless = TRUE,
    showSortIcon = FALSE,
    resizable = TRUE,
    fullWidth = TRUE,
    defaultColDef = reactable::colDef(
      headerClass = "govuk-table__header",
      html = TRUE,
      na = "NA",
      minWidth = 65,
      align = "left",
      class = "govuk-table__cell"
    ),
    rowClass = "govuk-table__cell",
    language = reactable::reactableLang(
      searchPlaceholder = "Search table..."
    ),
    theme = reactable::reactableTheme(
      searchInputStyle = list(
        float = "right",
        width = "25%",
        marginBottom = "10px",
        padding = "5px",
        fontSize = "14px",
        border = "1px solid #ccc",
        borderRadius = "5px"
      )
    ),
    class = "gov-table",
    ...
  )
}
