#' use_yml_deploy
#'
#' @param app_name Name of the app to use as the url slug
#' @param mirror If TRUE, create a mirror site
#' @param dev If TRUE, create a development site from the development branch
#'
#' @return
#' @export
#'
#' @examples
use_yml_deploy <- function(app_name = NULL, mirror = FALSE, dev = FALSE){
  disallowed_strings <- c("shinyapps", "http")
  if(
    is.null(app_name) ||
    is.na(app_name) ||
    grepl(paste(disallowed_strings, collapse="|"),tolower(app_name))
    ){
    stop(paste("Invalid app_name provided:",app_name))
  }
  app_name_cleaned <- gsub(
    " ","-",
    tolower(
      stringr::str_trim(app_name)
      )
    )
  if(app_name_cleaned != app_name){
    warning(paste("The provided app name has been cleaned for use as the URL slug:", app_name_cleaned))
  }
  deploy_file <- file(".github/workflows/deploy-shiny.yml")

}
