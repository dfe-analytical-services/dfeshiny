support_links <- function(
    team_email = '',
    repo_name = '',
    publication_name = '',
    publication_stub = '',
    form_url = ''
    ) {
  tabPanel(
    "Support and feedback",
    gov_main_layout(
      gov_row(
        column(
          width = 12,
          h1("Support and feedback"),
          h2("Give us feedback"),
          p(
            "This dashboard is a new service that we are developing. If you have
            any feedback or suggestions for improvements, please submit them
            using our ",
            a(
              href = form_url,
              "feedback form", .noWS = c("after")
            ), "."
          ),
          p(
            "If you spot any errors or bugs while using this dashboard, please screenshot and email them to ",
            a(href = paste0("mailto:", team_email), team_email, .noWS = c("after")), "."
          ),
          h2("Find more information on the data"),
          p(
            "The data used to produce the dashboard, along with methodological information can be found on ",
            a(href = "https://explore-education-statistics.service.gov.uk/", "Explore Education Statistics", .noWS = c("after")),
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
          )
        ),
        column(
          12,
          h2("Use of cookies"),
          textOutput("cookie_status"),
          actionButton("remove", "Reset cookie consent"),
        )
      )
    )
  )
}
