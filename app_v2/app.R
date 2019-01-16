#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic
shinyServer(function(input, output){ 
    
    # have a group check box of continents that can be selected 
    output$continent <- renderUI({
        checkboxGroupInput("continent2", "continent", choices = sort(unique(clean_data$continent))[-7], selected = "North America")
    })
    
    ## create drop-down menu of different countries based on continent selected
    output$countries <- renderUI({
        selectInput("countries2", label = "Select Country", 
                    choices = sort(unique(filter(clean_data, Continent %in% input$continent2)$country)), 
                    multiple = TRUE)
    })
    
    ## create a checkbox to select all countries for selected continents - to make it easier for the user 
    output$allcountries <- renderUI({checkboxInput("allcountries", label = "Select All Countries", value=TRUE)})
    
    ## create drop-down menu of different grape types (Red and White)
    output$grape <- renderUI({
        selectInput("grape", label = "Select Grape Varietal", selected = "All",
                    choices = c("Red", "White", "All"))
    })
    
    ## create a variable for the grape type option to be viewed that is selected by the user in the drop-down menu
    
    ## this variable is fed into the ggplot call below 
    grape_type <- reactive({
        if(input$grape == "All"){
            unique(clean_data$Grape)
        }else{
            input$grape
        }
    })
    
    ## filter the wine data set and create a wine_data variable that will be fed into the ggplot call below. 
    ## this variable depends on whether the Select All Countries (SAC) check box is selected.
    ## If SAC is selected, the countries in the selected continent are obtained from the country dictionary.
    ## If SAC is not selected, capture countries selected from the drop-down menu. 
    wine_data <- reactive({
        if(input$allcountries%%2==1){
            clean_data %>%
                filter(Continent %in% input$continent2) %>% 
                filter(Country %in% unlist(lapply(input$continent2, function(x) country_dict[[x]]))) %>%
                filter(Grape %in% grape_type())
        } else{
            clean_data %>%
                filter(Continent %in% input$continent2) %>%
                filter(Country %in% input$countries2) %>%
                filter(Grape %in% grape_type())
        }
    })
    
    
})
