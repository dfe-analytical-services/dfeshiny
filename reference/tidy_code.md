# Tidy code

Script to apply styler code styling to scripts within the shiny
directory structure.

## Usage

``` r
tidy_code(subdirs = c("R", "tests"))
```

## Arguments

- subdirs:

  List of sub-directories to (recursively search for R scripts to be
  styled)

## Value

TRUE if any changes have been made to any scripts, FALSE if all passed.

## Examples

``` r
if (FALSE) { # \dontrun{
tidy_code()
} # }
```
