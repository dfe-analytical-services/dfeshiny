# dfeshiny
R package containing preferred methods for creating official DfE R-Shiny dashboards 

# Contributing

Try and make use of the `usethis` package wherever relevant: (https://usethis.r-lib.org/)[https://usethis.r-lib.org/]

When you initially clone the package, the first thing you'll need to do is install `devtools`:

`install.packages("devtools")`

Then to load in the package in its current form:

`devtools::load_all()`

## Run the unit tests

Once the package is loaded in you can run the tests locally in a couple of ways:

`Ctrl-Shft-T`

or via the function that triggers

`devtools::check_test()`


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
