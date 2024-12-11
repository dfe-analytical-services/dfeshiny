# Some standard checks on something that's expected to be a date:
#   - Can lubridate parse it as a date?
#   - Does it occur in the past / today?
# Where it's valid, the function will return it in a format of dd month yyyy
validate_date <- function(date) {
  date_ld <- lubridate::dmy(date, quiet = TRUE)
  date_template <- lubridate::stamp("1 January 2020", orders = "dmy", quiet = TRUE)
  if (is.na(date_ld)) {
    valid <- FALSE
    validation_message <- "not in a valid date format."
  } else if (date_ld > Sys.time()) {
    valid <- FALSE
    validation_message <- "is in the future."
  } else {
    valid <- TRUE
    validation_message <- "is a valid date."
  }
  if (!valid) {
    stop(paste(date, validation_message))
  }
  return(date_template(date_ld))
}

# Some of the standard panels have text referring back to the dashboard repo, so
# this function checks for strings being passed to those variables being a link
# to one of our DevOps areas, i.e. DfE Analytical Services on GitHub or our Azure
# platform. I've included both as some teams are starting to use dfeshiny for
# internal dasboards as well.
is_valid_repo_url <- function(url) {
  # Check that the repo_name is a valid dfe repo ------------------------------
  # TODO: Use RCurl to check another step further, if the URL is valid
  grepl(
    "\\https://github.com/dfe-analytical-services/+.|dfe-gov-uk",
    as.character(url),
    ignore.case = TRUE
  )
}

# Some of the standard panels have links to the dashboard they're embedded in. This
# validation checks that those links are correctly set to one of our domains.
validate_dashboard_url <- function(url) {
  valid_deploys <- c(
    "^https://department-for-education.shinyapps.io/",
    "^https://rsconnect/rsc/"
  )
  valid <- grepl(
    paste(valid_deploys, collapse = "|"),
    as.character(url),
    ignore.case = TRUE
  )
  if (!valid) {
    stop(paste(url, "is not a valid DfE dashboard deployment URL"))
  }
}
