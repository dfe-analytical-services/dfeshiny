# Create `shiny::tagList()` for HTML section

Create a list of tags that generate a HTML section. This generates a
header using `shiny::tags$h2()` and a paragraph body using
`shiny::tags$p()`

This is to be used with functions in the `dfeshiny` package to add extra
sections to a public R Shiny dashboard in DfE

## Usage

``` r
section_tags(heading = NULL, body, h_level = "h2")
```

## Arguments

- heading:

  Optional - A single text string or a
  [`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
  object for the heading of your paragraph

- body:

  A single text string or a
  [`shiny::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)
  object for the body of your paragraph

- h_level:

  Specify the level for your heading, if you choose to include one.
  Default is "h2". Available options are "h2","h3" or "h4".

## Value

A list of HTML tags that contain a paragraph body and an optional
heading.

## See also

[`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md)

[htmltools::tags](https://rstudio.github.io/htmltools/reference/builder.html)

[`htmltools::tagList()`](https://rstudio.github.io/htmltools/reference/tagList.html)

## Examples

``` r
# Example for text heading and body
section_tags(
  heading = "Heading test",
  body = "This is a body text test"
)
#> <h2>Heading test</h2>
#> <p>This is a body text test</p>

# Example for using a different heading level
section_tags(
  heading = "Heading test",
  body = "This is a body text test",
  h_level = "h3"
)
#> <h3>Heading test</h3>
#> <p>This is a body text test</p>


# Example for text heading and text with other elements in the body


section_tags(
  heading = "Heading test",
  body = shiny::tagList(
    "This is a body text test. Please contact us at",
    dfeshiny::external_link(
      href = paste0("mailto:", "team@education.gov.uk"),
      link_text = "team@education.gov.uk",
      add_warning = FALSE
    )
  )
)
#> <h2>Heading test</h2>
#> <p>
#>   This is a body text test. Please contact us at<a href="mailto:team@education.gov.uk" target="_blank" rel="noopener noreferrer">team@education.gov.uk<span class="sr-only"> (opens in new tab)</span></a></p>
```
