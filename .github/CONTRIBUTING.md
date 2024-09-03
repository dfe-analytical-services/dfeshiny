# Contributing to dfeshiny

Try and make use of the [usethis](https://usethis.r-lib.org/) package wherever possible.

When you initially clone the package, the first thing you'll need to do is install [devtools](https://devtools.r-lib.org/):

```
install.packages("devtools")
```

Then to load in the package in its current form:

```
devtools::load_all()
```

## Adding a package/dependency

`usethis::use_package(<package_name>)`

Note that when adding a function from another package into one of the dfeshiny functions you will need to explicitly state the package in the function call, e.g.:

```package::function()```

Alternatively, if there's a lot of uses of a single function within one of our R scripts, you can call that function once at the top of the R script, e.g:

```
@' importFrom package function
```

For more information see the [roxygen2 documentation on declaring dependencies](https://roxygen2.r-lib.org/articles/namespace.html).

## Creating a new function script

`usethis::use_r(name = <script_name>)`

This will create a new blank script within the package R/ folder.

## Creating a new function test script

`usethis::use_test(name = <script_name>)`

This will create a new blank test script within the package testthat/ folder.

## Updating the package version

Once changes have been completed, reviewed and are ready for use in the wild, you
can increment the package version using:

`usethis::use_version()`

Once you've incremented the version number, it'll add a new heading to news.md.

Add a summary under news.md and then accept it's offer to commit on your behalf.

Once pushed and on the main branch, create a new release in GitHub itself.

## Running tests

You should run the following lines to test the package locally:
``` 
# To check functionality
devtools::check() # Ctrl-Shft-E
shinytest2::test_app("tests/test_dashboard") # important as not currently ran in CI checks

# For code styling
styler::style_pkg()
lintr::lint_package()
```

If you get a lot of lintr errors, particularly around things not being defined, make sure to load the package first using Ctrl-Shft-L or `devtools::load_all(".")`, then run again. There's a known issue with lintr not picking up on bindings until packages are loaded
