library(ggplot2)
library(shiny)
library(shinydashboard)
library(rsconnect)


dashboardPage(

  dashboardHeader(title = "Shiny - Pedro"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Variaveis",tabName = "Variaveis", icon= icon("dashboard"),
               collapsible= 
                 numericInput("qtdVar", 
                              label = "Quantidade de Variaveis:", value = 1, min = 1,max = 2))
    )
  ),
  dashboardBody(
    fluidRow(
      column(width=12,
             box(
               title = "Variaveis",status="primary",width=12,collapsible = TRUE,
               conditionalPanel("input.qtdVar == 1",
                                selectInput("variable", "Variavel:", 
                                            choices=colnames(dados)),
                                selectInput("grafico1", "Graficos:", 
                                            choices=c("Barras" = "barras",
                                                      "Pizza" = "pizza",
                                                      "Pontos" = "pontos"))),
               conditionalPanel("input.qtdVar == 2",
                               selectInput("variableX","Variavel X:",
                                           choices = colnames(dados)),
                               selectInput("variableY","Variavel Y:",
                                           choices = colnames(dados)),
                               selectInput("grafico2","Graficos:",
                                           choices = c("Pontos" = "pontos")))
             ),
             tabBox(width=12,
                    id = "tabset1",
                    tabPanel("Grafico",
                             conditionalPanel("input.qtdVar == 1",
                                              plotOutput("grafico1Out")),
                             conditionalPanel("input.qtdVar == 2",
                                              plotOutput("grafico2Out")
                                              )),
                    tabPanel("Sumario",
                             conditionalPanel("input.qtdVar == 1",
                                              verbatimTextOutput("sumario1")),
                             conditionalPanel("input.qtdVar == 2",
                                              verbatimTextOutput("sumario2"))),
                    tabPanel("Tabela",
                             radioButtons("escolhaTable","Apresentação",
                                          choices = c("Frequencia" = "freq",
                                                      "Dados Reais" = "reais"),selected = "freq",
                                          inline = TRUE),
                             conditionalPanel("input.qtdVar == 1",
                                              DT::dataTableOutput("tabela1")),
                             conditionalPanel("input.qtdVar == 2",
                                              DT::dataTableOutput("tabela2")))
             )
             )
    )
  )
)