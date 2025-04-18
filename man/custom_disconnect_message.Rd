% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/custom_disconnect_message.R
\name{custom_disconnect_message}
\alias{custom_disconnect_message}
\title{Custom disconnect message}
\usage{
custom_disconnect_message(
  refresh = "refresh page (attempting to keep your last known selections)",
  reset = "reset page (removing any previous selections)",
  dashboard_title = NULL,
  links = NULL,
  publication_name = NULL,
  publication_link = NULL,
  support_contact = "explore.statistics@education.gov.uk",
  custom_refresh = NULL,
  custom_reset = NULL
)
}
\arguments{
\item{refresh}{the text to appear that will refresh the page when clicked}

\item{reset}{the text to appear that will reset the page when clicked}

\item{dashboard_title}{Title of the dashboard}

\item{links}{A vector of possible URLs for the public site. Should mostly just be a single URL,
but can be two URLs if an overflow site has been set up}

\item{publication_name}{The parent publication name}

\item{publication_link}{The link to the publication on Explore Education
Statistics}

\item{support_contact}{Email address for support contact, defaults to
explore.statistics@education.gov.uk}

\item{custom_refresh}{Custom refresh link, defaults to refreshing the page, main value is if you
have bookmarking enabled and want the refresh to send to the initial view instead of reloading
any bookmarks}

\item{custom_reset}{Custom reset link, defaults to resetting the page}
}
\value{
A HTML overlay panel that appears when a user loses connection to a DfE R Shiny
dashboard.
}
\description{
Create the HTML overlay panel to appear when a user loses connection to a dashboard.
}
\examples{
custom_disconnect_message(
  dashboard_title = "DfE Shiny Template",
  refresh = "Refresh page",
  links = c(
    "https://department-for-education.shinyapps.io/dfe-shiny-template",
    "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/"
  ),
  publication_name = "Explore Education Statistics Publication",
  publication_link =
    "https://explore-education-statistics.service.gov.uk/find-statistics/apprenticeships"
)

custom_disconnect_message(
  dashboard_title = "DfE Shiny Template",
  refresh = "Refresh page",
  links = c(
    "https://department-for-education.shinyapps.io/dfe-shiny-template"
  )
)

custom_disconnect_message(
  support_contact = "my.team@education.gov.uk",
  custom_refresh = "https://department-for-education.shinyapps.io/my-dashboard"
)
}
