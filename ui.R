suppressPackageStartupMessages(library(shinydashboard))
suppressPackageStartupMessages(library(shinyWidgets))
#https://rstudio.github.io/shinydashboard/get_started.html
# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(
    title = "Visulization for methylation calling result from Nanopore data",
    titleWidth = 1200
  ),
  #Sidebar content
  dashboardSidebar(
    sidebarMenu(# dashboard should display tutorial or instructions of how to use the app
      # icon list: https://rstudio.github.io/shinydashboard/appearance.html#icons
      menuItem("About", tabName = "about", icon = icon("dashboard")),
      menuItem("Tool comparison", tabName = "table", icon = icon("table")),
      menuItem("Correlation plotting", tabName = "plot", icon = icon("chart-line"))
    )
  ),
  
  # Body content
  dashboardBody(
    tabItems(
      tabItem(
        ## 1st tab content
        tabName = "about", 
        fluidRow(
          column(12,
                 titlePanel("About"),
                 htmlOutput('about'))
        )
      ),
      
      ## 2nd tab content
      tabItem(
        tabName = "table", 
        h2("Methylation Calling Results at site level"),
        fluidRow(
          column(2,
                 pickerInput(inputId = "dataset", label = "Dataset", 
                             choices= c(sort(unique(as.character(df$Dataset)))), 
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(2,
                 pickerInput(inputId = "chrom", label = "Chromosome", 
                             choices= c(sort(unique(as.character(df$Chrom)))), 
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(2,
                 pickerInput(inputId = "strand", label = "Strand", 
                             choices= c(sort(unique(as.character(df$Strand)))),
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(2,
                 pickerInput(inputId = 'singleton',label = "Singleton/Non-singleton",
                             choices= c(sort(unique(as.character(df$Singleton)))),
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(2,
                 pickerInput(inputId = 'genome_location',label = "Biological location",
                             choices= c(sort(unique(as.character(df$Genome_location)))),
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(2,
                 pickerInput(inputId = 'cgi',label = "CpG island or not",
                             choices= c(sort(unique(as.character(df$CpG_island)))), 
                             options = list(`actions-box` = TRUE), 
                             multiple = TRUE)
          ),
          column(12,
                 div(style = "font-size:medium; font-weight:bold",'Methylation calling results'), 
                 DT::dataTableOutput(outputId = "table1")
          ),
          column(12,
                 "All start coordinates shown here are 1-based, not 0-based.")
        )
      ),
      #3rd tab content
      tabItem(
        tabName = "plot", 
        h2("Methylation correlation plotting for methylation calling tool compared to BS-seq"),
        fluidRow(
          tabBox(width = 7,
                 tabPanel('NA19240',
                          img(src = "plotting_NA19240.png", height = 520, width = 520)),
                 tabPanel('APL',                                         
                          img(src = "plotting_APL.png", height = 520, width = 520)),
                 tabPanel('K562',                                        
                          img(src = "plotting_K562.png", height = 520, width = 520)),
                 tabPanel('HL60',
                          img(src = "plotting_HL60.png", height = 520, width = 520))
        )
      )
    )
  )
))