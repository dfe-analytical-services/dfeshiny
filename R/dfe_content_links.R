#' Content links
#'
#' @description
#' Content links for the right hand navigation list panel
#'
#' @param links_list List of links for the navigation panel
#'
#' @returns
#' @export
#'
#' @examples
dfe_contents_links <- function(links_list) {
  # Add the HTML around the link and make an id by snake casing
  create_sidelink <- function(link_text) {
    tags$li(
      "—",
      actionLink(
        tolower(gsub(" ", "_", link_text)),
        link_text,
        `data-value` = link_text,
        class = "contents_link"
      )
    )
  }

  # The HTML div to be returned
  tags$div(
    style = "position: sticky; top: 0.5rem; padding: 0.25rem;", # Make it stick!
    h2("Contents"),
    tags$ul(
      id = "contents_links",
      style = "list-style-type: none; padding-left: 0; font-size: 1rem;", # remove the circle bullets
      lapply(links_list, create_sidelink)
    )
  )
}
