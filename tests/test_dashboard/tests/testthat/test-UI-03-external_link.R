# To run the diffviewer on these tests, you need to add the path:
# Doesn't work? testthat::snapshot_review('UI-03-external_link/', path='tests/test_dashboard/')
app <- AppDriver$new(expect_values_screenshot_args = FALSE)

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
        "Sometimes you just want to be writing This link opens in a new tabR",
        " Shiny code in a cave without distractions."
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
      "when writing code in This link opens in a new tabR Shiny.",
      all_text,
      fixed = TRUE
    ) |>
      length(),
    0
  )
})

all_links_html <- app$get_html("a")

test_that("Inspect HTML is as expected", {
  expect_gt(
    grep(
      "target=\"_blank\" rel=\"noopener noreferrer\">R Shiny (opens in new tab)</a>",
      all_links_html,
      fixed = TRUE
    ) |>
      length(),
    0
  )

  expect_gt(
    grep(
      paste0(
        "rel=\"noopener noreferrer\"><span class=\"visually-hidden\">",
        "This link opens in a new tab</span>R Shiny</a>"
      ),
      all_links_html,
      fixed = TRUE
    ) |>
      length(),
    0
  )
})
