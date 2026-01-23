# Changelog

## dfeshiny (development version)

- Added extra flexibility to custom disconnect message in contact
  details and refresh link
- Relaxed arguments in cookies banner so different IDs can be used for
  navigation panel
- Fixed bug with inputId in the cookies banner
- Re-structured cookie UI and added margins to cookie banner css

## dfeshiny 0.5.3

- Added
  [`dfeshiny::a11y_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/a11y_panel.md)
  to create model accessibility statement with custom issue listings.

## dfeshiny 0.5.2

- Added
  [`dfeshiny::header()`](https://dfe-analytical-services.github.io/dfeshiny/reference/header.md)
  function to produce a standardised header incorporating the current
  DfE logo. This is a wrapper function to
  [`shinyGovstyle::header()`](https://rdrr.io/pkg/shinyGovstyle/man/header.html),
  reducing the range of options.

## dfeshiny 0.5.1

- Refresh of disconnect dialogue message and styling

## dfeshiny 0.5.0

### New features

- `custom_data_info` argument added to
  [`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md)
  so users can write their own custom text in the “Find out more
  information on the data” section.

- `extra_text` argument added to
  [`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md)
  so users can add their own sections.

- Added
  [`section_tags()`](https://dfe-analytical-services.github.io/dfeshiny/reference/section_tags.md)
  to provide structure for the `extra_text` argument in
  [`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md).

- Added “this link” to the look up data for `bad_link_text`

## dfeshiny 0.4.3

- Fix bug in
  [`external_link()`](https://dfe-analytical-services.github.io/dfeshiny/reference/external_link.md)
  hidden warning so that it can be read by screen readers.

## dfeshiny 0.4.2

- Applied use of
  [`external_link()`](https://dfe-analytical-services.github.io/dfeshiny/reference/external_link.md)
  to
  [`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md).

## dfeshiny 0.4.1

- Fix bug in
  [`external_link()`](https://dfe-analytical-services.github.io/dfeshiny/reference/external_link.md)
  where visually hidden text was not visually hidden and whitespace was
  appearing if add_warning = FALSE was set.

## dfeshiny 0.4.0

- Add new
  [`external_link()`](https://dfe-analytical-services.github.io/dfeshiny/reference/external_link.md)
  function and look up data for `bad_link_text`.

## dfeshiny 0.3.0

### New features

- [`init_analytics()`](https://dfe-analytical-services.github.io/dfeshiny/reference/init_analytics.md)
  to add the necessary analytics script into a repository.

- New cookies module for the panel page added, completing the cookies
  family of functions, shared examples and a vignette to walk through
  how to use them.

### Breaking changes

- Ironed out inconsistencies in cookies family to use plural of
  ‘cookies’ consistently. Backwards compatibility has not been
  maintained as we are still in early development and adoption is low.
  - `cookie_banner_server()` is now
    [`cookies_banner_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_server.md)
  - `cookie_banner_ui()` is now `cookie_banner_ui()`
  - `dfe_cookie_script()` is now
    [`dfe_cookies_script()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies.md)
- Have removed dependency on using
  [`shiny::tabPanel()`](https://rdrr.io/pkg/shiny/man/tabPanel.html)
  within
  [`support_panel()`](https://dfe-analytical-services.github.io/dfeshiny/reference/support_panel.md)
  so now it will return only the content rather than a tabPanel.

### Improvements

- Automated testing of test dashboard using GitHub actions.
- Fixed favicons in pkgdown site.
- Moved code for
  [`init_cookies()`](https://dfe-analytical-services.github.io/dfeshiny/reference/init_cookies.md)
  to inline, to prevent dependency on main GitHub branch.
- Added separate contributing guidelines to make the README more user
  focused.
- Added issues and PR templates.

## dfeshiny 0.2.0

### New features

- dfeshiny now has a pkgdown site!

- The custom_disconnect_message() function has been brought into
  dfeshiny to help handle disconnects from the host server and signpost
  restarting a given app.

- A module is now provided to produce a standardised cookie consent
  banner and implement the associated functionality. The server part is
  [`cookies_banner_server()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_server.md)
  and the ui part is
  [`cookies_banner_ui()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies_banner_ui.md).
  In addition,
  [`dfe_cookies_script()`](https://dfe-analytical-services.github.io/dfeshiny/reference/cookies.md)
  is provided to implement the necessary javascript.

### Improvements

- Implemented basic unit testing (currently just on e-mail validation)
  and UI testing using a test dashboard.

- Instructions within the package README.md on how to install `dfeshiny`
  have been updated.
