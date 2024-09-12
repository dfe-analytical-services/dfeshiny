# dfeshiny (development version)

# dfeshiny 0.4.1

* Fix bug in `external_link()` where visually hidden text was not visually 
hidden and whitespace was appearing if add_warning = FALSE was set.

# dfeshiny 0.4.0

* Add new `external_link()` function and look up data for `bad_link_text`.

# dfeshiny 0.3.0

## New features

* `init_analytics()` to add the necessary analytics script into a repository.

* New cookies module for the panel page added, completing the cookies family of
functions, shared examples and a vignette to walk through how to use them.

## Breaking changes

* Ironed out inconsistencies in cookies family to use plural of 'cookies'
consistently. Backwards compatibility has not been maintained as we are still 
in early development and adoption is low.
  * `cookie_banner_server()` is now `cookies_banner_server()`
  * `cookie_banner_ui()` is now `cookie_banner_ui()`
  * `dfe_cookie_script()` is now `dfe_cookies_script()`

* Have removed dependency on using `shiny::tabPanel()` within `support_panel()`
so now it will return only the content rather than a tabPanel.

## Improvements

* Automated testing of test dashboard using GitHub actions.
* Fixed favicons in pkgdown site.
* Moved code for `init_cookies()` to inline, to prevent dependency on main 
GitHub branch.
* Added separate contributing guidelines to make the README more user focused.
* Added issues and PR templates.

# dfeshiny 0.2.0

## New features

* dfeshiny now has a pkgdown site!

* The custom_disconnect_message() function has been brought into dfeshiny to 
help handle disconnects from the host server and signpost restarting a given
app.

* A module is now provided to produce a standardised cookie consent banner and 
implement the associated functionality. The server part is 
`cookies_banner_server()` and the ui part is `cookies_banner_ui()`. In addition, 
`dfe_cookies_script()` is provided to implement the necessary javascript.

## Improvements

* Implemented basic unit testing (currently just on e-mail validation) and UI 
testing using a test dashboard.

* Instructions within the package README.md on how to install `dfeshiny` have
been updated.
