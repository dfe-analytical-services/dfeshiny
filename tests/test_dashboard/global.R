library(shiny)
devtools::load_all(path = "../../")

ga_key <- "ABCDE12345"

navigation_links <- c(
  "Support and feedback" = "support_panel",
  "Accessibility" = "a11y_panel",
  "Cookies" = "cookies_panel_ui",
  "Text example" = "text_example",
  "Table example" = "table_panel_ui"
)

bookmarking_whitelist <- "dashboard_page"
enableBookmarking("url")
