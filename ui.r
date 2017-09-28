#Homework2 1023311
library(shiny)
library(plotly)
shinyUI(fluidPage( 
  titlePanel("桃園市各區結婚離婚登記數統計"), # page title
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Select Year", c("105", "104", "103", "102")),
      selectInput("dist", "Select District", c("桃園", "中壢", "平鎮", "八德", "楊梅", "大溪", "蘆竹", "大園", "龜山", "龍潭", "新屋", "觀音", "復興")),
      radioButtons("type", "Select Type", list("Bar", "Line", "Pie"), inline = T)
    ),
      
    mainPanel(
      plotlyOutput("plot") #output ID
    )
  )
))
