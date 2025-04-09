#' Custom disconnect message
#'
#'
#' @description
#' Create the HTML overlay panel to appear when a user loses connection to a dashboard.
#'
#' @param refresh the text to appear that will refresh the page when clicked
#' @param reset the text to appear that will reset the page when clicked
#' @param links A vector of possible URLs for the public site. Should mostly just be a single URL,
#' but can be two URLs if an overflow site has been set up
#' @param custom_refresh Custom refresh link, defaults to refreshing the page, main value is if you
#' have bookmarking enabled and want the refresh to send to the initial view instead of reloading
#' any bookmarks
#' @param custom_reset Custom reset link, defaults to resetting the page
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
#' custom_disconnect_message(
#'   support_contact = "my.team@education.gov.uk",
#'   custom_refresh = "https://department-for-education.shinyapps.io/my-dashboard"
#' )
custom_disconnect_message <- function(
  refresh = "refresh page (attempting to keep your last known selections)",
  reset = "reset page (removing any previous selections)",
  dashboard_title = NULL,
  links = NULL,
  publication_name = NULL,
  publication_link = NULL,
  support_contact = "explore.statistics@education.gov.uk",
  custom_refresh = NULL,
  custom_reset = NULL
) {
  # Check links are valid
  if (
    FALSE %in%
      validate_dashboard_url(links) ||
      "https://department-for-education.shinyapps.io/" %in% links
  ) {
    # nolint: [indentation_linter]
    stop("You have entered an invalid site link in the links argument.")
  }

  if (!is.null(custom_refresh)) {
    is_valid_refresh <- function(refresh) {
      startsWith(
        stringr::str_trim(refresh),
        "https://department-for-education.shinyapps.io/"
      )
    }

    if (is_valid_refresh(custom_refresh) == FALSE) {
      stop(
        paste0(
          "You have entered an invalid site link in the custom_refresh argument. It must be a site",
          " on shinyapps.io."
        )
      )
    }
  }

  if (!is.null(custom_reset)) {
    is_valid_reset <- function(reset) {
      startsWith(
        stringr::str_trim(reset),
        "https://department-for-education.shinyapps.io/"
      )
    }

    if (is_valid_reset(custom_reset) == FALSE) {
      stop(
        paste0(
          "You have entered an invalid site link in the custom_reset argument. It must be a site",
          " on shinyapps.io."
        )
      )
    }
  }

  pub_prefix <- c(
    "https://explore-education-statistics.service.gov.uk/find-statistics/",
    "https://www.explore-education-statistics.service.gov.uk/find-statistics/",
    "https://www.gov.uk/",
    "https://gov.uk/",
    "https://github.com/dfe-analytical-services/"
  )

  if (!is.null(publication_link)) {
    is_valid_publication_link <- function(link) {
      startsWith(stringr::str_trim(link), pub_prefix)
    }

    if (
      TRUE %in% is_valid_publication_link(publication_link) == FALSE ||
        publication_link %in% pub_prefix
    ) {
      # nolint: [indentation_linter]
      stop(
        "You have entered an invalid publication link in the publication_link
         argument."
      )
    }
  }

  # TODO: Add email validation once a11y panel PR is in

  checkmate::assert_string(refresh)
  checkmate::assert_string(reset)

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
        "  });",
        "});"
      )
    ),
    tags$head(
      tags$style(
        htmltools::HTML(
          "
          /* Hide the default Shiny disconnect message */
          #shiny-disconnected-overlay {
              display: none !important;
          }
          "
        )
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
          if (is.null(custom_refresh)) {
            tags$a(
              id = "ss-reload-link",
              href = "#",
              refresh,
              onclick = "window.location.reload(true);",
              .noWS = c("after")
            )
          } else {
            tags$a(
              id = "ss-reload-link",
              href = custom_refresh,
              refresh,
              .noWS = c("after")
            )
          },
          ", or ",
          if (is.null(custom_reset)) {
            tags$a(
              id = "ss-reset-link",
              href = "#",
              reset,
              onclick = "window.location.reload(false);",
              .noWS = c("after")
            )
          } else {
            tags$a(
              id = "ss-reset-link",
              href = custom_reset,
              reset,
              .noWS = c("after")
            )
          },
          "."
        ),
        if (length(links) > 1) {
          tags$p(
            "If you are still experiencing issues, please try our",
            tags$a(href = links[2], "alternative site", .noWS = c("after")),
            ". Apologies for the inconvenience."
          )
        },
        if (
          !is.null(publication_name) &&
            grepl("explore-education-statistics", publication_link)
        ) {
          tags$p(
            "The data used in this dashboard can also be viewed or downloaded via the ",
            dfeshiny::external_link(
              href = publication_link,
              publication_name
            ),
            " on explore education statistics."
          )
        } else if (!is.null(publication_name)) {
          tags$p(
            "The data used in this dashboard can also be viewed or downloaded from ",
            dfeshiny::external_link(
              href = publication_link,
              publication_name
            )
          )
        },
        tags$p(
          "Feel free to contact ",
          dfeshiny::external_link(
            href = paste0("mailto:", support_contact),
            support_contact,
            add_warning = FALSE
          ),
          " if you require further support."
        )
      )
    ),
    tags$div(id = "ss-overlay", style = "display: none;"),
    tags$head(htmltools::tags$style(
      glue::glue(
        .open = "{{",
        .close = "}}",
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
