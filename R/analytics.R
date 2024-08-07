#' init_analytics
#'
#' @description
#' Creates the google-analytics.html script in order to allow the activation of
#' analytics via GA4. For the full steps required to set up analytics, please
#' refer to the documentation in the README.
#'
#' @param ga_code The Google Analytics code for the dashboard
#' @param create_file Boolean TRUE or FALSE, default is TRUE, false will return
#' the HTML in the console and is used mainly for testing or comparisons
#'
#' @importFrom magrittr %>%
#' @return NULL
#' @export
#'
#' @examples
#' if (interactive()) {
#'   init_analytics(ga_code = "0123456789")
#' }
init_analytics <- function(ga_code, create_file = TRUE) {
  if (!is.logical(create_file)) {
    stop("create_file must always be TRUE or FALSE")
  }

  is_valid_ga4_code <- function(ga_code) {
    stringr::str_length(ga_code) == 10 & typeof(ga_code) == "character"
  }

  if (is_valid_ga4_code(ga_code) == FALSE) {
    stop(
      'You have entered an invalid GA4 code in the ga_code argument.
      Please enter a 10 digit code as a character string.
      e.g. "0123QWERTY"'
    )
  }

  # Google analytics HTML =====================================================
  html_script <- "<script>
// Define dataLayer and the gtag function.
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}

// Default ad_storage to 'denied' as a placeholder
// Determine actual values based on your own requirements
gtag('consent', 'default', {
  'ad_storage': 'denied',
  'analytics_storage': 'denied'
});
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
  <script async src='https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX'></script>
  <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}

    gtag('js', new Date());

  gtag('config', 'G-XXXXXXXXXX');

/*
The custom trackers below can be tailored to match the inputs used in your
dashboard.
*/

  $(document).on('change', 'select#selectPhase', function(e) {
    gtag('event', 'select phase', {'event_category' : 'choose Phase',
    'event_label' : document.querySelector('select#selectPhase').value
    });
  });

  $(document).on('change', 'select#selectArea', function(e) {
    gtag('event', 'select area', {'event_category' : 'choose Area',
    'event_label' : document.querySelector('select#selectArea').value
    });
  });

  $(document).on('click', 'ul#navlistPanel', function(e) {
    gtag('event', 'navlistPanel', {'event_category' : 'navbar click',
    'event_label' : document.querySelector(
    'ul#navlistPanel > li.active > a'
    ).getAttribute('data-value')
    });
  });

  $(document).on('click', 'ul#tabsetpanels', function(e) {
    gtag('event', 'tab panels', {'event_category' : 'tab panel clicks',
    'event_label' : document.querySelector(
    'ul#tabsetpanels > li.active > a'
    ).getAttribute('data-value')
    });
  });


  $(document).on('click', 'a#download_data', function(e) {
    gtag('event', 'Download button', {'event_category' : 'Download button click'
    });
  });

  $(document).on('shiny:disconnected', function(e) {
    gtag('event', 'disconnect', {
      'event_label' : 'Disconnect',
      'event_category' : 'Disconnect'
    });
  });

</script>"

  # Swap in the GA ID
  html_script_with_id <- gsub("XXXXXXXXXX", ga_code, html_script)

  # End of google analytics HTML ==============================================

  if (create_file == FALSE) {
    # Just return without options or messages
    cat(html_script_with_id, file = "", sep = "\n")
  } else {
    if (file.exists("google-analytics.html")) {
      message("Analytics file already exists.")
      message("If you have any customisations in that file, make sure you've
    backed those up before over-writing.")
      user_input <- readline(
        prompt = "Are you happy to overwrite the existing analytics script (y/N) "
      ) |>
        stringr::str_trim()
      if (user_input %in% c("y", "Y")) {
        write_out <- TRUE
      } else {
        write_out <- FALSE
      }
    } else {
      write_out <- TRUE
    }
    if (write_out) {
      cat(html_script_with_id, file = "google-analytics.html", sep = "\n")
      message("")
      message("Google analytics script created as google-analytics.html.")
      message("You'll need to add the following line to your ui.R script to start using analytics:")
      message("")
      message("tags$head(includeHTML((google-analytics.html))),")
    } else {
      message("Original Google analytics html script left in place.")
    }
  }
}
