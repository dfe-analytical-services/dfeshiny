#' External link
#'
#' Intentionally basic wrapper for html anchor elements making it easier to
#' create safe external links with standard and accessible behaviour.
#'
#' @description
#' It is commonplace for external links to open in a new tab, and when we do
#' this we should be careful to avoid [reverse tabnabbing]
#' (https://owasp.org/www-community/attacks/Reverse_Tabnabbing).
#'
#' This function automatically adds the following to your link:
#' * target="_blank" to open in new tab
#' * rel="noopener noreferrer" to prevent reverse tabnabbing
#'
#' By default this function also adds "(opens in new tab)" to your link text
#' to warn users of the behaviour as recommended by
#' [Web Accessibility standards](https://www.w3.org/TR/WCAG20-TECHS/G200.html).
#'
#' This also adds "This link opens in a new tab" as a visually hidden span
#' element within the html outputted to warn non-visual users of the behaviour.
#'
#' @param href URL that you want the link to point to
#' @param link_text Text that will appear describing your link, must be
#' descriptive of the page you are linking to. Vague text like 'click here' or
#' 'here' will cause an error.
#' @param add_warning Boolean for adding "(opens in new tab)" at the end of the
#' link text to warn users of the behaviour. Use with caution and
#' [consider accessibility](https://www.w3.org/TR/WCAG20-TECHS/G200.html)
#' if turning off.
#'
#' @return shiny.tag object
#' @export
#'
#' @examples
#' external_link("https://shiny.posit.co/", "R Shiny")
#'
#' external_link(
#' "https://shiny.posit.co/",
#' "R Shiny",
#' add_warning = FALSE
#' )
external_link <- function(href, link_text, add_warning = TRUE){
  if(!is.logical(add_warning)){
    stop("add_warning must be a TRUE or FALSE value")
  }

  # TODO: tidy this up
  # Crude vector for bad link text we should banish into room 101
  bad_text <- c(
    "Click here",
    "Learn more",
    "Read more",
    "Further information",
    "Click this link",
    "Download file",
    "Download png",
    "Download svg",
    "Download jpg",
    "Download jpeg",
    "Download xslx",
    "Download csv",
    "Download word",
    "Download document",
    "Download pdf",
    "Web page",
    "Web site",
    "Download here",
    "Go here",
    "This page",

    "file",
    "pdf", "svg", "jpg", "jpeg", "xslx", "csv", "word", "document",
    "Click",
    "Here",
    "This",
    "Form",
    "learn",
    "More",
    "read",
    "Information",
    "Download",
    "File",
    "Guidance",
    "Link",
    "page",
    "web",
    "page",
    "site",

    "Webpage",
    "website",
    "Dashboard",
    "Next",
    "previous",


  )

  # TODO: add a check for any raw URLs

  if(tolower(link_text) %in% bad_text){
    stop(
      paste0(
        link_text,
        " is not descriptive enough and is has been recognised as bad link ",
        " text, please replace the link_text argument with more descriptive",
        " text."
        )
    )
  }

  if(add_warning){
    link_text <- paste(link_text, "(opens in new tab)")
  }

  # Put these through htmltools::tags$a
  htmltools::tags$a(
    htmltools::span(class = "visually-hidden", "This link opens in a new tab"),
    href = href,
    link_text,
    target="_blank",
    rel="noopener noreferrer"
  )
}
