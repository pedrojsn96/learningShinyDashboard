library(ggplot2)
library(shiny)
library(shinydashboard)

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
      p <- ggplot(data = dados, aes(x=dados[,varInput()]))
      if(input$grafico1 == "barras"){
        print(
          p + geom_histogram(alpha =.4, fill ="blue", color="black", binwidth=.5) + labs(title=varInput(), x="Numeros", y="Frequencia") 
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
  
  output$tabela1 <- DT::renderDataTable({
    DT::datatable(as.data.frame(table(dados[,varInput()])))
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
  
  
  output$sumario2 <- renderPrint({
    summary(dados[,c(varXInput(),varYInput())])
  })
  
  output$tabela2 <- DT::renderDataTable({
    DT::datatable(as.data.frame(table(dados[,c(varXInput(),varYInput())])))
  })
}