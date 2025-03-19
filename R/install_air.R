#' Air Install
#'
#' @description checks for air installation status and installs it if
#' required, updating the global settings if selected
#'
#' @examples
#' \dontrun{
#' install_air()
#' }

install_air <- function() {
  # Check for air and settings - need package data.table to do this
  if (!require(data.table))
    install.packages("data.table", repos = "http://cran.us.r-project.org")

  if ("air" %in% system("ls ~/.config/.", intern = TRUE)) {
    message("installed")
  } else {
    message("air not installed: installing now")
    platform <- Sys.info()[1]
    if (platform == "Windows") {
      system(
        'powershell -ExecutionPolicy Bypass -c "irm https://github.com/posit-dev/air/releases/latest/download/air-installer.ps1 | iex"'
      )
    } else {
      system(
        "curl -LsSf https://github.com/posit-dev/air/releases/latest/download/air-installer.sh | sh"
      )
    }
  }

  configs <- readLines("~/.config/rstudio/rstudio-prefs.json")
  changes <- 0

  if (
    any(
      data.table::like(
        configs,
        '"code_formatter_external_command": "~/.local/bin/air format"'
      )
    )
  ) {
    message("referenced")
  } else {
    message("not referenced")
    new_line <- '"code_formatter_external_command": "~/.local/bin/air format",'
    configs <- append(configs, new_line, after = 1)
    changes <- changes + 1
  }
  if (any(data.table::like(configs, '"reformat_on_save": true'))) {
    message("active")
  } else {
    message("not active: activating now")
    new_line <- '"reformat_on_save": true,'
    configs <- append(configs, new_line, after = 1)
    changes <- changes + 1
  }
  if (any(data.table::like(configs, '"code_formatter": "external"'))) {
    message("external ref")
  } else {
    message("no external ref: ref now")
    new_line <- '"code_formatter": "external",'
    configs <- append(configs, new_line, after = 1)
    changes <- changes + 1
  }
  if (changes > 0) {
    writeLines(configs, "~/.config/rstudio/rstudio-prefs.json")
  }
}
