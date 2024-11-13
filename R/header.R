#' DfE header banner
#'
#' @description
#' This function uses `shinyGovstyle::header()` to create a header banner
#' using the DfE logo.
#'
#' @param secondary_text Secondary header to supplement the main text
#' @param secondary_link Add a link for clicking on secondary header
#' @return a header html shiny object
#'
#' @seealso [shinyGovstyle::header()]
#' @export
#' @examples
#'
#' if (interactive()) {
#'   ui <- fluidPage(
#'     dfeshiny::header(
#'       secondary_text = "User Examples"
#'     )
#'   )
#'
#'   server <- function(input, output, session) {}
#'
#'   shinyApp(ui = ui, server = server)
#' }
header <- function(secondary_text,
                   secondary_link = "#") {
  shinyGovstyle::header(
    logo = "/dfeshiny/DfE_logo_landscape.png",
    main_text = "",
    secondary_text = secondary_text,
    main_link = "https://www.gov.uk/government/organisations/department-for-education",
    logo_width = 132.98,
    logo_height = 32
  )
}
