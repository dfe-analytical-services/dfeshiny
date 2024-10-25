#' Create `shiny::tagList()` for HTML section
#'
#' @description
#' Create a list of tags that generate a HTML section.
#' This generates a header using `shiny::tags$h2()`
#' and a paragraph body using `shiny::tags$p()`
#'
#' This is to be used with functions in the `dfeshiny` package
#' to add extra sections to a public R Shiny dashboard in DfE
#'
#' @param heading Optional - A single text string or a `shiny::tagList()` object
#'  for the heading of your paragraph
#' @param body A single text string or a `shiny::tagList()` object
#' for the body of your paragraph
#' @param h_level  Specify the level for your heading, if you choose to include
#' one. Default is "h2". Available options are "h2","h3" or "h4".
#'
#' @return A list of HTML tags that contain a paragraph body and an optional heading.
#' @seealso [support_panel()]
#' @seealso [htmltools::tags]
#' @seealso [htmltools::tagList()]
#' @export
#'
#' @examples
#'
#' # Example for text heading and body
#' section_tags(
#'   heading = "Heading test",
#'   body = "This is a body text test"
#' )
#'
#' # Example for using a different heading level
#' section_tags(
#'   heading = "Heading test",
#'   body = "This is a body text test",
#'   h_level = "h3"
#' )
#'
#'
#' # Example for text heading and text with other elements in the body
#'
#'
#' section_tags(
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
section_tags <- function(heading = NULL,
                         body,
                         h_level = "h2") {
  # check that a body has been provided

  if (missing(body)) {
    stop("Please provide a single text string or a `shiny::tagList()` object for the
         'body' argument")
  }

  # check that h_level is an accepted one

  if (!h_level %in% c("h2", "h3", "h4")) {
    stop("You used an unavailable h_level option.
          Please use one of the following levels: 'h2','h3'or 'h4'")
  }

  # check for combined vector wrapping
  # if a vector is provided and its length is >1 then it's a combined vector

  if (is.vector(heading) && length(heading) > 1) {
    stop("You provided a vector for the heading argument wrapped in c().
         Please wrap it in shiny::tagList() instead.")
  }

  if (is.vector(body) && length(body) > 1) {
    stop("You provided a vector for the body argument wrapped in c().
         Please wrap it in shiny::tagList() instead.")
  }

  # if headings are provided, do a check for h_level
  if (!is.null(heading)) {
    # if h_level = "h4"
    if (h_level == "h4") {
      result <- shiny::tagList(
        shiny::tags$h4(
          heading
        ),
        shiny::tags$p(
          body
        )
      )
      # if h_level = "h4"
    } else if (h_level == "h3") {
      result <- shiny::tagList(
        shiny::tags$h3(
          heading
        ),
        shiny::tags$p(
          body
        )
      )
    } else {
      # otherwise, use h2
      result <- shiny::tagList(
        shiny::tags$h2(
          heading
        ),
        shiny::tags$p(
          body
        )
      )
    }
    # if no heading is provided, just output the body
  } else {
    result <- shiny::tagList(
      shiny::tags$p(
        body
      )
    )
  }


  return(result)
}
