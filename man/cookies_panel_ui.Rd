% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cookies.R
\name{cookies_panel_ui}
\alias{cookies_panel_ui}
\title{cookies_panel_ui}
\usage{
cookies_panel_ui(id, google_analytics_key = NULL)
}
\arguments{
\item{id}{ID shared with cookies_panel_server()}

\item{google_analytics_key}{Provide the GA 10 digit key of the form
"ABCDE12345"}
}
\value{
a standardised panel for a public R Shiny dashboard in DfE
}
\description{
Create the standard DfE R-Shiny cookies dashboard panel in the ui. The server
side functionality is provided by cookies_panel_server()
}
\examples{
\dontrun{
cookies_panel_ui(
  id = "cookies_panel",
  google_analytics_key = "ABCDE12345"
)
}
}