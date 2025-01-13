#' Department for Education Reactable Wrapper
#'
#' A wrapper around the `reactable` function for creating styled, accessible,
#' and user-friendly tables tailored to the Department for Education's requirements.
#'
#' @param data A data frame to display in the table.
#' @param columns A named list of column definitions created with `reactable::colDef()`.
#' @param columnGroups A list of column groups created with `reactable::colGroup()`.
#' @param rownames Logical or character. If `TRUE`, show row names. If a string, the row names
#'   will be displayed in a column with that name. Defaults to `NULL`.
#' @param groupBy A character vector of column names to group rows by.
#' @param sortable Logical. Enable sorting for all columns by default.
#' @param filterable Logical. Enable column filters.
#' @param searchable Logical. Add a global search box.
#' @param searchMethod Custom search function for global search.
#' @param defaultColDef Default column settings created with `reactable::colDef()`.
#' @param defaultColGroup Default column group settings created with `reactable::colGroup()`.
#' @param defaultSortOrder The default sort order for sortable columns. One of `"asc"` or `"desc"`.
#' @param defaultSorted A named list or character vector of columns to sort by default.
#' @param pagination Logical. Enable pagination.
#' @param defaultPageSize Number of rows to show per page by default.
#' @param showPageSizeOptions Logical. Allow users to change the page size.
#' @param pageSizeOptions A vector of page size options for the page size dropdown.
#' @param paginationType Pagination control type. One of `"numbers"` or `"jump"`.
#' @param showPagination Logical. Show pagination controls.
#' @param showPageInfo Logical. Show page info (e.g., "1–10 of 100 rows").
#' @param minRows Minimum number of rows to show, even when the data has fewer rows.
#' @param paginateSubRows Logical. Paginate sub rows when rows are grouped.
#' @param details A function or formula for creating expandable row details.
#' @param defaultExpanded Logical or character vector. Expand rows by default.
#' @param selection Selection mode. One of `"multiple"`, `"single"`, or `"none"`.
#' @param defaultSelected A character vector of row names or indices to select by default.
#' @param onClick Callback function for row click events.
#' @param striped Logical. Add zebra-striping to rows.
#' @param compact Logical. Make rows compact.
#' @param wrap Logical. Allow cell text to wrap.
#' @param class CSS class to apply to the table.
#' @param style Inline styles to apply to the table.
#' @param rowClass CSS class to apply to each row.
#' @param rowStyle Inline styles to apply to each row.
#' @param width Table width in pixels or as a CSS value.
#' @param height Table height in pixels or as a CSS value.
#' @param meta Arbitrary metadata to include with the table.
#' @param elementId Element ID for the table widget.
#' @param static Logical. Render a static (non-interactive) table.
#' @param selectionId Element ID to store selected row indices.
#' @param ... Additional arguments passed to `reactable::reactable`.
#'
#' @details
#' The `dfe_reactable` function provides a pre-configured version of the `reactable` function with:
#' \itemize{
#'   \item **Highlighting**: Row highlighting enabled.
#'   \item **Borderless Table**: Removes borders for a clean look.
#'   \item **Sort Icons Hidden**: Sort icons are not displayed by default.
#'   \item **Resizable Columns**: Users can resize columns.
#'   \item **Full Width**: Table expands to the full width of the container.
#'   \item **Default Column Definition**: Custom column header styles, NA value handling,
#'         and alignment.
#'   \item **Custom Search Input**: A search bar styled to the Department for Education's specifications.
#'   \item **Custom Language**: Provides a user-friendly search placeholder text.
#' }
#'
#' @return A `reactable` HTML widget object.
#'
#' @examples
#' if (interactive()) {
#'   library(reactable)
#'   dfe_reactable(mtcars)
#' }
#'
#' @export


dfe_reactable <- function(data, ...) {
  reactable::reactable(
    data,
    highlight = TRUE,
    borderless = TRUE,
    showSortIcon = FALSE,
    resizable = TRUE,
    fullWidth = TRUE,
    defaultColDef = reactable::colDef(
      headerClass = "bar-sort-header",
      html = TRUE,
      na = "NA",
      minWidth = 65,
      align = "left"
    ),
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
    ...
  )
}
