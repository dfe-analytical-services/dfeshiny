% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cookies.R
\name{init_cookies}
\alias{init_cookies}
\title{init_cookies}
\usage{
init_cookies(create_file = TRUE)
}
\arguments{
\item{create_file}{Boolean, TRUE by default, if FALSE then will print to
the console rather than create a new file}
}
\description{
init_cookies() creates a local copy of the JavaScript file required for
cookies to work. It checks whether there is already a www/ folder and if
not, it creates one. It then checks whether the cookie-consent.js file
exists in the www/ folder. If the file exists, it will print a message in
the console to let you know it has overwritten it. If the file doesn't
exist, it will make one and confirm it has done so.

No input parameters are required, run \code{init_cookies()} in the console to run
the function
}
\examples{
if (interactive()) {
  init_cookies()
}
}
