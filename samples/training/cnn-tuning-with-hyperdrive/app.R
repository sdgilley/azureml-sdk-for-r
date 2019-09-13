library(shiny)

run <- getShinyOption("run")
details -< run$get_details()

server <- function(input, output){

  start_time = details$startTimeUtc
  web_view_link = paste0('<a href="', run$get_portal_url(),'">', "Link", "</a>")
  
  output$runDetails <- renderDataTable({

    invalidateLater(2000)
    
    status <- run$get_status()
    
    if (status == "Completed"){
      duration <- details$endTimeUtc
    }
    else {
      duration <- "-"
    }
    
    df <- matrix(list("Run Id",
                      "Status",
                      "Start Time",
                      "Duration",
                      "Target",
                      "Script Name",
                      "Arguments",
                      "Web View",
                      run$id,
                      status,
                      start_time,
                      duration,
                      details$runDefinition$target,
                      details$runDefinition$script,
                      toString(details$runDefinition$arguments),
                      web_view_link),
                 nrow = 8,
                 ncol = 2) 
    
    datatable(df,
              escape = FALSE,
              rownames = FALSE,
              colnames = c(" ", " "),
              caption = paste(unlist(details$warnings), collapse='\r\n'),
              options = list(dom = 't', scrollY = TRUE))
  })
}

ui <- basicPage(
  h4(
    dataTableOutput("runDetails")
  )
)

shinyApp(ui = ui, server = server)