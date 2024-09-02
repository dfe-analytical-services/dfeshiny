#' download_button
#'
#' @param outputId The output ID
#' @param label Display label for the button
#' @param class Any additional CSS class
#' @param icon Icon to be displayed
#'
#' @return a html download link presented as a GDS button
#' @export
#'
#' @examples
download_button <- function(outputId,
                           label="Download",
                           class=NULL,
                           type = "default",
                           icon = shiny::icon("download")) {

  class_input <- "govuk-button"
  if (type == "secondary")
    class_input <- "govuk-button govuk-button--secondary"

  gov_download <- tags$a(id=outputId,
         class = paste0(class_input, " action-button"),
         class=class,
         href='',
         target='_blank',
         download=NA,
         "aria-disabled"="true",
         tabindex="-1",
         icon,
         label)

  htmltools::attachDependencies(
    gov_download,
    htmltools::htmlDependency(
      name = "stylecss", version = version,
      src = c(href="shinyGovstyle/css"),
      stylesheet = "govuk-frontend-norem.css"
      ),
    append=TRUE)

}
