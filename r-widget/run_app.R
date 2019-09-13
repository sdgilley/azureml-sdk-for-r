library(rstudioapi)

#viewer <- getOption("viewer")
#viewer("http://localhost:8000")
shiny::runApp("./current_time", launch.browser = rstudioapi::viewer)
