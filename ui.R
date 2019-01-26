# UI file for shiny

shinyUI(dashboardPage
        ( skin = "red",
                       #Application title
                       dashboardHeader(title = "Wine Data Analysis",titleWidth = 400),
                       
                       # dashboard sidebar functions will be inserted here
                       dashboardSidebar(
                         
                         sidebarMenu(
                           menuItem("Main",tabName = "main",icon = icon("dashboard")),
                           menuItem("Data",tabName = "data",icon = icon("table")),
                           menuItem("Info",tabName = "info",icon = icon("info-circle"))
                         ),
                         # sidebar filters that are to be selected by the user
                         selectInput("cloudCountry", "Country", 
                                     c("All countries"="", sort(unique(as.character(dat2$country)))), multiple=TRUE,
                                     selected = c('US')),
                         selectInput("cloudVariety", "Variety", 
                                     c("All varieties"="", sort(unique(as.character(dat2$variety)))), multiple=TRUE),
                         selectInput("cloudGrape", "Grape Type", 
                                     c("All varieties"="", sort(unique(as.character(dat2$Grape)))), multiple=TRUE),
                         sliderInput("WinePrice", "Select your desired price range.",
                                     min = 10, max = 100, value = c(10,100)) ,
                         sliderInput("WineRating", "Select your desired rating range.",
                                     min = 80, max = 100, value = c(80,100))
                         #numericInput("maxPrice", "Max Price:", 30, min = 0),
                         #selectInput("Province", "Province", 
                                    # c("All province"="", sort(unique(as.character(dat2$province)))), multiple = TRUE,
                                    #selected = c('Oregon', 'Washington'))
                       ),
                       # functions that must go in the body of the dashboard.
                       dashboardBody(
                         tabItems(
                           tabItem(tabName = "main",
                                   fluidRow(
                                     
                                     column(width = 6, height = 7,
                                            plotlyOutput("winePlot1")),
                                     column(width = 6, height = 7,
                                            plotOutput("wc"))
                                            
                                    
                                     
                                   ),
                                   br(),
                                   plotlyOutput("wm"),
                                   tags$head(
                                     tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
                                   )
                           ),
                           
                           tabItem(tabName = "data",
                                   downloadButton("download", "Download results"),
                                   br(),
                                   br(),
                                   br(),
                                   DT::dataTableOutput("results")
                           ),
                           tabItem(tabName = "info",
                                   includeMarkdown("info.md"),
                                   hr()
                           )
                         )
                       )
)
)