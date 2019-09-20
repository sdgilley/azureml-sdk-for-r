library(shiny)
library(here)

path <- here("R", "app", "app.R")
shiny::runApp(path, port = 8000)