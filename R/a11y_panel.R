#' Accessibility panel
#'
#' @param dashboard_title Title of the host dashboard
#' @param dashboard_link URL for the host dashboard
#' @param public_repo_link URL for the dashboard repository
#' @param non_accessible_components String vector containing a list of non accessible components
#' @param specific_issues String vector containing descriptions of specific accessibility issues
#' that have been identified as part of testing
#' @param date_prepared Date the statement was prepared in it's current form
#' @param date_reviewed Date the statement was last reviewed
#'
#' @return shiny$tags$div element containing the html tags and content for the standard
#' accessibility statement
#' @export
#'
#' @examples
#' a11y_panel(
#' "DfE Shiny template",
#' "26th November 2024",
#' "26th November 2024",
#' "https://department-for-education.shinyapps.io/dfe-shiny-template",
#' public_repo_link = "https://github.com/dfe-analytical-services/shiny-template",
#' )
a11y_panel <- function(
    dashboard_title,
    dashboard_link,
    date_prepared,
    date_reviewed,
    date_template_reviewed = "12th March 2024",
    public_repo_link = NA,
    non_accessible_components = NA,
    specific_issues = NA) {
  shiny::tags$div(
    "Accessibility",
    shiny::tags$div(
      shiny::tags$h1(paste0("Accessibility statement for ", dashboard_title)),
      shiny::tags$p(
        "This accessibility statement applies to the",
        dashboard_link,
        "website. This website is run by the ",
        external_link(
          href = "https://www.gov.uk/government/organisations/department-for-education",
          "Department for Education (DfE)"
        ),
        ".",
        "This statement does not cover any other services run by the Department for Education (DfE) or GOV.UK."
      ),
      shiny::tags$h2("How you should be able to use this website"),
      shiny::tags$p("We want as many people as possible to be able to use this website. You should be able to:"),
      shiny::tags$div(tags$ul(
        shiny::tags$li("change colours, contrast levels and fonts using browser or device settings"),
        shiny::tags$li("zoom in up to 400% without the text spilling off the screen"),
        shiny::tags$li("navigate most of the website using a keyboard or speech recognition software"),
        shiny::tags$li("listen to most of the website using a screen reader
                    (including the most recent versions of JAWS, NVDA and VoiceOver)")
      )),
      shiny::tags$p("We’ve also made the website text as simple as possible to understand."),
      shiny::tags$p(
        external_link(href = "https://mcmw.abilitynet.org.uk/", "AbilityNet"),
        " has advice on making your device easier to use if you have a disability."
      ),
      shiny::tags$h2("How accessible this website is"),
      shiny::tags$p("We know some parts of this website are not fully accessible:"),
      shiny::tags$div(tags$ul(
        tagList(lapply(non_accessible_components, shiny::tags$li))
      )), # TODO
      shiny::tags$h2("Feedback and contact information"),
      shiny::tags$p(
        "If you need information on this website in a different format please see the parent",
        "publications",
        external_link(
          href = "https://explore-education-statistics.service.gov.uk/find-statistics",
          "on Explore education statistics"
        ),
        ", as detailed on the data sources page of this service.",
        ". More details are available on that service for alternative formats of this data.",
      ),
      shiny::tags$p("We’re always looking to improve the accessibility of this website.
             If you find any problems not listed on this page or think we’re not meeting
             accessibility requirements, contact us:"),
      shiny::tags$ul(tags$li(
        shiny::tags$a(
          href = "mailto:explore.statistics@education.gov.uk",
          "explore.statistics@education.gov.uk"
        )
      )),
      shiny::tags$h2("Enforcement procedure"),
      shiny::tags$p("The Equality and Human Rights Commission (EHRC) is responsible for enforcing the Public Sector Bodies
             (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018
             (the ‘accessibility regulations’)."),
      shiny::tags$p(
        "If you are not happy with how we respond to your complaint, ",
        external_link(
          href = "https://www.equalityadvisoryservice.com/",
          "contact the Equality Advisory and Support Service (EASS)"
        ),
        "."
      ),
      shiny::tags$h2("Technical information about this website's accessibility"),
      shiny::tags$p("The Department for Education (DfE) is committed to making its website accessible, in accordance with the
          Public Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018."),
      shiny::tags$h3("Compliance status"),
      shiny::tags$p(
        "This website is partially compliant with the ",
        external_link(
          href = "https://www.w3.org/TR/WCAG22/",
          "Web Content Accessibility Guidelines version 2.2 AA standard"
        ),
        " due to the non-compliances listed below."
      ),
      shiny::tags$h3("Non accessible content"),
      shiny::tags$p("The content listed below is non-accessible for the following reasons.
             We will address these issues to ensure our content is accessible."),
      shiny::tags$div(tags$ul(
        tagList(lapply(specific_issues, shiny::tags$li))
      )),
      shiny::tags$h3("Disproportionate burden"),
      shiny::tags$p("Not applicable."),
      shiny::tags$h2("How we tested this website"),
      shiny::tags$p(
        "The template used for this website was last tested on",
        date_template_reviewed,
        " against ",
        external_link(
          href = "https://www.w3.org/TR/WCAG22/",
          "Accessibility Guidelines WCAG2.2"
        ),
        ". The test was carried out by the ",
        external_link(
          href = "https://digitalaccessibilitycentre.org/",
          "Digital accessibility centre (DAC)"
        ),
        "."
      ),
      shiny::tags$p("DAC tested a sample of pages to cover the core functionality of the service including:"),
      shiny::tags$div(tags$ul(
        shiny::tags$li("navigation"),
        shiny::tags$li("interactive dropdown selections"),
        shiny::tags$li("charts, maps, and tables")
      )),
      shiny::tags$p(
        "This specific website was was last tested on 8th October 2024 against ",
        external_link(
          href = "https://www.w3.org/TR/WCAG22/",
          "Accessibility Guidelines WCAG2.2"
        ),
        ". The test was carried out by the ",
        external_link(
          href = "https://www.gov.uk/government/organisations/department-for-education",
          "Department for Education (DfE)"
        ),
        "."
      ),
      shiny::tags$h2("What we're doing to improve accessibility"),
      shiny::tags$p("We plan to continually test the service for accessibility issues, and are working through a prioritised
          list of issues to resolve."),
      shiny::tags$p(
        "Our current list of issues to be resolved is available on our ",
        external_link(
          href = paste0(public_repo_link, "/issues"),
          "GitHub issues page"
        ),
        "."
      ),
      shiny::tags$h2("Preparation of this accessibility statement"),
      shiny::tags$p("This statement was prepared on 1st July 2024. It was last reviewed on 8th October 2024."),
      shiny::tags$p(
        "The template used for this website was last tested in March 2024 against the WCAG 2.2 AA standard.
          This test of a representative sample of pages was carried out by the ",
        external_link(
          href = "https://digitalaccessibilitycentre.org/",
          "Digital accessibility centre (DAC)"
        ),
        "."
      ),
      shiny::tags$p("We also used findings from our own testing when preparing this accessibility statement.")
    )
  )
}
