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
                         selectInput("cloudCountry", "Country", 
                                     c("All countries"="", sort(unique(as.character(dat2$country)))), multiple=TRUE,
                                     selected = c('Australia','Canada','Italy','Chile','Greece','France')),
                         selectInput("cloudVariety", "Variety", 
                                     c("All varieties"="", sort(unique(as.character(dat2$variety)))), multiple=TRUE)
                       ),
                       # functions that must go in the body of the dashboard.
                       dashboardBody(
                         tabItems(
                           tabItem(tabName = "main",
                                   plotlyOutput("wm"),
                                   br(),
                                   br(),
                                   br(),
                                   br(),
                                   plotOutput("wc"),
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