app <- AppDriver$new(
  name = "external_link",
  expect_values_screenshot_args = FALSE
)

app$wait_for_idle(50)

all_text <- app$get_text("p")

test_that("Link text appears with correct warnings", {
  expect_gt(
    grep(
      "Hey R Shiny (opens in new tab) is so great we should show it off more",
      all_text,
      fixed = TRUE
    ) |>
      length(),
    0
  )
})

test_that("Link text appears with hidden warning", {
  expect_gt(
    grep(
      paste0(
        "Sometimes you just want to be writing R Shiny (opens in new tab)",
        " code in a cave without distractions."
      ),
      all_text,
      fixed = TRUE
    ) |>
      length(),
    0
  )
})

test_that("Link text doesn't have excess whitespace", {
  expect_gt(
    grep(
      "Hey I think the greatest thing ever is R Shiny (opens in new tab).",
      all_text,
      fixed = TRUE
    ) |>
      length(),
    0
  )

  expect_gt(
    grep(
      "when writing code in R Shiny (opens in new tab).",
      all_text,
      fixed = TRUE
    ) |>
      length(),
    0
  )
})

all_links_html <- app$get_html("a")

test_that("Inspect HTML is as expected", {
  visible_link_html <- grep(
    "target=\"_blank\" rel=\"noopener noreferrer\">R Shiny (opens in new tab)</a>",
    all_links_html,
    fixed = TRUE,
    value = TRUE
  )
  expect_snapshot(visible_link_html)

  # Remove all whitespace and line breaks for matching as struggling
  # to get matches otherwise.
  clean_html <- gsub("\\s+", "", all_links_html)
  clean_pattern <- gsub(
    "\\s+",
    "",
    paste0(
      "<a href=\"https://shiny.posit.co/\" class=\"govuk-link\"",
      "target=\"_blank\" rel=\"noopener noreferrer\">R Shiny<span ",
      "class=\"sr-only\"> (opens in new tab)</span></a>"
    )
  )
  hidden_link_html <- grep(
    clean_pattern,
    clean_html,
    fixed = TRUE,
    value = TRUE
  )
  expect_snapshot(hidden_link_html)
})
