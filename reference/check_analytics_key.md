# Check for and Replace Google Analytics Keys

Reads `google-analytics.html` and `ui.R` to check for Google Analytics
keys. If found, replaces them with placeholder values and stages the
files in git.

## Usage

``` r
check_analytics_key(ga_file = "google-analytics.html", ui_file = "ui.R")
```

## Arguments

- ga_file:

  Path to the Google Analytics file.

- ui_file:

  Path to the UI script file.

## Value

TRUE if no issues found, FALSE if replacements were made.
