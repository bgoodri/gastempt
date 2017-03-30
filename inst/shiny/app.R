server <- function(input, output) {
}

ui <- shinyUI(bootstrapPage(
 img(src = 'moved.jpg', align = "left"),
 h1("This page has moved ..."),
 a(href = "https://apps.menne-biomed.de/gastempt",
  HTML("You have your stomach emptied, click here:<br>https://apps.menne-biomed.de/gastempt")),
 img(src = 'screenshot.png')

))

shinyApp(ui = ui, server = server)
