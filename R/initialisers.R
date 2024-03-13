#' initialise_analytics
#'
#' @param ga_code The Google Analytics code
#' @importFrom magrittr %>%
#' @return TRUE if written, FALSE if not
#' @export
#'
#' @examples initialise_analytics(ga_code = "0123456789")
initialise_analytics <- function(ga_code) {
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
The custom trackers below can be tailored to match the inputs used in your dashboard.
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
    'event_label' : document.querySelector('ul#navlistPanel > li.active > a').getAttribute('data-value')
    });
  });

  $(document).on('click', 'ul#tabsetpanels', function(e) {
    gtag('event', 'tab panels', {'event_category' : 'tab panel clicks',
    'event_label' : document.querySelector('ul#tabsetpanels > li.active > a').getAttribute('data-value')
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

</script>
      " %>% gsub("XXXXXXXXXX", ga_code, .)
  if (file.exists("google-analytics.html")) {
    message("Analytics file already exists. If you have any customisations in that file, make sure you've backed those up before over-writing.")
    user_input <- stringr::str_trim(readline(prompt = "Are you happy to overwrite the existing analytics script (y/N) "))
    if (user_input %in% c("y", "Y")) {
      write_out <- TRUE
    } else {
      write_out <- FALSE
    }
  } else {
    write_out <- TRUE
  }
  if (write_out) {
    cat(html_script, file = "google-analytics.html")
    message("Google analytics script created in google-analytics.html.")
    message("You'll need to add the following line to your ui.R script to start
            recording analytics:")
    message('tags$head(includeHTML(("google-analytics.html"))),')
  } else {
    message("Original Google analytics html script left in place.")
  }
}
