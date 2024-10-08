#' Custom disconnect message
#'
#'
#' @description
#' Create the HTML overlay panel to appear when RSConnect disconnects
#'
#' @param refresh the text to appear that will refresh the page when clicked
#' @param links A list of mirrors or alternative links to the dashboard
#' @param publication_name The parent publication name
#' @param publication_link The link to the publication on Explore Education
#' Statistics
#'
#' @importFrom htmltools tags tagList
#'
#' @return A HTML overlay panel that appears when RSConnect disconnects for a
#' public R Shiny dashboard in DfE
#' @export
#'
#' @examples
#' custom_disconnect_message(
#'   refresh = "Refresh page",
#'   links = c(
#'     "https://department-for-education.shinyapps.io/dfe-shiny-template/",
#'     "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
#'   ),
#'   publication_name = "Explore Education Statistics Publication",
#'   publication_link =
#'     "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
#' )
#'
custom_disconnect_message <- function(refresh = "Refresh page",
                                      links = NULL,
                                      publication_name = NULL,
                                      publication_link = NULL) {
  # Check links are valid

  is_valid_sites_list <- function(sites) {
    lapply(
      stringr::str_trim(sites), startsWith,
      "https://department-for-education.shinyapps.io/"
    )
  }

  if (FALSE %in% is_valid_sites_list(links) ||
    "https://department-for-education.shinyapps.io/" %in% links) { # nolint: [indentation_linter]
    stop("You have entered an invalid site link in the links argument.")
  }

  pub_prefix <- c(
    "https://explore-education-statistics.service.gov.uk/find-statistics/",
    "https://www.explore-education-statistics.service.gov.uk/find-statistics/",
    "https://www.gov.uk/",
    "https://gov.uk/"
  )

  is_valid_publication_link <- function(link) {
    startsWith(stringr::str_trim(link), pub_prefix)
  }

  if (RCurl::url.exists(publication_link) == FALSE ||
    (TRUE %in% is_valid_publication_link(publication_link)) == FALSE || # nolint: [indentation_linter]
    publication_link %in% pub_prefix) {
    stop("You have entered an invalid publication link in the publication_link
         argument.")
  }

  checkmate::assert_string(refresh)
  tagList(
    tags$script(
      paste0(
        "$(function() {",
        "  $(document).on('shiny:disconnected', function(event) {",
        "    $('#custom-disconnect-dialog').show();",
        "    $('#ss-overlay').show();",
        "  })",
        "});"
      )
    ),
    tags$div(
      id = "custom-disconnect-dialog",
      style = "display: none !important;",
      tags$div(
        id = "ss-connect-refresh",
        tags$p("You've lost connection to the dashboard server - please try
               refreshing the page:"),
        tags$p(tags$a(
          id = "ss-reload-link",
          href = "#", "Refresh page",
          onclick = "window.location.reload(true);"
        )),
        if (length(links) > 1) {
          tags$p(
            "If this persists, you can also view the dashboard at one of our
            mirror sites:",
            tags$p(
              tags$a(href = links[1], "Site 1"),
              " - ",
              tags$a(href = links[2], "Site 2"),
              if (length(links) == 3) {
                "-"
              },
              if (length(links) == 3) {
                tags$a(href = links[3], "Site 3")
              }
            )
          )
        },
        if (!is.null(publication_name)) {
          tags$p(
            "All the data used in this dashboard can also be viewed or
            downloaded via the ",
            tags$a(
              href = publication_link,
              publication_name
            ),
            "on Explore Education Statistics."
          )
        },
        tags$p(
          "Please contact",
          tags$a(
            href = "mailto:statistics.development@education.gov.uk",
            "statistics.development@education.gov.uk"
          ),
          "with details of any problems with this resource."
        )
      )
    ),
    tags$div(id = "ss-overlay", style = "display: none;"),
    tags$head(htmltools::tags$style(
      glue::glue(
        .open = "{{", .close = "}}",
        "#custom-disconnect-dialog a {
             display: {{ if (refresh == '') 'none' else 'inline' }} !important;
             color: #1d70b8 !important;
             font-size: 16px !important;
             font-weight: normal !important;
          }"
      )
    ))
  )
}
