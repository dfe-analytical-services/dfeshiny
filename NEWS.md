# dfeshiny 0.3.0

## New features

* `init_analytics()` to add the necessary analytics script into a repository

* New cookies module for the panel page added, completing the cookies family of
functions, shared examples and a vignette to walk through how to use them.

## Improvements

* Automated testing of test dashboard using GitHub actions
* Fixed favicons in pkgdown site

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
testing using a test dashboard;

* Instructions within the package README.md on how to install `dfeshiny` have
been updated.
