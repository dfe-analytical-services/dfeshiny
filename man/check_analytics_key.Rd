% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pre_commit.R
\name{check_analytics_key}
\alias{check_analytics_key}
\title{Check for and Replace Google Analytics Keys}
\usage{
check_analytics_key(ga_file = "google-analytics.html", ui_file = "ui.R")
}
\arguments{
\item{ga_file}{Path to the Google Analytics file.}

\item{ui_file}{Path to the UI script file.}
}
\value{
TRUE if no issues found, FALSE if replacements were made.
}
\description{
Reads \code{google-analytics.html} and \code{ui.R} to check for Google Analytics keys.
If found, replaces them with placeholder values and stages the files in git.
}
\keyword{internal}
