# Support panel

Create the standard DfE R-Shiny support and feedback dashboard panel.

## Usage

``` r
support_panel(
  team_email = "",
  contact_name = NULL,
  repo_name = "",
  ees_publication = TRUE,
  publication_name = NULL,
  publication_slug = "",
  alt_href = NULL,
  form_url = NULL,
  custom_data_info = NULL,
  extra_text = NULL
)
```

## Arguments

- team_email:

  Your team e-mail address, must be a education.gov.uk email

- contact_name:

  Named contact for the dashboard

- repo_name:

  The repository URL, must be a valid URL for the
  dfe-analytical-services GitHub area or the dfe-gov-uk Azure DevOps

- ees_publication:

  Whether the parent publication is hosted on Explore Education
  Statistics

- publication_name:

  The parent publication name

- publication_slug:

  The parent publication slug on Explore Education Statistics

- alt_href:

  Alternative link to the parent publication (if not hosted on Explore
  Education Statistics)

- form_url:

  URL for a feedback form for the dashboard

- custom_data_info:

  A single text string or a
  [`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
  object for custom text to go under the "Find out more information on
  the data" heading.

- extra_text:

  Add extra paragraphs to the page before the "Contact us" section. Use
  [`dfeshiny::section_tags()`](https://dfe-analytical-services.github.io/dfeshiny/reference/section_tags.md)
  to specify the heading and body. Look at examples to see how to add
  one or multiple sections.

## Value

a HTML div, containing standard support content for a public R Shiny
dashboard in DfE

## See also

[`section_tags()`](https://dfe-analytical-services.github.io/dfeshiny/reference/section_tags.md)

[`htmltools::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)

## Examples

