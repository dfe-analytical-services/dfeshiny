#' Accessibility panel
#'
#' @description
#' Create an accessibility statement for a dashboard. This should always be completed
#'   - for all live public dashboards
#'   - by or in conjunction with the Explore education statistics and platforms team
#'
#' Note that this model statement has been created based on the
#' [GDS model accessibility statement](https://www.gov.uk/guidance/model-accessibility-statement)
#'
#' @param dashboard_title Title of the host dashboard
#' @param dashboard_url URL for the host dashboard
#' @param issues_contact URL for the GitHub Issues log or contact e-mail address
#' for users to flag accessibility issues
#' @param publication_name The parent publication name (optional)
#' @param publication_slug The parent publication slug on Explore Education
#' Statistics (optional)
#' @param non_accessible_components String vector containing a list of non accessible components
#' @param specific_issues String vector containing descriptions of specific accessibility issues
#' that have been identified as part of testing
#' @param date_tested Date the application was last tested
#' @param date_prepared Date the statement was prepared in it's current form
#' @param date_reviewed Date the statement was last reviewed
#' @param date_template_reviewed Date the underlying template was reviewed
#' (default: 12th March 2024)
#'
#' @return shiny$tags$div element containing the HTML tags and content for the standard
#' accessibility statement
#' @export
#'
#' @examples
#' a11y_panel(
#'   "DfE Shiny template",
#'   "https://department-for-education.shinyapps.io/dfe-shiny-template",
#'   "25th April 2024",
#'   "26th April 2024",
#'   "2nd November 2024",
#'   issues_contact = "https://github.com/dfe-analytical-services/shiny-template",
#'   publication_slug = "la-and-school-expenditure",
#'   publication_name = "LA and school expenditure"
#' )
a11y_panel <- function(
    dashboard_title,
    dashboard_url,
    date_tested,
    date_prepared,
    date_reviewed,
    date_template_reviewed = "12 March 2024",
    issues_contact = NULL,
    publication_name = NULL,
    publication_slug = NULL,
    non_accessible_components = c(
      "Keyboard navigation through the interactive charts is currently limited",
      "Alternative text in interactive charts is limited to titles"
    ),
    specific_issues = c(
      "Charts have non-accessible components that are inaccessible for keyboard users.",
      "Chart tooltips are not compatible with screen reader use.",
      "Some decorative images are not labelled appropriately as yet.",
      "Some links are not appropriately labelled."
    )) {
  # Validate inputs
  date_tested <- validate_date(date_tested)
  date_prepared <- validate_date(date_prepared)
  date_reviewed <- validate_date(date_reviewed)
  date_template_reviewed <- validate_date(date_template_reviewed)
  validate_dashboard_url(dashboard_url)
  if (
    lubridate::interval(
      lubridate::dmy(date_prepared), lubridate::dmy(date_reviewed)
    ) / lubridate::days(1) < 0
  ) {
    stop("date_reviewed should be later than date_prepared")
  }
  if (
    lubridate::interval(
      lubridate::dmy(date_tested), lubridate::dmy(date_reviewed)
    ) / lubridate::days(1) < 0
  ) {
    stop("date_reviewed should be later than date_tested")
  }
  if (
    lubridate::interval(
      lubridate::dmy(date_template_reviewed), lubridate::dmy(date_reviewed)
    ) / lubridate::days(1) < 0
  ) {
    warning(
      "The template has been through a review more recently than your dashboard, please get in ",
      "touch with the explore education statistics platforms team to request a re-review."
    )
  }
  if (!is_valid_repo_url(issues_contact)) {
    if (!is_valid_dfe_email(issues_contact)) {
      stop(
        paste0(
          "\"",
          issues_contact,
          "\" should either be a valid repository URL or a valid DfE e-mail address"
        )
      )
    }
  }
  if (is.null(publication_name) && !is.null(publication_slug)) {
    stop("Error: If publication_name is provided, then so should publication_slug.")
  }
  if (!is.null(publication_name) && is.null(publication_slug)) {
    stop("Error: If publication_slug is provided, then so should publication_name.")
  }
  shiny::tags$div(
    style = "margin-top: 50px; margin-bottom: 50px",
    shiny::tags$h1(paste0("Accessibility statement for ", dashboard_title)),
    shiny::tags$p(
      "This accessibility statement applies to the",
      dashboard_url,
      "website. This website is run by the ",
      external_link(
        href = "https://www.gov.uk/government/organisations/department-for-education",
        "Department for Education (DfE)"
      ),
      ".",
      "This statement does not cover any other services run by the Department for Education ",
      "(DfE) or GOV.UK."
    ),
    shiny::tags$h2("How you should be able to use this website"),
    shiny::tags$p(
      "We want as many people as possible to be able to use this website. You should be able to:"
    ),
    shiny::tags$div(tags$ul(
      shiny::tags$li(
        "change colours, contrast levels and fonts using browser or device settings"
      ),
      shiny::tags$li(
        "zoom in up to 400% without the text spilling off the screen"
      ),
      shiny::tags$li(
        "navigate most of the website using a keyboard or speech recognition software"
      ),
      shiny::tags$li(
        "listen to most of the website using a screen reader
                    (including the most recent versions of JAWS, NVDA and VoiceOver)"
      )
    )),
    shiny::tags$p("We've also made the website text as simple as possible to understand."),
    shiny::tags$p(
      external_link(href = "https://mcmw.abilitynet.org.uk/", "AbilityNet"),
      " has advice on making your device easier to use if you have a disability."
    ),
    shiny::tags$h2("How accessible this website is"),
    if (all(is.null(non_accessible_components))) {
      shiny::tags$p("This website is fully compliant with accessibility standards.")
    } else {
      shiny::tagList(
        shiny::tags$p("We know some parts of this website are not fully accessible:"),
        shiny::tags$div(tags$ol(
          tagList(lapply(non_accessible_components, shiny::tags$li))
        ))
      )
    },
    shiny::tags$h2("Feedback and contact information"),
    if (!is.null(publication_slug)) {
      shiny::tagList(
        shiny::tags$p(
          "If you need information on this website in a different format please see the",
          " parent publication, ",
          external_link(
            href = paste0(
              "https://explore-education-statistics.service.gov.uk/find-statistics/",
              publication_slug
            ),
            link_text = publication_name
          ),
          "."
        ),
        shiny::tags$p(
          "More details are available on that service for alternative formats of this ",
          "data."
        )
      )
    },
    shiny::tags$p("We're always looking to improve the accessibility of this website.
             If you find any problems not listed on this page or think we're not meeting
             accessibility requirements, contact us:"),
    shiny::tags$ul(tags$li(
      shiny::tags$a(
        href = "mailto:explore.statistics@education.gov.uk",
        "explore.statistics@education.gov.uk"
      )
    )),
    shiny::tags$h2("Enforcement procedure"),
    shiny::tags$p(
      "The Equality and Human Rights Commission (EHRC) is responsible for enforcing the Public ",
      "Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018",
      "(the \"accessibility regulations\")."
    ),
    shiny::tags$p(
      "If you are not happy with how we respond to your complaint, contact the ",
      external_link(
        href = "https://www.equalityadvisoryservice.com/",
        "Equality Advisory and Support Service (EASS)"
      ),
      "."
    ),
    shiny::tags$h2("Technical information about this website's accessibility"),
    shiny::tags$p(
      "The Department for Education (DfE) is committed to making its website accessible, in ",
      "accordance with the Public Sector Bodies (Websites and Mobile Applications) (No. 2) ",
      "Accessibility Regulations 2018."
    ),
    shiny::tags$h3("Compliance status"),
    if (all(is.null(specific_issues))) {
      shiny::tags$p(
        "This website is fully compliant with the ",
        external_link(
          href = "https://www.w3.org/TR/WCAG22/",
          "Web Content Accessibility Guidelines version 2.2 AA standard"
        ),
        "."
      )
    } else {
      shiny::tagList(
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
        shiny::tags$div(tags$ol(
          tagList(lapply(specific_issues, shiny::tags$li))
        ))
      )
    },
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
    shiny::tags$p(
      "DAC tested a sample of pages to cover the core functionality of the service including:"
    ),
    shiny::tags$div(tags$ul(
      shiny::tags$li("navigation"),
      shiny::tags$li("interactive dropdown selections"),
      shiny::tags$li("charts, maps, and tables")
    )),
    shiny::tags$p(
      "This specific website was was last tested on ", date_tested, " against ",
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
    shiny::tags$p(
      "We plan to continually test the service for accessibility issues, and are working ",
      "through a prioritised list of issues to resolve."
    ),
    shiny::tags$p(
      if (!is.null(issues_contact)) {
        if (is_valid_repo_url(issues_contact)) {
          shiny::tagList(
            "Our current list of issues to be resolved is available on our ",
            external_link(
              href = paste0(issues_contact, "/issues"),
              "GitHub issues page"
            ),
            "."
          )
        } else {
          shiny::tagList(
            "To discuss our current list of issues to be resolved contact us at",
            shiny::tags$a(
              href = paste0("mailto:", issues_contact),
              issues_contact
            ),
            "."
          )
        }
      } else {
        " "
      },
    ),
    shiny::tags$h2("Preparation of this accessibility statement"),
    shiny::tags$p(
      paste0(
        "This statement was prepared on ",
        date_prepared,
        " and last reviewed on ",
        date_reviewed,
        "."
      ),
      "The statement was produced based on a combination of testing carried out by the ",
      external_link(
        href = "https://digitalaccessibilitycentre.org/",
        "Digital accessibility centre (DAC)"
      ),
      " and our own testing."
    )
  )
}
