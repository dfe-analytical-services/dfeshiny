% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/a11y_panel.R
\name{a11y_panel}
\alias{a11y_panel}
\title{Accessibility panel}
\usage{
a11y_panel(
  dashboard_title,
  dashboard_url,
  date_tested,
  date_prepared,
  date_reviewed,
  date_template_reviewed = "12 March 2024",
  issues_contact = NULL,
  publication_name = NULL,
  publication_slug = NULL,
  non_accessible_components =
    c("Keyboard navigation through the interactive charts is currently limited",
    "Alternative text in interactive charts is limited to titles"),
  specific_issues =
    c("Charts have non-accessible components that are inaccessible for keyboard users.",
    "Chart tooltips are not compatible with screen reader use.",
    "Some decorative images are not labelled appropriately as yet.",
    "Some links are not appropriately labelled.")
)
}
\arguments{
\item{dashboard_title}{Title of the host dashboard}

\item{dashboard_url}{URL for the host dashboard}

\item{date_tested}{Date the application was last tested}

\item{date_prepared}{Date the statement was prepared in it's current form}

\item{date_reviewed}{Date the statement was last reviewed}

\item{date_template_reviewed}{Date the underlying template was reviewed
(default: 12th March 2024)}

\item{issues_contact}{URL for the GitHub Issues log or contact e-mail address
for users to flag accessibility issues}

\item{publication_name}{The parent publication name (optional)}

\item{publication_slug}{The parent publication slug on Explore Education
Statistics (optional)}

\item{non_accessible_components}{String vector containing a list of non accessible components}

\item{specific_issues}{String vector containing descriptions of specific accessibility issues
that have been identified as part of testing}
}
\value{
shiny$tags$div element containing the HTML tags and content for the standard
accessibility statement
}
\description{
Create an accessibility statement for a dashboard. This should always be completed
\itemize{
\item for all live public dashboards
\item by or in conjunction with the Explore education statistics and platforms team
}

Note that this model statement has been created based on the
\href{https://www.gov.uk/guidance/model-accessibility-statement}{GDS model accessibility statement}
}
\examples{
a11y_panel(
  "DfE Shiny template",
  "https://department-for-education.shinyapps.io/dfe-shiny-template",
  "25th April 2024",
  "26th April 2024",
  "2nd November 2024",
  issues_contact = "https://github.com/dfe-analytical-services/shiny-template",
  publication_slug = "la-and-school-expenditure",
  publication_name = "LA and school expenditure"
)
}
