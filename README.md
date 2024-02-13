# dfeshiny

R package containing preferred methods for creating official DfE R-Shiny dashboards 

## Using this package in a DfE data dashboard

### Adding cookies to your dashboard

dfeshiny provides the facility to add a gov.uk styled cookie banner to your 
site, which is fully functional in terms of controlling the user permissions for
tracking their use of the site via Google Analytics.

Before adding the cookie consent banner, you will need to obtain a Google 
Analytics key that's both unique to your app and stored within the DfE Google
Analytics domain. You can request a key from the 
[Statistics Development team](mailto:statistics.development@education.gov.uk). 
This should then be added as a variable to your dashboard's 
[global.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/global.R) 
file (replacing `ABCDE12345` below with the key provided by the Statistics 
Development team):

```
google_analytics_key <- 'ABCDE12345'
```

Next, you should copy the javascript file
([cookie_consent.js](https://raw.githubusercontent.com/dfe-analytical-services/dfeshiny/cookie-module/js/cookie-consent.js)) 
necessary for controlling the cookie storage in the user's browser to the `www/` 
folder in your dashboards repository.

Once you've made the above updates, add the following lines to your 
[ui.R](https://github.com/dfe-analytical-services/shiny-template/blob/3e9548256ffb5506729f02930ad69bcff78e482d/ui.R#L95) 
script (updating "My DfE R Shiny data dashboard" with the name of your app):

```
dfe_cookie_script()
cookie_banner_ui("cookies", name = "My DfE R Shiny data dashboard")
```

Putting these on the lines *just before* the `shinyGovstyle::header(...)` line 
should work well.

Then add the following code to your
[server.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/server.R) 
script somewhere *inside* the `server <- function(input, output, session) {...}` 
function (you shouldn't need 
to change anything in this one):

```
output$cookie_status <- dfeshiny::cookie_banner_server(
  "cookies",
  input_cookies = reactive(input$cookies),
  input_clear = reactive(input$cookie_consent_clear),
  parent_session = session,
  google_analytics_key = google_analytics_key
)
```

Finally, you should make sure you're using the `dfeshiny::support_panel()` 
function within the `navListPanel(...)` in your 
[ui.R](https://github.com/dfe-analytical-services/dfeshiny/blob/cookie-module/tests/test_dashboard/ui.R) 
script as this will provide
users with the necessary explanatory text on how we use cookies and the ability 
to change their decision on whether or not to accept the use of cookies.

## Contributing

** Try and make use of the `usethis` package wherever relevant: (https://usethis.r-lib.org/)[https://usethis.r-lib.org/].


### Adding a package/dependency

`usethis::use_package(<package_name>)`

This will create a new script within the package R/ folder.


### Creating a new script

`usethis::use_r(name = <script_name>)`

This will create a new script within the package R/ folder.

### Updating the package version

Once changes have been completed, reviewed and are ready for use in the wild, you
can increment the package version using:

`usethis::use_version()`

Once you've incremented the version number, it'll offer to perform a commit on your behalf, so all you then need to do is push to GitHub.
