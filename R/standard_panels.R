library(shiny)
library(shinyGovstyle)

#' Support panel
#'
#' @description
#' Create the standard DfE R-Shiny support and feedback dashboard panel.
#'
#' @param team_email Your team e-mail address as a string
#' @param repo_name The repository name as listed on GitHub
#' @param ees_publication Whether the parent publication is hosted on Explore
#' Education Statistics
#' @param publication_name The parent publication name
#' @param publication_stub The parent publication stub on Explore Education
#' Statistics
#' @param alt_href Alternative link to the parent publication (if not hosted on
#' Explore Education Statistics)
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
  tabPanel(
    value = "support_panel",
    "Support and feedback",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h1("Support and feedback"),
          h2("Give us feedback"),
          if (!is.null(form_url)) {
            p(
              "This dashboard is a new service that we are developing. If you
              have any feedback or suggestions for improvements, please submit
              them using our ",
              a(href = form_url, "feedback form", .noWS = c("after"))
            )
          } else {
            p("This dashboard is a new service that we are developing.")
          },
          p(
            paste0(
              ifelse(
                !is.null(form_url),
                "Alternatively, i",
                "I"
              ),
              "f you spot any errors or bugs while using this dashboard, please
              screenshot and email them to "
            ),
            tags$a(
              href = paste0("mailto:", team_email),
              team_email,
              .noWS = c("after")
            ), "."
          ),
          h2("Find more information on the data"),
          if (ees_publication) {
            p(
              "The parent statistical release of this dashboard, along with
              methodological information, is available at the following link: ",
              tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_stub
                ),
                ifelse(
                  !is.null(publication_name),
                  publication_name,
                  "Explore Education Statistics"
                ),
                .noWS = c("after")
              ),
              ". The statistical release provides additional ",
              tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_stub, "/data guidance"
                ),
                "data guidance",
                .noWS = c("after")
              ),
              " and ",
              tags$a(
                href = paste0(
                  "https://explore-education-statistics.service.gov.uk/find-statistics/",
                  publication_stub, "#explore-data-and-files"
                ),
                "tools to access and interogate the underling data",
                .noWS = c("after")
              ),
              " contained in this dashboard."
            )
          } else {
            p(
              "The parent statistical release of this dashboard, along with
              methodological information, is available at the following link: ",
              a(
                href = alt_href,
                publication_name,
                .noWS = c("after")
              )
            )
          },
          h2("Contact us"),
          p(
            "If you have questions about the dashboard or data within it, please
            contact us at ",
            a(
              href = paste0("mailto:", team_email),
              team_email, .noWS = c("after")
            )
          ),
          h2("See the source code"),
          p(
            "The source code for this dashboard is available in our ",
            a(
              href = paste0(
                "https://github.com/dfe-analytical-services/", repo_name
              ),
              "GitHub repository", .noWS = c("after")
            ),
            "."
          ),
          h2("Use of cookies"),
          p("To better understand the reach of our dashboard tools, this site
            uses cookies to identify numbers of unique users as part of Google
            Analytics."),
          textOutput("cookie_status"),
          actionButton("cookie_consent_clear", "Reset cookie consent"),
        )
      )
    )
  )
}
