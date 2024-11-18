#' DfE header banner
#'
#' @description
#' This function uses `shinyGovstyle::header()` to create a header banner
#' using the DfE logo.
#'
#' @param header Text to use for the header of the dashboard
#' @return a header html shiny object
#'
#' @seealso [shinyGovstyle::header()]
#' @export
#' @examples
#'
#' if (interactive()) {
#'   ui <- fluidPage(
#'     dfeshiny::header(
#'       header = "User Examples"
#'     )
#'   )
#'
#'   server <- function(input, output, session) {}
#'
#'   shinyApp(ui = ui, server = server)
#' }
header <- function(header) {
  shinyGovstyle::header(
    logo = "/dfeshiny/DfE_logo_landscape.png",
    main_text = "",
    secondary_text = header,
    main_link = "https://www.gov.uk/government/organisations/department-for-education",
    logo_width = 132.98,
    logo_height = 32
  )
}
