library(shiny)
library(DT)
library(azureml)
library(parsedate)

parsed_url <- strsplit(run_url, "/")[[1]]
rg <- parsed_url[8]
subscription_id <- parsed_url[6]
ws_name <- parsed_url[12]
exp_name <- parsed_url[14]
run_id <- parsed_url[16]

ws <- get_workspace(ws_name, subscription_id, rg)
exp <- experiment(ws, exp_name)
run <- azureml$core$run$Run(exp, run_id)

server <- function(input, output){
  
  details = run$get_details()
  web_view_link = paste0('<a href="', run$get_portal_url(),'">', "Link", "</a>")
  
  output$runDetails <- renderDataTable({
    
    invalidateLater(2000)
    
    status <- run$get_status()
    
    if (status == "Completed" || status == "Failed"){
      diff <- (parsedate::parse_iso_8601(details$endTimeUtc) -
               parsedate::parse_iso_8601(details$startTimeUtc))
      duration <- paste(as.numeric(diff), "mins")    }
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
                      format(parsedate::parse_iso_8601(details$startTimeUtc),
                             format = "%B %d %Y %H:%M:%S"),
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
              caption = "Run Details",
              options = list(dom = 't', scrollY = TRUE))
  })
}

ui <- basicPage(
  h4(
    dataTableOutput("runDetails")
  )
)

app <- shinyApp(ui, server)

runApp(app, port = 8000)
