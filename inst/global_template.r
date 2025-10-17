# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# This is the global file.
# Use it to store functions, library calls, source files etc.
# Moving these out of the server file and into here improves performance as the
# global file is run only once when the app launches and stays consistent
# across users whereas the server and UI files are constantly interacting and
# responsive to user input.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Library calls ===============================================================
shhh <- suppressPackageStartupMessages # It's a library, so shhh!

## Core shiny and R packages --------------------------------------------------
shhh(library(shiny))
shhh(library(bslib))
shhh(library(shinytitle))
shhh(library(metathis))

## Custom packages ------------------------------------------------------------
shhh(library(dfeR))
shhh(library(dfeshiny))
shhh(library(shinyGovstyle))
shhh(library(afcolours))

## Creating charts and tables--------------------------------------------------
shhh(library(ggplot2))
shhh(library(ggiraph))

## Data and string manipulation -----------------------------------------------
shhh(library(dplyr))
shhh(library(stringr))

## Data downloads -------------------------------------------------------------
shhh(library(data.table))

## Testing dependencies -------------------------------------------------------
# These are not needed for the app itself but including them here keeps them in
# renv but avoids the app needlessly loading them, saving on load time.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
if (FALSE) {
  shhh(library(shinytest2))
  shhh(library(testthat))
  shhh(library(lintr))
  shhh(library(styler))
}

# Source R scripts ============================================================
# Source any scripts here. Scripts may be needed to process data before it gets
# to the server file or to hold custom functions to keep the main files shorter.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lapply(list.files("R/footer_pages/", full.names = TRUE), source)

# Set global variables ========================================================
