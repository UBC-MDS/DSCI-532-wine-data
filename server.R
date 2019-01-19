function(input, output, session) {
  
  data_reactive <- reactive({
    data_React <- dat2 %>% filter(is.null(input$cloudCountry) | country %in% input$cloudCountry,
                                is.null(input$cloudVariety) | variety %in% input$cloudVariety)
    
    if(nrow(data_React)==0){
      return(NULL)
    }
    data_React
  })
  
  output$results <- DT::renderDataTable(
    data_reactive(),
    options = list(scrollX = TRUE)
  )
  
  output$download <- downloadHandler(
    filename = function() {
      "data.csv"
    },
    content = function(con) {
      write.csv(data_reactive(), con)
    }
  )

  output$wc <- renderPlot({
    df = dat2 %>% 
      filter(is.null(input$cloudCountry) | country %in% input$cloudCountry,
             is.null(input$cloudVariety) | variety %in% input$cloudVariety
      )
      
    
    wordcloud_rep <- repeatable(wordcloud)
    
    v <- getTermMatrix(df$description)
    
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = 10, max.words=50,
                  colors=brewer.pal(8, "Dark2"))
    title(main = 'unigram world cloud', font.main = 3)#, cex.main = 1.5)
  })
  
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
                sort = F)

    mfinal <- mfinal[order(mfinal$order),]
    mfinal[is.na(N), N:=0]
    mfinal[,text:=sprintf("%s: %.0f wines <br>Median points: %.0f <br>Median price: %.0f$", region, N, points, price)]

    g <- ggplot(mfinal, aes(text = text))+
      geom_polygon(aes(long, lat, group = group, fill = N))+
      coord_equal()+
      scale_fill_gradient(low = '#ffffff', high = "#cc0000", trans = "log", na.value = "#c994c7", 
                          breaks = c(0, 1, 10, 100, 1000, 10000))+
      ggtitle("World map of wines")+
      theme_void()


    gg <- ggplotly(g, tooltip = "text")
    gg
  })
}