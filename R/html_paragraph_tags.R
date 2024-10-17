#' Create `shiny::tagList()` for HTML paragraph
#'
#' @description
#' Create a list of tags that generate a HTML paragraph.
#' This generates a header using shiny::tags$h2()
#' and a paragraph body using shiny::tags$p()
#'
#' This is to be used with `dfeshiny::suport_panel()` to add extra sections to a public R Shiny
#' dashboard in DfE
#'
#' @param heading Optional - A single vector or a combined vector wrapped in
#' `shiny::tagList()` instead of c() for the heading of your paragraph
#' @param body A single vector or a combined vector wrapped in
#' `shiny::tagList()` instead of c() for the body of your paragraph
#'
#' @return A list of HTML tags that contain and h2 heading and a paragraph body.
#' @seealso [support_panel()]
#' @export
#'
#' @examples
#'
#' # Example for text heading and body
#' html_paragraph_tags(
#'   heading = "Heading test",
#'   body = "This is a body text test"
#' )
#'
#' # Example for text heading and text with other elements in the body
#'
#'
#' html_paragraph_tags(
#'   heading = "Heading test",
#'   body = shiny::tagList(
#'     "This is a body text test. Please contact us at",
#'     dfeshiny::external_link(
#'       href = paste0("mailto:", "team@@education.gov.uk"),
#'       link_text = "team@@education.gov.uk",
#'       add_warning = FALSE
#'     )
#'   )
#' )
#'
html_paragraph_tags <- function(heading = NULL,
                                body) {
  # check that a body has been provided

  if (missing(body)) {
    stop("Please provide a single vector or a combined vector wrapped in shiny::tagList() for the
         'body' argument")
  }

  # check for combined vector wrapping
  # if a vector is provided and its length is >1 then it's a combined vector

  if (is.vector(heading) && length(heading) > 1) {
    stop("You provided a combined vector for the heading argument wrapped in c().
         Please wrap it in shiny::tagList() instead.")
  }

  if (is.vector(body) && length(body) > 1) {
    stop("You provided a combined vector for the body argument wrapped in c().
         Please wrap it in shiny::tagList() instead.")
  }


  if (!is.null(heading)) {
    result <- shiny::tagList(
      shiny::tags$h2(
        heading
      ),
      shiny::tags$p(
        body
      )
    )
  } else {
    result <- shiny::tagList(
      shiny::tags$p(
        body
      )
    )
  }

  return(result)
}
