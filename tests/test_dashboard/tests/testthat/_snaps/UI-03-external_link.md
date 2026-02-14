# Inspect HTML is as expected

    Code
      visible_link_html
    Output
      [1] "<a href=\"https://shiny.posit.co/\" class=\"govuk-link\" target=\"_blank\" rel=\"noopener noreferrer\">R Shiny (opens in new tab)</a>"
      [2] "<a href=\"https://shiny.posit.co/\" class=\"govuk-link\" target=\"_blank\" rel=\"noopener noreferrer\">R Shiny (opens in new tab)</a>"

---

    Code
      hidden_link_html
    Output
      [1] "<ahref=\"https://shiny.posit.co/\"class=\"govuk-link\"target=\"_blank\"rel=\"noopenernoreferrer\">RShiny<spanclass=\"sr-only\">(opensinnewtab)</span></a>"
      [2] "<ahref=\"https://shiny.posit.co/\"class=\"govuk-link\"target=\"_blank\"rel=\"noopenernoreferrer\">RShiny<spanclass=\"sr-only\">(opensinnewtab)</span></a>"

