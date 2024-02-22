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
#' @param cookie_status_output Name of cookie status output object, often
#' "cookie_status"
#'
#' @return a standardised panel for a public R Shiny dashboard in DfE
#' @export
#'
#' @examples
#' support_panel(
#'   team_email = "my.team@@education.gov.uk",
#'   repo_name = "https://github.com/dfe-analytical-services/my-repo",
#'   publication_name = "My publication title",
#'   publication_slug = "my-publication-title",
#'   form_url = "www.myform.com",
#'   cookie_status_output = "cookie_status"
#' )
support_panel <- function(
    team_email = "",
    repo_name = "",
    ees_publication = TRUE,
    publication_name = NULL,
    publication_slug = "",
    alt_href = NULL,
    form_url = NULL,
    cookie_status_output = "cookie_status") {
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

  # Build the support page ----------------------------------------------------
  shiny::tabPanel(
    value = "support_panel",
    "Support and feedback",
    shinyGovstyle::gov_main_layout(
      shinyGovstyle::gov_row(
        shiny::column(
          width = 12,
          shiny::tags$h1("Support and feedback"),
          shiny::tags$h2("Give us feedback"),
          if (!is.null(form_url)) {
            shiny::tags$p(
              "This dashboard is a new service that we are developing. If you
              have any feedback or suggestions for improvements, please submit
              them using our ",
              shiny::tags$a(
                href = form_url,
                "feedback form",
                .noWS = c("after")
              )
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
            shiny::tags$a(
              href = paste0("mailto:", team_email),
              team_email,
              .noWS = c("after")
            ), "."
          ),
          shiny::tags$h2("Find more information on the data"),
          if (ees_publication) {
            shiny::tags$p(
              "The parent statistical release of this dashboard, along with
              methodological information,
              is available at the following link: ",
              shiny::tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_slug
                ),
                ifelse(
                  !is.null(publication_name),
                  publication_name,
                  "Explore Education Statistics"
                ),
                .noWS = c("after")
              ),
              ". The statistical release provides additional ",
              shiny::tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_slug, "/data-guidance"
                ),
                "data guidance",
                .noWS = c("after")
              ),
              " and ",
              shiny::tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_slug, "#explore-data-and-files"
                ),
                "tools to access and interogate the underling data",
                .noWS = c("after")
              ),
              " contained in this dashboard."
            )
          } else {
            shiny::tags$p(
              "The parent statistical release of this dashboard, along with
              methodological information,
              is available at the following link: ",
              shiny::tags$a(
                href = alt_href,
                publication_name,
                .noWS = c("after")
              )
            )
          },
          shiny::tags$h2("Contact us"),
          shiny::tags$p(
            "If you have questions about the dashboard or data within it,
            please contact us at ",
            shiny::tags$a(
              href = paste0("mailto:", team_email),
              team_email, .noWS = c("after")
            )
          ),
          shiny::tags$h2("See the source code"),
          shiny::tags$p(
            "The source code for this dashboard is available in our ",
            shiny::tags$a(
              href = paste0(
                repo_name
              ),
              "GitHub repository", .noWS = c("after")
            ),
            "."
          ),
          shiny::tags$h2("Use of cookies"),
          shiny::tags$p("To better understand the reach of our dashboard tools,
            this site uses cookies to identify numbers of unique users
            as part of Google Analytics."),
          shiny::textOutput(cookie_status_output),
          shiny::actionButton("cookie_consent_clear", "Reset cookie consent"),
        )
      )
    )
  )
}
