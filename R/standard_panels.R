library(shiny)
library(shinyGovstyle)

#' Support panel
#'
#' @description
#' Create the standard DfE R-Shiny support and feedback dashboard panel.
#'
#' @param team_email Your team e-mail address as a string
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
  tabPanel(
    "Support and feedback",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h1("Support and feedback"),
          h2("Give us feedback"),
          if (!is.null(form_url)) {
            p(
              "This dashboard is a new service that we are developing. If you have any feedback or suggestions for improvements, please submit them using our ",
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
              "f you spot any errors or bugs while using this dashboard, please screenshot and email them to "
            ),
            a(href = paste0("mailto:", team_email), team_email, .noWS = c("after")), "."
          ),
          h2("Find more information on the data"),
          p(
            "The data used to produce the dashboard, along with methodological information can be found in ",
            if (ees_publication) {
              a(
                href = paste0("https://explore-education-statistics.service.gov.uk/", publication_stub),
                ifelse(!is.null(publication_name), publication_name, "Explore Education Statistics"),
                .noWS = c("after")
              )
            } else {
              a(
                href = alt_href,
                publication_name,
                .noWS = c("after")
              )
            },
            "."
          ),
          h2("Contact us"),
          p(
            "If you have questions about the dashboard or data within it, please contact us at ",
            a(href = paste0("mailto:", team_email), team_email, .noWS = c("after"))
          ),
          h2("See the source code"),
          p(
            "The source code for this dashboard is available in our ",
            a(href = paste0("https://github.com/dfe-analytical-services/", repo_name), "GitHub repository", .noWS = c("after")),
            "."
          ),
          h2("Use of cookies"),
          textOutput("cookie_status"),
          actionButton("remove", "Reset cookie consent"),
        )
      )
    )
  )
}
