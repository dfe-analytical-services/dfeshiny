#' DfE bookmark include
#'
#' @description
#' This function allows for a whitelist of included inputs
#' for bookmarking
#'
#' @param bookmarkingWhitelist list of inputs to include in bookmark
#' @return a bookmark with relevant inputs included
#'
#' @export
#' @examples
#' # You will need a line such as this in your global.R script ================
#' bookmarkingWhitelist <- c("navlistPanel", "tabsetpanels")
#'
#' # In the server.R script ===================================================
#' shiny::observe({
#'   setBookmarkInclude(bookmarkingWhitelist)
#' })
#'
#' observe({
#'   # Trigger this observer every time an input changes
#'   reactiveValuesToList(input)
#'   session$doBookmark()
#' })
#'
#' onBookmarked(function(url) {
#'   updateQueryString(url)
#' })
setBookmarkInclude <- function(bookmarkingWhitelist) {
  # exclude the white list from complete list
  toExclude <- setdiff(names(input), bookmarkingWhitelist)

  # print to log for testing
  # print(paste("ExcludedIDs:", paste(toExclude, collapse = ", ")))

  # exclude all remaining inputs from bookmark
  setBookmarkExclude(toExclude)

  print("bookmarked")
  # Trigger bookmarking whenever relevant inputs change
  session$doBookmark()
}
