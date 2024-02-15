library(shiny)
library(shinyGovstyle)

#' Support panel
#'
#' @description
#' Create the standard DfE R-Shiny support and feedback dashboard panel.
#'
#' @param team_email Your team e-mail address as a string, this must be a education.gov.uk email
#' @param repo_name The repository name as listed on GitHub
#' @param ees_publication Whether the parent publication is hosted on Explore Education Statistics
#' @param publication_name The parent publication name
#' @param publication_stub The parent publication stub on Explore Education Statistics
#' @param alt_href Alternative link to the parent publication (if not hosted on Explore Education Statistics)
#' @param form_url URL to a feedback form for the dashboard
#'
#' @return
#' @export
#'
#' @examples
support_panel <- function(
    team_email = "",
    repo_name = "",
    ees_publication = TRUE,
    publication_name = NULL,
    publication_stub = "",
    alt_href = NULL,
    form_url = NULL) {

  # Check that the team_email is a valid email
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
      Please enter a @education.gov.uk email.")
  }


  shiny::tabPanel(
    "Support and feedback",
    shinyGovstyle::gov_main_layout(
      shinyGovstyle::gov_row(
        shiny::column(
          width = 12,
          shiny::tags$h1("Support and feedback"),
          shiny::tags$h2("Give us feedback"),
          if (!is.null(form_url)) {
            shiny::tags$p(
              "This dashboard is a new service that we are developing.
              If you have any feedback or suggestions for improvements,
              please submit them using our ",
              shiny::tags$a(href = form_url, "feedback form", .noWS = c("after"))
            )
          } else {
            shiny::tags$p("This dashboard is a new service that we are developing.")
          },
          shiny::tags$p(
            paste0(
              ifelse(
                !is.null(form_url),
                "Alternatively, i",
                "I"
              ),
              "f you spot any errors or bugs while using this dashboard,
              please screenshot and email them to "
            ),
            shiny::tags$a(
              href = paste0("mailto:", team_email),
              team_email,
              .noWS = c("after")),
            "."
          ),
          shiny::tags$h2("Find more information on the data"),
          if (ees_publication) {
            shiny::tags$p(
              "The parent statistical release of this dashboard,
              along with methodological information, is available at the following link: ",
              shiny::tags$a(
                href = paste0("https://explore-education-statistics.service.gov.uk/find-statistics/", publication_stub),
                ifelse(!is.null(publication_name), publication_name, "Explore Education Statistics"),
                .noWS = c("after")
              ),
              ". The statistical release provides additional ",
              shiny::tags$a(
                href = paste0("https://explore-education-statistics.service.gov.uk/find-statistics/", publication_stub, "/data guidance"),
                "data guidance",
                .noWS = c("after")
              ),
              " and ",
              shiny::tags$a(
                href = paste0("https://explore-education-statistics.service.gov.uk/find-statistics/", publication_stub, "#explore-data-and-files"),
                "tools to access and interogate the underling data",
                .noWS = c("after")
              ),
              " contained in this dashboard."
            )
          } else {
            shiny::tags$p(
              "The parent statistical release of this dashboard, along with methodological information, is available at the following link: ",
              shiny::tags$a(
                href = alt_href,
                publication_name,
                .noWS = c("after")
              )
            )
          },
          shiny::tags$h2("Contact us"),
          shiny::tags$p(
            "If you have questions about the dashboard or data within it, please contact us at ",
            shiny::tags$a(href = paste0("mailto:", team_email), team_email, .noWS = c("after"))
          ),
          shiny::tags$h2("See the source code"),
          shiny::tags$p(
            "The source code for this dashboard is available in our ",
            shiny::tags$a(href = paste0("https://github.com/dfe-analytical-services/", repo_name), "GitHub repository", .noWS = c("after")),
            "."
          ),
          shiny::tags$h2("Use of cookies"),
          shiny::textOutput("cookie_status"),
          shiny::actionButton("remove", "Reset cookie consent"),
        )
      )
    )
  )
}
