# Accessibility panel

Create an accessibility statement for a dashboard. This should always be
completed

- for all live public dashboards

- by or in conjunction with the Explore education statistics and
  platforms team

Note that this model statement has been created based on the [GDS model
accessibility
statement](https://www.gov.uk/guidance/model-accessibility-statement)

## Usage

``` r
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
```

## Arguments

- dashboard_title:

  Title of the host dashboard

- dashboard_url:

  URL for the host dashboard

- date_tested:

  Date the application was last tested

- date_prepared:

  Date the statement was prepared in it's current form

- date_reviewed:

  Date the statement was last reviewed

- date_template_reviewed:

  Date the underlying template was reviewed (default: 12th March 2024)

- issues_contact:

  URL for the GitHub Issues log or contact e-mail address for users to
  flag accessibility issues

- publication_name:

  The parent publication name (optional)

- publication_slug:

  The parent publication slug on Explore Education Statistics (optional)

- non_accessible_components:

  String vector containing a list of non accessible components

- specific_issues:

  String vector containing descriptions of specific accessibility issues
  that have been identified as part of testing

## Value

shiny\$tags\$div element containing the HTML tags and content for the
standard accessibility statement

## Examples

``` r
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
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-l" id="accessibility_statement_for_dfe_shiny_template">Accessibility statement for DfE Shiny template</h1>
#>   <p class="govuk-body">
#>     This accessibility statement applies to the
#>     https://department-for-education.shinyapps.io/dfe-shiny-template
#>     website. This website is run by the <a href="https://www.gov.uk/government/organisations/department-for-education" class="govuk-link" target="_blank" rel="noopener noreferrer">Department for Education (DfE) (opens in new tab)</a>.
#>     This statement does not cover any other services run by the Department for Education 
#>     (DfE) or GOV.UK.
#>   </p>
#>   <h2 class="govuk-heading-m" id="how_you_should_be_able_to_use_this_website">How you should be able to use this website</h2>
#>   <p class="govuk-body">We want as many people as possible to be able to use this website. You should be able to:</p>
#>   <div>
#>     <ul class="govuk-list ">
#>       <li>change colours, contrast levels and fonts using browser or device settings</li>
#>       <li>zoom in up to 400% without the text spilling off the screen</li>
#>       <li>navigate most of the website using a keyboard or speech recognition software</li>
#>       <li>listen to most of the website using a screen reader
#>                     (including the most recent versions of JAWS, NVDA and VoiceOver)</li>
#>     </ul>
#>   </div>
#>   <p class="govuk-body">We've also made the website text as simple as possible to understand.</p>
#>   <p class="govuk-body"><a href="https://mcmw.abilitynet.org.uk/" class="govuk-link" target="_blank" rel="noopener noreferrer">AbilityNet (opens in new tab)</a> has advice on making your device easier to use if you have a disability.
#>   </p>
#>   <h2 class="govuk-heading-m" id="how_accessible_this_website_is">How accessible this website is</h2>
#>   <p class="govuk-body">We know some parts of this website are not fully accessible:</p>
#>   <div>
#>     <ol class="govuk-list govuk-list--number">
#>       <li>Keyboard navigation through the interactive charts is currently limited</li>
#>       <li>Alternative text in interactive charts is limited to titles</li>
#>     </ol>
#>   </div>
#>   <h2 class="govuk-heading-m" id="feedback_and_contact_information">Feedback and contact information</h2>
#>   <p class="govuk-body">
#>     If you need information on this website in a different format please see the
#>      parent publication, <a href="https://explore-education-statistics.service.gov.uk/find-statistics/la-and-school-expenditure" class="govuk-link" target="_blank" rel="noopener noreferrer">LA and school expenditure (opens in new tab)</a>.
#>   </p>
#>   <p class="govuk-body">
#>     More details are available on that service for alternative formats of this 
#>     data.
#>   </p>
#>   <p class="govuk-body">We're always looking to improve the accessibility of this website.
#>              If you find any problems not listed on this page or think we're not meeting
#>              accessibility requirements, contact us:</p>
#>   <ul class="govuk-list ">
#>     <li>a</li>
#>     <li>mailto:explore.statistics@education.gov.uk</li>
#>     <li>explore.statistics@education.gov.uk</li>
#>   </ul>
#>   <h2 class="govuk-heading-m" id="enforcement_procedure">Enforcement procedure</h2>
#>   <p class="govuk-body">
#>     The Equality and Human Rights Commission (EHRC) is responsible for enforcing the Public 
#>     Sector Bodies (Websites and Mobile Applications) (No. 2) Accessibility Regulations 2018
#>     (the "accessibility regulations").
#>   </p>
#>   <p class="govuk-body">
#>     If you are not happy with how we respond to your complaint, contact the <a href="https://www.equalityadvisoryservice.com/" class="govuk-link" target="_blank" rel="noopener noreferrer">Equality Advisory and Support Service (EASS) (opens in new tab)</a>.
#>   </p>
#>   <h2 class="govuk-heading-m" id="technical_information_about_this_websites_accessibility">Technical information about this website's accessibility</h2>
#>   <p class="govuk-body">
#>     The Department for Education (DfE) is committed to making its website accessible, in 
#>     accordance with the Public Sector Bodies (Websites and Mobile Applications) (No. 2) 
#>     Accessibility Regulations 2018.
#>   </p>
#>   <h3 class="govuk-heading-s" id="compliance_status">Compliance status</h3>
#>   <p class="govuk-body">
#>     This website is partially compliant with the <a href="https://www.w3.org/TR/WCAG22/" class="govuk-link" target="_blank" rel="noopener noreferrer">Web Content Accessibility Guidelines version 2.2 AA standard (opens in new tab)</a> due to the non-compliances listed below.
#>   </p>
#>   <h3 class="govuk-heading-s" id="non_accessible_content">Non accessible content</h3>
#>   <p class="govuk-body">The content listed below is non-accessible for the following reasons.
#>              We will address these issues to ensure our content is accessible.</p>
#>   <div>
#>     <ol class="govuk-list govuk-list--number">
#>       <li>Charts have non-accessible components that are inaccessible for keyboard users.</li>
#>       <li>Chart tooltips are not compatible with screen reader use.</li>
#>       <li>Some decorative images are not labelled appropriately as yet.</li>
#>       <li>Some links are not appropriately labelled.</li>
#>     </ol>
#>   </div>
#>   <h3 class="govuk-heading-s" id="disproportionate_burden">Disproportionate burden</h3>
#>   <p class="govuk-body">Not applicable.</p>
#>   <h2 class="govuk-heading-m" id="how_we_tested_this_website">How we tested this website</h2>
#>   <p class="govuk-body">
#>     The template used for this website was last tested on
#>     12 March 2024
#>      against <a href="https://www.w3.org/TR/WCAG22/" class="govuk-link" target="_blank" rel="noopener noreferrer">Accessibility Guidelines WCAG2.2 (opens in new tab)</a>. The test was carried out by the <a href="https://digitalaccessibilitycentre.org/" class="govuk-link" target="_blank" rel="noopener noreferrer">Digital accessibility centre (DAC) (opens in new tab)</a>.
#>   </p>
#>   <p class="govuk-body">DAC tested a sample of pages to cover the core functionality of the service including:</p>
#>   <div>
#>     <ul class="govuk-list ">
#>       <li>navigation</li>
#>       <li>interactive dropdown selections</li>
#>       <li>charts, maps, and tables</li>
#>     </ul>
#>   </div>
#>   <p class="govuk-body">
#>     This specific website was was last tested on 
#>     25 April 2024
#>      against <a href="https://www.w3.org/TR/WCAG22/" class="govuk-link" target="_blank" rel="noopener noreferrer">Accessibility Guidelines WCAG2.2 (opens in new tab)</a>. The test was carried out by the <a href="https://www.gov.uk/government/organisations/department-for-education" class="govuk-link" target="_blank" rel="noopener noreferrer">Department for Education (DfE) (opens in new tab)</a>.
#>   </p>
#>   <h2 class="govuk-heading-m" id="what_were_doing_to_improve_accessibility">What we're doing to improve accessibility</h2>
#>   <p class="govuk-body">
#>     We plan to continually test the service for accessibility issues, and are working 
#>     through a prioritised list of issues to resolve.
#>   </p>
#>   <p class="govuk-body">
#>     Our current list of issues to be resolved is available on our <a href="https://github.com/dfe-analytical-services/shiny-template/issues" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub issues page (opens in new tab)</a>.
#>   </p>
#>   <h2 class="govuk-heading-m" id="preparation_of_this_accessibility_statement">Preparation of this accessibility statement</h2>
#>   <p class="govuk-body">
#>     This statement was prepared on 26 April 2024 and last reviewed on 02 November 2024.
#>     The statement was produced based on a combination of testing carried out by the <a href="https://digitalaccessibilitycentre.org/" class="govuk-link" target="_blank" rel="noopener noreferrer">Digital accessibility centre (DAC) (opens in new tab)</a> and our own testing.
#>   </p>
#> </div>
```
