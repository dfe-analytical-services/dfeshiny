# Commit Hooks for Data Validation, Analytics Check, and Code Styling

This wrapper function executes a series of pre-commit checks, including:

- Data file validation (`data_checker`)

- Google Analytics key validation (`check_analytics_key`, skipped if
  running in shiny_template repo)

- Code styling check (`style_code`)

## Usage

``` r
commit_hooks()
```

## Value

TRUE if all checks pass, FALSE otherwise.

## Examples

``` r
if (FALSE) { # \dontrun{
commit_hooks()
} # }
```
