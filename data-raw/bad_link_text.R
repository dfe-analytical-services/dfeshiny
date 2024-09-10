bad_link_text <- data.frame(
  bad_link_text = c(
    # one word examples
    "click", "csv", "dashboard", "document", "download", "file", "form",
    "guidance", "here", "information", "jpeg", "jpg", "learn", "link", "more",
    "next", "page", "pdf", "previous", "read", "site", "svg", "this", "web",
    "webpage", "website", "word", "xslx",
    # two word examples
    "click here", "click this link", "download csv", "download document",
    "download file", "download here", "download jpg", "download jpeg",
    "download pdf", "download png", "download svg", "download word",
    "download xslx", "further information", "go here", "learn more",
    "read more", "this page", "web page", "web site"
  )
)

usethis::use_data(bad_link_text, overwrite = TRUE)
