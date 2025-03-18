#' DfE bookmark include
#'
#' @description
#' This function allows for a whitelist of included inputs
#' for bookmarking
#'
#' @param bookmarking_whitelist list of inputs to include in bookmark
#' @param input should be input, it pulls in the shiny inputs
#' @return a bookmark with relevant inputs included
#'
#' @export
#' @examples
#' # You will need a line such as this in your global.R script ================
#' bookmarking_whitelist <- c("navlistPanel", "tabsetpanels")
#'
#' # In the server.R script ===================================================
#' shiny::observe({
#'   set_bookmark_include(input, bookmarking_whitelist)
#' })
#'
#' shiny::observe({
#'   # Trigger this observer every time an input changes
#'   shiny::reactiveValuesToList(input)
#'   session$doBookmark()
#'   onBookmarked(function(url) {
#'     updateQueryString(url)
#'   })
#' })
set_bookmark_include <- function(input, bookmarking_whitelist) {
  # exclude the white list from complete list
  to_exclude <- setdiff(names(input), bookmarking_whitelist)

  # exclude all remaining inputs from bookmark
  shiny::setBookmarkExclude(to_exclude)
}
