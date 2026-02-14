# Lookup for bad link text

**\[deprecated\]**

## Usage

``` r
bad_link_text
```

## Format

### `bad_link_text`

A data frame with 53 rows and 1 columns:

- bad_link_text:

  Lower cased examples of non-descriptive link text

## Source

Curated by explore.statistics@education.gov.uk

## Details

`bad_link_text` has been superseded by
[`shinyGovstyle::bad_link_text`](https://rdrr.io/pkg/shinyGovstyle/man/bad_link_text.html)
and will no longer receive any updates. It will be removed in the next
major version (v1.0.0).

A single column data frame, listing out known examples of bad link text
that check for in the
[`external_link()`](https://dfe-analytical-services.github.io/dfeshiny/reference/external_link.md)
function.

We've started curating this list so we can create automated checks to
help all link text to be as descriptive as possible in line with [WCAG
2.2 success criteria 2.4.4: Link Purpose (In
Context)](https://www.w3.org/WAI/WCAG22/Understanding/link-purpose-in-context).
