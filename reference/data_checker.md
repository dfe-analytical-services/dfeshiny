# Validate Data Files and Gitignore Configuration

Performs comprehensive checks on data file tracking and .gitignore
configuration:

1.  Validates .gitignore format

2.  Checks data files against tracking log

3.  Verifies file status classifications

## Usage

``` r
data_checker(datafile_log = "datafiles_log.csv", ignore_file = ".gitignore")
```

## Arguments

- datafile_log:

  path to data log file

- ignore_file:

  path to gitignore file

## Value

TRUE if all checks pass, FALSE otherwise