``` r
support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com"
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">
#>       This dashboard is a new service that we are developing. If you
#>               have any feedback or suggestions for improvements, please submit
#>               them using our <a href="www.myform.com" class="govuk-link" target="_blank" rel="noopener noreferrer">feedback form (opens in new tab)</a>.
#>     </p>
#>     <p class="govuk-body">
#>       Alternatively, if you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p class="govuk-body">
#>     The parent statistical release of this dashboard, along with
#>               the methodology, is available at <a href="https://explore-education-statistics.service.gov.uk/find-statistics/my-publication-title" class="govuk-link" target="_blank" rel="noopener noreferrer">My publication title (opens in new tab)</a>. Access to the underlying data for this dashboard can be found under the 
#>               'Explore and download data' tab from the above link.
#>               The methodology used to prepare the data can be found under the 'Methodology' tab.
#>   </p>
#>   
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>

# Often you will use this inside a set of navigation tabs, e.g.
shiny::navlistPanel(
  "",
  id = "navlistPanel",
  widths = c(2, 8),
  well = FALSE,
  ## Support panel --------------------------------------------------------
  shiny::tabPanel(
    value = "support_panel",
    "Support and feedback",
    support_panel(
      team_email = "explore.statistics@education.gov.uk",
      repo_name = "https://github.com/dfe-analytical-services/dfeshiny/",
      form_url = "https://forms.office.com"
    )
  )
)
#> <div class="row">
#>   <div class="col-sm-2">
#>     <ul class="nav nav-pills nav-stacked shiny-tab-input" id="navlistPanel" data-tabsetid="9307">
#>       <li class="navbar-brand"></li>
#>       <li class="active">
#>         <a href="#tab-9307-2" data-toggle="tab" data-bs-toggle="tab" data-value="support_panel">Support and feedback</a>
#>       </li>
#>     </ul>
#>   </div>
#>   <div class="col-sm-8">
#>     <div class="tab-content" data-tabsetid="9307">
#>       <div class="tab-pane active" data-value="support_panel" id="tab-9307-2">
#>         <div style="margin-top: 50px; margin-bottom: 50px">
#>           <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>           <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>           <div>
#>             <p class="govuk-body">
#>               This dashboard is a new service that we are developing. If you
#>               have any feedback or suggestions for improvements, please submit
#>               them using our <a href="https://forms.office.com" class="govuk-link" target="_blank" rel="noopener noreferrer">feedback form (opens in new tab)</a>.
#>             </p>
#>             <p class="govuk-body">
#>               Alternatively, if you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:explore.statistics@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">explore.statistics@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>             </p>
#>           </div>
#>           <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>           <p class="govuk-body">
#>             The parent statistical release of this dashboard, along with
#>               the methodology, is available at <a href="https://explore-education-statistics.service.gov.uk/find-statistics/" class="govuk-link" target="_blank" rel="noopener noreferrer">explore education statistics (opens in new tab)</a>. Access to the underlying data for this dashboard can be found under the 
#>               'Explore and download data' tab from the above link.
#>               The methodology used to prepare the data can be found under the 'Methodology' tab.
#>           </p>
#>           
#>           <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>           <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>           <p class="govuk-body">
#>             E-mail: <a href="mailto:explore.statistics@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">explore.statistics@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>           <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>           <p class="govuk-body">
#>             Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/dfeshiny/" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>           </p>
#>         </div>
#>       </div>
#>     </div>
#>   </div>
#> </div>

# Example for adding custom text

# Adding custom text to the feedback section only

support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com",
  custom_data_info = "This is a sentence to test the ability to add custom text in the tab",
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">
#>       This dashboard is a new service that we are developing. If you
#>               have any feedback or suggestions for improvements, please submit
#>               them using our <a href="www.myform.com" class="govuk-link" target="_blank" rel="noopener noreferrer">feedback form (opens in new tab)</a>.
#>     </p>
#>     <p class="govuk-body">
#>       Alternatively, if you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p>This is a sentence to test the ability to add custom text in the tab</p>
#>   
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>

# Adding custom text that includes mixed elements to feedback section

support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  publication_name = "My publication title",
  publication_slug = "my-publication-title",
  form_url = "www.myform.com",
  custom_data_info = shiny::tagList(
    "Please email results to",
    shinyGovstyle::external_link(
      href = paste0("mailto:", "team@education.gov.uk"),
      link_text = "team@education.gov.uk",
      add_warning = FALSE
    )
  )
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">
#>       This dashboard is a new service that we are developing. If you
#>               have any feedback or suggestions for improvements, please submit
#>               them using our <a href="www.myform.com" class="govuk-link" target="_blank" rel="noopener noreferrer">feedback form (opens in new tab)</a>.
#>     </p>
#>     <p class="govuk-body">
#>       Alternatively, if you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p>
#>     Please email results to<a href="mailto:team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>
# Example for adding custom sections

# Adding one section
support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  custom_data_info = "This is a sentence to test the ability to add custom text in the tab",
  extra_text = section_tags(
    heading = "heading",
    body = "this is a body"
  )
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">This dashboard is a new service that we are developing.</p>
#>     <p class="govuk-body">
#>       If you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p>This is a sentence to test the ability to add custom text in the tab</p>
#>   <h2>heading</h2>
#>   <p>this is a body</p>
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>
# Adding two sections
support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  extra_text = c(
    section_tags(
      heading = "heading",
      body = "this is a body"
    ),
    section_tags(
      heading = "heading 2",
      body = "this is another example of a text"
    )
  )
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">This dashboard is a new service that we are developing.</p>
#>     <p class="govuk-body">
#>       If you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p class="govuk-body">
#>     The parent statistical release of this dashboard, along with
#>               the methodology, is available at <a href="https://explore-education-statistics.service.gov.uk/find-statistics/" class="govuk-link" target="_blank" rel="noopener noreferrer">explore education statistics (opens in new tab)</a>. Access to the underlying data for this dashboard can be found under the 
#>               'Explore and download data' tab from the above link.
#>               The methodology used to prepare the data can be found under the 'Methodology' tab.
#>   </p>
#>   <h2>heading</h2>
#>   <p>this is a body</p>
#>   <h2>heading 2</h2>
#>   <p>this is another example of a text</p>
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>

# Adding a section with a shiny::tagList() in
# the dfeshiny::section_tags()

support_panel(
  team_email = "my.team@education.gov.uk",
  repo_name = "https://github.com/dfe-analytical-services/my-repo",
  extra_text = c(
    section_tags(
      heading = "Heading",
      body = shiny::tagList(
        "Please email results to",
        shinyGovstyle::external_link(
          href = paste0("mailto:", "team@education.gov.uk"),
          link_text = "team@education.gov.uk",
          add_warning = FALSE
        )
      )
    )
  )
)
#> <div style="margin-top: 50px; margin-bottom: 50px">
#>   <h1 class="govuk-heading-xl" id="support_and_feedback">Support and feedback</h1>
#>   <h2 class="govuk-heading-l" id="give_us_feedback">Give us feedback</h2>
#>   <div>
#>     <p class="govuk-body">This dashboard is a new service that we are developing.</p>
#>     <p class="govuk-body">
#>       If you spot any errors or bugs while using this dashboard, please
#>               screenshot and email them to <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a>.
#>     </p>
#>   </div>
#>   <h2 class="govuk-heading-l" id="find_more_information_on_the_data">Find more information on the data</h2>
#>   <p class="govuk-body">
#>     The parent statistical release of this dashboard, along with
#>               the methodology, is available at <a href="https://explore-education-statistics.service.gov.uk/find-statistics/" class="govuk-link" target="_blank" rel="noopener noreferrer">explore education statistics (opens in new tab)</a>. Access to the underlying data for this dashboard can be found under the 
#>               'Explore and download data' tab from the above link.
#>               The methodology used to prepare the data can be found under the 'Methodology' tab.
#>   </p>
#>   <h2>Heading</h2>
#>   <p>
#>     Please email results to<a href="mailto:team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="contact_us">Contact us</h2>
#>   <p class="govuk-body">Use the following contact details if you have questions about the dashboard or data within it.</p>
#>   <p class="govuk-body">
#>     E-mail: <a href="mailto:my.team@education.gov.uk" class="govuk-link" target="_blank" rel="noopener noreferrer">my.team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
#>   <h2 class="govuk-heading-l" id="see_the_source_code">See the source code</h2>
#>   <p class="govuk-body">
#>     Use the following contact details if you have questions about the dashboard or data <a href="https://github.com/dfe-analytical-services/my-repo" class="govuk-link" target="_blank" rel="noopener noreferrer">GitHub repository (opens in new tab)</a>.
#>   </p>
#> </div>
```
