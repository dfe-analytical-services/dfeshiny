#' External link
#'
#' Intentionally basic wrapper for html anchor elements making it easier to
#' create safe external links with standard and accessible behaviour. For more
#' information on how the tag is generated, see \code{\link[htmltools]{tags}}.
#'
#' @description
#' It is commonplace for external links to open in a new tab, and when we do
#' this we should be careful...
#'
#' This function automatically adds the following to your link:
#' * `target="_blank"` to open in new tab
#' * `rel="noopener noreferrer"` to prevent [reverse tabnabbing](
#' https://owasp.org/www-community/attacks/Reverse_Tabnabbing)
#'
#' By default this function also adds "(opens in new tab)" to your link text
#' to warn users of the behaviour.
#'
#' This also adds "This link opens in a new tab" as a visually hidden span
#' element within the html outputted to warn non-visual users of the behaviour.
#'
#' Related links and guidance:
#'
#' * [Government digital services guidelines on the use of links](
#' https://design-system.service.gov.uk/styles/links/)
#'
#' * [Anchor tag html element and its properties](
#' https://developer.mozilla.org/en-US/docs/Web/HTML/Element/a)
#'
#' * [WCAG 2.2 success criteria 2.4.4: Link Purpose (In Context)](
#' https://www.w3.org/WAI/WCAG22/Understanding/link-purpose-in-context)
#'
#' * [Web Accessibility standards link text behaviour](
#' https://www.w3.org/TR/WCAG20-TECHS/G200.html)
#'
#' @param href URL that you want the link to point to
#' @param link_text Text that will appear describing your link, must be
#' descriptive of the page you are linking to. Vague text like 'click here' or
#' 'here' will cause an error.
#' @param add_warning Boolean for adding "(opens in new tab)" at the end of the
#' link text to warn users of the behaviour. Be careful and consider
#' accessibility before removing the visual warning.
#' @return shiny.tag object
#' @export
#'
#' @examples
#' external_link("https://shiny.posit.co/", "R Shiny")
#'
#' external_link(
#'   "https://shiny.posit.co/",
#'   "R Shiny",
#'   add_warning = FALSE
#' )
external_link <- function(href, link_text, add_warning = TRUE) {
  if (!is.logical(add_warning)) {
    stop("add_warning must be a TRUE or FALSE value")
  }

  # Create a basic check for raw URLs
  is_url <- function(text) {
    url_pattern <- "^(https://|http://|www\\.)"
    grepl(url_pattern, text)
  }

  if (is_url(link_text)) {
    stop(paste0(
      link_text,
      " has been recognise as a raw URL, please change the link_text value to",
      " a description of the page being linked to instead"
    ))
  }

  # Check against curated data set for link text we should banish into room 101
  if (tolower(link_text) %in% dfeshiny::bad_link_text$bad_link_text) {
    stop(
      paste0(
        link_text,
        " is not descriptive enough and has has been recognised as bad link",
        " text, please replace the link_text argument with more descriptive",
        " text."
      )
    )
  }

  if (add_warning) {
    link_text <- paste(link_text, "(opens in new tab)")
    hidden_span <- NULL # don't have extra hidden text if clear in main text
  } else {
    hidden_span <-
      htmltools::span(class = "visually-hidden", "This link opens in a new tab")
  }

  # Create link using htmltools::tags$a
  htmltools::tags$a(
    hidden_span,
    href = href,
    link_text,
    target = "_blank",
    rel = "noopener noreferrer",
    .noWS = "after"
  )
}
