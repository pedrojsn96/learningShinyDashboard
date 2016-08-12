library(ggplot2)
library(shiny)
library(shinydashboard)
library(rsconnect)

## Lendo o Arquivo dados.csv

dados <- read.csv2(file = "data/dados.csv")

server <- function(input, output) {
  
  #Uma variavel 
  
  varInput <- reactive({
    if(input$qtdVar == 1){
      return(input$variable)
    }
  })
  
  #Ordenação crescente
  #reorder_size <- function(x) {
   # factor(x, levels = names(sort(table(x))))
  #}
  
  grafico1Plot <- reactive({
    if(input$qtdVar == 1){
      if(input$grafico1 == "barras"){
        p <- ggplot(data = dados, aes(x=dados[,varInput()]))
        print(
          p + geom_histogram(alpha =.4, fill ="blue", color="black", binwidth=.5) + labs(title=varInput(), x="Numeros", y="Frequencia") 
          )
      }
      if(input$grafico1 == "pizza"){
        pie <- ggplot(dados, aes(x = "", fill = factor(dados[,varInput()]))) +
          geom_bar(width = 1)
        print(
          pie + coord_polar(theta = "y") + xlab("") + ylab("")+labs(title=varInput(), fill="Lengenda")
        )
      }
      if(input$grafico1 == "pontos"){
        pontos <- ggplot(data =  data.frame(table(dados[,varInput()]))) 
        print(
          pontos + geom_point(mapping = aes(x = Var1, y = Freq,colour= Var1),  size=5)
        )
      }
    }
  })
  
  output$grafico1Out <- renderPlot({
    data <- grafico1Plot()
  })
  
  output$sumario1 <- renderPrint({
    summary(dados[,varInput()])
  })
  
  tabela1Out <- reactive({
    if(input$escolhaTable == "reais"){
      DT::datatable(as.data.frame(dados[,varInput()]))
    }else{
      DT::datatable(as.data.frame(table(dados[,varInput()])))  
    }
  })
  
  output$tabela1 <- DT::renderDataTable({
    dataTabela <- tabela1Out()
  })
  
  #Duas variaveis
  
  varXInput <- reactive({
    if(input$qtdVar == 2){
      return(input$variableX)
    }
  })
  
  varYInput <- reactive({
    if(input$qtdVar == 2){
      return(input$variableY)
    }
  })
  
  grafico2Plot <- reactive({
    if(input$qtdVar == 2){
      if(input$grafico2 == "pontos"){
        pontos2 <- ggplot(dados,aes(x = dados[,varXInput()], y = dados[,varYInput()],colour=dados[,varXInput()])) 
        print(
          pontos2 + geom_point(size = 4) + labs(x=varXInput(), y=varYInput())
        )
      }
    }
  })
  
  output$grafico2Out <- renderPlot({
    data2 <- grafico2Plot() 
  })
  
  output$sumario2 <- renderPrint({
    summary(dados[,c(varXInput(),varYInput())])
  })
  
  output$tabela2 <- DT::renderDataTable({
    DT::datatable(as.data.frame(table(dados[,c(varXInput(),varYInput())])))
  })
}