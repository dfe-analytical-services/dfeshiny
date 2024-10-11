#' Support panel
#'
#' @description
#' Create the standard DfE R-Shiny support and feedback dashboard panel.
#'
#' @param team_email Your team e-mail address, must be a education.gov.uk email
#' @param repo_name The repository URL, must be a valid URL for the
#' dfe-analytical-services GitHub area
#' @param ees_publication Whether the parent publication is hosted on Explore
#' Education Statistics
#' @param publication_name The parent publication name
#' @param publication_slug The parent publication slug on Explore Education
#' Statistics
#' @param alt_href Alternative link to the parent publication (if not hosted on
#' Explore Education Statistics)
#' @param form_url URL for a feedback form for the dashboard
#' @param feedback_extra_txt Optional extra text to go under the "Give us feedback" heading.
#' It will be a separate paragraph beneath the existing text template.
#' @param info_extra_txt Optional extra text to go under the
#' "Find out more information on the data" heading.
#' It will be a separate paragraph beneath the existing text template.
#' @param contact_extra_txt Optional extra text to go under the "Contact us" heading.
#' It will be a separate paragraph beneath the existing text template.
#'
#' @return a HTML div, containing standard support content for a public R Shiny
#' dashboard in DfE
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
#' # Example for adding extra text
#' extra_text <- "This is a sentence to test the ability to add extra text in the tab"
#'
#' # Adding extra text to the feedback section only
#'
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com",
#'   feedback_extra_txt = extra_text,
#' )
#'
#' # Adding extra text to all the sections
#'
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com",
#'   feedback_extra_txt = extra_text,
#'   info_extra_txt = extra_text,
#'   contact_extra_txt = extra_text
#' )
support_panel <- function(
    team_email = "",
    repo_name = "",
    ees_publication = TRUE,
    publication_name = NULL,
    publication_slug = "",
    alt_href = NULL,
    form_url = NULL,
    feedback_extra_txt = NULL,
    info_extra_txt = NULL,
    contact_extra_txt = NULL) {
  # Check that the team_email is a valid dfe email ----------------------------
  is_valid_dfe_email <- function(email) {
    grepl(
      "\\<[A-Z0-9._%+-]+@education.gov.uk\\>",
      as.character(email),
      ignore.case = TRUE
    )
  }

  if (is_valid_dfe_email(team_email) == FALSE) {
    stop(
      "You have entered an invalid email in the team_email argument.
      Please enter an @education.gov.uk email."
    )
  }

  # Check that the repo_name is a valid dfe repo ------------------------------
  # TODO: Use RCurl to check another step further, if the URL is valid
  is_valid_repo_name <- function(url) {
    grepl(
      "\\https://github.com/dfe-analytical-services/+.",
      as.character(url),
      ignore.case = TRUE
    )
  }

  if (repo_name == "") {
    stop(
      "The repo_name argument is empty, please specify a value for repo_name"
    )
  }

  if (is_valid_repo_name(repo_name) == FALSE) {
    stop(
      "Please ensure the repo_name argument is a valid URL for a repository on
      the dfe-analytical-services GitHub area. For example:
      repo_name = 'https://github.com/dfe-analytical-services/dfeR'.
      "
    )
  }


  # check for extra text ----------------------------------------------------

  # check for extra feedback text - if not specified, keep string empty
  if (is.null(feedback_extra_txt)) {
    feedback_extra_txt <- ""
    # if specified, use the given string
  } else {
    feedback_extra_txt <- feedback_extra_txt
  }

  # check for extra find out more info text  - if not specified, keep string empty
  if (is.null(info_extra_txt)) {
    info_extra_txt <- ""
    # if specified, use the given string
  } else {
    info_extra_txt <- info_extra_txt
  }

  # check for extra contact us text  - if not specified, keep string empty
  if (is.null(contact_extra_txt)) {
    contact_extra_txt <- ""
    # if specified, use the given string
  } else {
    contact_extra_txt <- contact_extra_txt
  }


  # Build the support page ----------------------------------------------------
  shiny::tags$div(
    shiny::tags$h1("Support and feedback"),
    shiny::tags$h2("Give us feedback"),
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
      ), "."
    ),
    shiny::tags$p(feedback_extra_txt),
    shiny::tags$h2("Find more information on the data"),
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
            publication_slug, "/data-guidance"
          ),
          link_text = "data guidance"
        ),
        " and ",
        dfeshiny::external_link(
          href = paste0(
            "https://explore-education-statistics.service.gov.uk/find-statistics/", # nolint: [line_length_linter]
            publication_slug, "#explore-data-and-files"
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
    },
    shiny::tags$p(info_extra_txt),
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
    shiny::tags$p(contact_extra_txt),
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
