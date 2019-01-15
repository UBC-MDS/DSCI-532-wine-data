function(input, output, session) {
  # Define a reactive expression for the document term matrix
  # terms <- reactive({
  #   # Change when the "update" button is pressed...
  #   input$update
  #   # ...but not for anything else
  #   isolate({
  #     withProgress({
  #       setProgress(message = "Processing corpus...")
  #       # getTermMatrix(input$selection)
  #       dat
  #     })
  #   })
  # })
  
  # Make the wordcloud drawing predictable during a session
  
  
  output$plot <- renderPlot({
    df = dat %>% filter(is.null(input$selection) | variety %in% input$selection)
    v <- getTermMatrix(df$description)
    
    wordcloud_rep <- repeatable(wordcloud)
    
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
    title(main = 'world cloud = unigram', font.main = 3, cex.main = 1.5)
  })
}