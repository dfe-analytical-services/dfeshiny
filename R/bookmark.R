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
#' bookmarking_whitelist <- c("navlistPanel", "tabsetpanels")
#'
#' # In the server.R script ===================================================
#' shiny::observe({
#'   set_bookmark_include(session, input, bookmarking_whitelist)
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
set_bookmark_include <- function(session, input, bookmarking_whitelist) {
  # exclude the white list from complete list
  to_exclude <- setdiff(names(input), bookmarking_whitelist)

  # exclude all remaining inputs from bookmark
  shiny::setBookmarkExclude(to_exclude)

  # Trigger bookmarking whenever relevant inputs change
  session$doBookmark()
}
