test_that("publication link is valid", {
  # Test that an EES publication link passes
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

  # Test that a gov.uk publication link passes
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://www.gov.uk/government/collections/job-and-skills-data"
    )
  )

  # Test that it fails for non-existent links/typos/random links
  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/hello"
    )
  )

  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://www.bbc.com/news"
    )
  )

})

test_that("site links are valid", {
  # Test that valid long shinyapps.io link pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

  # Test that valid short shinyapps.io link pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://department-for-education.shinyapps.io/dfe-shiny-template/",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

  # Test that a list of valid shinyapps.io links pass
  expect_no_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c("https://department-for-education.shinyapps.io/dfe-shiny-template/?_inputs_&navlistPanel=%22dashboard%22&tabsetpanels=%22Valuebox%20example%22&cookieAccept=1&cookieReject=0&cookieLink=0&hideAccept=1&hideReject=0&remove=0&selectPhase=%22All%20LA%20maintained%20schools%22&selectArea=%22England%22&selectBenchLAs=null",
                "https://department-for-education.shinyapps.io/dfe-shiny-template-overflow/",
                "https://department-for-education.shinyapps.io/dfe-shiny-template/"),
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

  # Test that it fails for non-shinyapps.io links
  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools",
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

  expect_error(
    custom_disconnect_message(
      refresh = "Refresh page",
      links = c("https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools",
                "https://department-for-education.shinyapps.io/dfe-shiny-template/"),
      publication_name = "Pupil attendance in schools",
      publication_link = "https://explore-education-statistics.service.gov.uk/find-statistics/pupil-attendance-in-schools"
    )
  )

})
