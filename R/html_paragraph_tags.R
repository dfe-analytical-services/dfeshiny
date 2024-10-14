#' Create tagList for HTML paragraph
#'
#' @description
#' Create a list of tags that generate a HTML paragraph.
#' This generates a header using shiny::tags$h2()
#' and a paragraph body using shiny::tags$p()
#'
#' This is to be used with `dfeshiny::suport_panel()` to add extra sections to a public R Shiny
#' dashboard in DfE
#'
#' @param heading A character vector for the heading of your paragraph
#' @param body A character vector for the body of your paragraph
#'
#' @return a list of HTML tags that contain and h2 heading and a paragraph body.
#' @seealso [support_panel()]
#' @export
#'
#' @examples
#' html_paragraph_tags(
#'   heading = "heading test",
#'   body = "this is a body text test"
#' )
html_paragraph_tags <- function(heading, body) {
  # check that a heading has been provided

  if (missing(heading)) {
    stop("Please provide a character vector for the 'heading' argument")
  }

  # check that a body has been provided

  if (missing(body)) {
    stop("Please provide a character vector for the 'body' argument")
  }

  # check class of inputs

  # check for heading arg

  if (!is.character(heading)) {
    stop(paste(
      "The provided vector for " / heading / " is ",
      data.class(heading),
      ". Please ensure that you enter a character vector instead"
    ))
  }

  # check or body arg
  if (!is.character(body)) {
    stop(paste(
      "The provided vector for " / body / " is ",
      data.class(body),
      ". Please ensure that you enter a character vector instead"
    ))
  }

  result <- shiny::tagList(
    shiny::tags$h2(
      heading
    ),
    shiny::tags$p(
      body
    )
  )

  return(result)
}
