function(input, output, session) {
 
  # making reactive buttons for the user inputs 
  data_reactive <- reactive({
    data_React <- dat2 %>% filter(is.null(input$cloudCountry) | country %in% input$cloudCountry,
                                is.null(input$cloudVariety) | variety %in% input$cloudVariety,
                                is.null(input$cloudGrape) | Grape %in% input$cloudGrape,
                                price > input$WinePrice[1],
                                price < input$WinePrice[2],
                                points > input$WineRating[1],
                                points < input$WineRating[2])
    
    if(nrow(data_React)==0){
      return(NULL)
    }
    data_React
  })
  
  #Observers for filters and inputs
  values1 = reactiveValues(default = 0)
  observeEvent(input$action, {values1$default = input$action}) 
  
  # data table for "data" page
  output$results <- DT::renderDataTable(
    data_reactive(),
    options = list(scrollX = TRUE)
  )
  
  # download button for "data" page
  output$download <- downloadHandler(
    filename = function() {
      "data.csv"
    },
    content = function(con) {
      write.csv(data_reactive(), con)
    }
  )
  
  # wordcloud plot based on input filters
  output$wc <- renderPlot({
    df = dat2 %>% 
      filter(is.null(input$cloudCountry) | country %in% input$cloudCountry,
             is.null(input$cloudVariety) | variety %in% input$cloudVariety,
             is.null(input$cloudGrape)   | Grape %in% input$cloudGrape,
             price > input$WinePrice[1],
             price < input$WinePrice[2],
             points > input$WineRating[1],
             points < input$WineRating[2]
      ) 
      
    
    wordcloud_rep <- repeatable(wordcloud)
    
    v <- getTermMatrix(df$description)
    
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = 10, max.words=40,
                  colors=brewer.pal(8, "Dark2"))
    title(main = 'Unigram Word Cloud', font.main = 4)#, cex.main = 1.5)
  })
  
  # wordmap plot based on input filters
  output$wm <- renderPlotly({
    mapp <- as.data.table(map_data("world"))
    datfinal <- as.data.table(dat)
    datfinal[country == "US", country := "USA"]
    datfinal[country == "England", country:= "UK"]
    mfinal <- merge(mapp,
                datfinal[,.(.N,
                            points = median(points, na.rm = T),
                            price = median(price, na.rm = T)),
                         by = country],
                by.x = "region",
                by.y = 'country',
                all.x = T,
                all.y = F,
                sort = T)

    mfinal <- mfinal[order(mfinal$order),]
    mfinal[is.na(N), N:=0]
    mfinal[,text:=sprintf("%s: %.0f wines <br>Median points: %.0f <br>Median price: %.0f$", region, N, points, price)]

    # colouring worldmap based on median values
    g <- ggplot(mfinal, aes(text = text))+
      geom_polygon(aes(long, lat, group = group, fill = N))+
      coord_equal()+
      scale_fill_gradient(low = '#ffffff', high = "#cc0000", trans = "log", na.value = "#c994c7", 
                          breaks = c(0, 1, 10, 100, 1000, 10000))+
      ggtitle("World Map of Wines")+
      theme_void()
   
  # scatterplot of points vs. price of wine based on user inputs   
  output$winePlot1 = renderPlotly({
    data = dat2%>% 
      filter(is.null(input$cloudCountry) | country %in% input$cloudCountry,
             is.null(input$cloudVariety) | variety %in% input$cloudVariety,
             is.null(input$cloudGrape)   | Grape %in% input$cloudGrape,
             price > input$WinePrice[1],
             price < input$WinePrice[2],
             points > input$WineRating[1],
             points < input$WineRating[2]
      ) 
    length = nrow(data)
    ggplot(data, aes(x = points , y= price, color = country)) + geom_point() + 
      geom_jitter() + 
      ggtitle("Cost versus Rating") +
      xlab("Rating (out of 100)") + ylab("Price ($)") + 
      theme(legend.position="bottom")
    })

    gg <- ggplotly(g)
    gg
  })
}