#Homework2 1023311
library(shiny)
library(plotly)
shinyServer(function(input, output) {
  
  
  output$plot <- renderPlotly({
    year = input$year
    mar = read.csv(paste(year, "結婚對數.csv", sep = ""))
    div = read.csv(paste(year, "離婚對數.csv", sep = ""))
    dist = input$dist
    
    for (i in 1:13) {
      if (grepl(dist, mar[i,1]) == TRUE) {
        dist = i
        break
      }
    }
    mar = t(mar[-1])
    div = t(div[-1])
    m = list("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nev", "Dec")
    data = data.frame(mar, div, m)
    if (input$type %in% "Bar") {
      p <- plot_ly(data, x = m, y = mar[,dist], type = 'bar', name = 'Married') %>%
        add_trace(y = ~div[,dist], name = 'Divorce')%>%
        layout(title = "Number of Couples Married/Divorce by Months", xaxis = list(title = "Months"), yaxis = list(title = "Number of Couples"), barmode = 'group')
      p
    } else if (input$type %in% "Line") {
      p <- plot_ly(data, x = ~m, y = mar[,dist], name = 'Married', type = 'scatter', mode = 'lines+markers') %>%
        add_trace(y = div[,dist], name = "Divorce", mode = 'lines+markers') %>%
        layout(title = "Number of Couples Married/Divorce by Months", xaxis = list(title = "Months"), yaxis = list(title = "Number of Couples"))
      p
    } else {
      p <- plot_ly() %>%
        add_pie(data, labels = ~m, values = mar[,dist],
                name = "Married", domain = list(x = c(0, 0.4), y = c(0, 1))) %>%
        add_pie(data, labels = ~m, values = div[,dist],
                name = "Divorce", domain = list(x = c(0.6, 1), y = c(0, 1))) %>%
        layout(title = "Number of Couples Married/Divorce by Months", showlegend = F,
               xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
               yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
      p
    }
  })  
})
