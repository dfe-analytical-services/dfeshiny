#' Custom disconnect message
#'
#'
#' @description
#' Create the HTML overlay panel to appear when a user loses connection to a dashboard.
#'
#' @param refresh the text to appear that will refresh the page when clicked
#' @param links A vector of possible URLs for the public site. Should mostly just be a single URL,
#' but can be two URLs if an overflow site has been set up
#' @param publication_name The parent publication name
#' @param publication_link The link to the publication on Explore Education
#' Statistics
#' @param dashboard_title Title of the dashboard
#'
#' @importFrom htmltools tags tagList
#'
#' @return A HTML overlay panel that appears when a user loses connection to a DfE R Shiny
#' dashboard.
#' @export
#'
#' @examples
#' custom_disconnect_message(
#'   dashboard_title = "DfE Shiny Template",
#'   refresh = "Refresh page",
#'   links = c(
#'     "https://department-for-education.shinyapps.io/dfe-shiny-template",
#'     "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
#'   ),
#'   publication_name = "Explore Education Statistics Publication",
#'   publication_link =
#'     "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
#' )
#'
#' custom_disconnect_message(
#'   dashboard_title = "DfE Shiny Template",
#'   refresh = "Refresh page",
#'   links = c(
#'     "https://department-for-education.shinyapps.io/dfe-shiny-template"
#'   )
#' )
#'
custom_disconnect_message <- function(
    refresh = "Refresh page",
    dashboard_title = NULL,
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

  if (!is.null(publication_link)) {
    is_valid_publication_link <- function(link) {
      startsWith(stringr::str_trim(link), pub_prefix)
    }

    if (RCurl::url.exists(publication_link) == FALSE ||
      (TRUE %in% is_valid_publication_link(publication_link)) == FALSE || # nolint: [indentation_linter]
      publication_link %in% pub_prefix) {
      stop("You have entered an invalid publication link in the publication_link
         argument.")
    }
  }

  checkmate::assert_string(refresh)

  # Attach CSS from inst/www/css/visually-hidden.css
  dependency <- htmltools::htmlDependency(
    name = "disconnect-dialogue",
    version = as.character(utils::packageVersion("dfeshiny")[[1]]),
    src = c(href = "dfeshiny/css"),
    stylesheet = "disconnect-dialogue.css"
  )

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
        role = "alert",
        tags$p(
          "Sorry, you have lost connection to the",
          dashboard_title,
          "dashboard at the moment, please ",
          tags$a(
            id = "ss-reload-link",
            href = "#", "refresh the page",
            onclick = "window.location.reload(true);",
            .noWS = c("after")
          ),
          "."
        ),
        if (length(links) > 1) {
          tags$p(
            "If you are still experiencing issues, please try our",
            tags$a(href = links[2], "alternative site", .noWS = c("after")),
            ". Apologies for the inconvenience."
          )
        },
        if (!is.null(publication_name)) {
          tags$p(
            "All the data used in this dashboard can also be viewed or downloaded via the ",
            dfeshiny::external_link(
              href = publication_link,
              publication_name
            ),
            " on Explore Education Statistics."
          )
        },
        tags$p(
          "Feel free to contact ",
          dfeshiny::external_link(
            href = "mailto:explore.statistics@education.gov.uk",
            "explore.statistics@education.gov.uk",
            add_warning = FALSE
          ),
          " if you require further support."
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
  ) |>
    htmltools::attachDependencies(dependency, append = TRUE)
}
