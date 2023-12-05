# dfeshiny
R package containing preferred methods for creating official DfE R-Shiny dashboards 

# Contributing

** Try and make use of the `usethis` package wherever relevant: (https://usethis.r-lib.org/)[https://usethis.r-lib.org/].


## Adding a package/dependency

`usethis::use_package(<package_name>)`

This will create a new script within the package R/ folder.


## Creating a new script

`usethis::use_r(name = <script_name>)`

This will create a new script within the package R/ folder.

## Updating the package version

Once changes have been completed, reviewed and are ready for use in the wild, you
can increment the package version using:

`usethis::use_version()`

Once you've incremented the version number, it'll offer to perform a commit on your behalf, so all you then need to do is push to GitHub.

# Installing the package
To install, run `renv::install("dfe-analytical-services/dfeshiny")`
