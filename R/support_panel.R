#' Support panel
#'
#' @description
#' Create the standard DfE R-Shiny support and feedback dashboard panel.
#'
#' @param team_email Your team e-mail address, must be a education.gov.uk email
#' @param repo_name The repository URL, must be a valid URL for the
#' dfe-analytical-services GitHub area or the dfe-gov-uk Azure DevOps
#' @param ees_publication Whether the parent publication is hosted on Explore
#' Education Statistics
#' @param publication_slug The parent publication slug on Explore Education
#' Statistics
#' @param alt_href Alternative link to the parent publication (if not hosted on
#' Explore Education Statistics)
#' @param custom_data_info A single text string or a `shiny::tagList()` object
#'  for custom text to go under the "Find out more information on the data" heading.
#' @param extra_text Add extra paragraphs to the page before the "Contact us" section.
#' Use `dfeshiny::section_tags()` to specify the heading and body.
#' Look at examples to see how to add one or multiple sections.
#' @inheritParams create_dashboard
#'
#' @return a HTML div, containing standard support content for a public R Shiny
#' dashboard in DfE
#' @seealso [section_tags()]
#' @seealso [htmltools::tagList()]
#' @export
#'
#' @examples
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com"
#' )
#'
#' # Often you will use this inside a set of navigation tabs, e.g.
#' shiny::navlistPanel(
#'   "",
#'   id = "navlistPanel",
#'   widths = c(2, 8),
#'   well = FALSE,
#'   ## Support panel --------------------------------------------------------
#'   shiny::tabPanel(
#'     value = "support_panel",
#'     "Support and feedback",
#'     support_panel(
#'       team_email = "explore.statistics@@education.gov.uk",
#'       repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
#'       form_url = "https://forms.office.com"
#'     )
#'   )
#' )
#'
#' # Example for adding custom text
#'
#' # Adding custom text to the feedback section only
#'
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com",
#'   custom_data_info = "This is a sentence to test the ability to add custom text in the tab",
#' )
#'
#' # Adding custom text that includes mixed elements to feedback section
#'
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com",
#'   custom_data_info = shiny::tagList(
#'     "Please email results to",
#'     external_link(
#'       href = paste0("mailto:", "team@@education.gov.uk"),
#'       link_text = "team@@education.gov.uk",
#'       add_warning = FALSE
#'     )
#'   )
#' )
#' # Example for adding custom sections
#'
#' # Adding one section
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   custom_data_info = "This is a sentence to test the ability to add custom text in the tab",
#'   extra_text = section_tags(
#'     heading = "heading",
#'     body = "this is a body"
#'   )
#' )
#' # Adding two sections
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   extra_text = c(
#'     section_tags(
#'       heading = "heading",
#'       body = "this is a body"
#'     ),
#'     section_tags(
#'       heading = "heading 2",
#'       body = "this is another example of a text"
#'     )
#'   )
#' )
#'
#' # Adding a section with a shiny::tagList() in
#' # the dfeshiny::section_tags()
#'
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   extra_text = c(
#'     section_tags(
#'       heading = "Heading",
#'       body = shiny::tagList(
#'         "Please email results to",
#'         external_link(
#'           href = paste0("mailto:", "team@@education.gov.uk"),
#'           link_text = "team@@education.gov.uk",
#'           add_warning = FALSE
#'         )
#'       )
#'     )
#'   )
#' )
support_panel <- function(
  team_email = "",
  repo_name = "",
  ees_publication = TRUE,
  publication_name = NULL,
  publication_slug = "",
  alt_href = NULL,
  form_url = NULL,
  custom_data_info = NULL,
  extra_text = NULL
) {
  if (is_valid_dfe_email(team_email) == FALSE) {
    stop(
      "You have entered an invalid email in the team_email argument.
      Please enter an @education.gov.uk email."
    )
  }

  if (repo_name == "") {
    stop(
      "The repo_name argument is empty, please specify a value for repo_name"
    )
  }

  if (is_valid_repo_url(repo_name) == FALSE) {
    stop(
      "Please ensure the repo_name argument is a valid URL for a repository on
      either the dfe-analytical-services GitHub area, for example:
      repo_name = 'https://github.com/dfe-analytical-services/dfeR',
      or the dfe-gov-uk area, for example:
      repo_name = 'https://dfe-gov-uk.visualstudio.com/stats-development/_git/dashboard-analytics'
      "
    )
  }

  # check for extra text
  # if it's null, provide an empty string
  if (is.null(extra_text)) {
    extra_text <- ""
  } else {
    # if not, then use the provided extra_text
    extra_text <- extra_text
  }

  # Build the support page ----------------------------------------------------
  shiny::tags$div(
    style = "margin-top: 50px; margin-bottom: 50px",
    shiny::tags$h1("Support and feedback"),
    shiny::tags$h2("Give us feedback"),
    shiny::tags$div(
      if (!is.null(form_url)) {
        shiny::tags$p(
          "This dashboard is a new service that we are developing. If you
              have any feedback or suggestions for improvements, please submit
              them using our ",
          dfeshiny::external_link(
            href = form_url,
            link_text = "feedback form"
          ),
          "."
        )
      } else {
        shiny::tags$p(
          "This dashboard is a new service that we are developing."
        )
      },
      shiny::tags$p(
        paste0(
          ifelse(
            !is.null(form_url),
            "Alternatively, i",
            "I"
          ),
          "f you spot any errors or bugs while using this dashboard, please
              screenshot and email them to "
        ),
        dfeshiny::external_link(
          href = paste0("mailto:", team_email),
          link_text = team_email,
          add_warning = FALSE
        ),
        "."
      )
    ),
    shiny::tags$h2("Find more information on the data"),
    # if custom_data_info is provided, use section_tags
    # to get tag list for custom text
    if (!is.null(custom_data_info)) {
      section_tags(body = custom_data_info)
      # if custom_data_info  is not provided, run code as usual
    } else {
      if (ees_publication) {
        shiny::tags$p(
          "The parent statistical release of this dashboard, along with
              methodological information,
              is available at ",
          dfeshiny::external_link(
            href = paste0(
              "https://explore-education-statistics.service.gov.uk/find-statistics/", # nolint: [line_length_linter]
              publication_slug
            ),
            link_text = ifelse(
              !is.null(publication_name),
              publication_name,
              "explore education statistics"
            )
          ),
          ". The statistical release provides additional ",
          dfeshiny::external_link(
            href = paste0(
              "https://explore-education-statistics.service.gov.uk/find-statistics/", # nolint: [line_length_linter]
              publication_slug,
              "/data-guidance"
            ),
            link_text = "data guidance"
          ),
          " and ",
          dfeshiny::external_link(
            href = paste0(
              "https://explore-education-statistics.service.gov.uk/find-statistics/", # nolint: [line_length_linter]
              publication_slug,
              "#explore-data-and-files"
            ),
            link_text = "tools to access and interrogate the underlying data"
          ),
          " contained in this dashboard."
        )
      } else {
        shiny::tags$p(
          "The parent statistical release of this dashboard, along with
              methodological information,
              is available at ",
          dfeshiny::external_link(
            href = alt_href,
            link_text = publication_name
          ),
          "."
        )
      }
    },
    # to add extra sections before the contact us section
    extra_text,
    shiny::tags$h2("Contact us"),
    shiny::tags$p(
      "If you have questions about the dashboard or data within it,
            please contact us at ",
      dfeshiny::external_link(
        href = paste0("mailto:", team_email),
        link_text = team_email,
        add_warning = FALSE
      ),
      "."
    ),
    shiny::tags$h2("See the source code"),
    shiny::tags$p(
      "The source code for this dashboard is available in our ",
      dfeshiny::external_link(
        href = paste0(
          repo_name
        ),
        link_text = "GitHub repository"
      ),
      "."
    )
  )
}
