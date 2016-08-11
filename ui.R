library(ggplot2)
library(shiny)
library(shinydashboard)

dashboardPage(

  dashboardHeader(title = "Shiny - Pedro"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Variaveis",tabName = "Variaveis", icon= icon("dashboard"),
               collapsible= 
                 radioButtons("qtdVar","Quantidade de Variaveis:",
                              c("Uma" = 1,
                                "Duas"= 2 ), selected = 1))
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
                                                      "Pizza" = "pizza"))),
               conditionalPanel("input.qtdVar == 2",
                               selectInput("variableX","Variavel X:",
                                           choices = colnames(dados)),
                               selectInput("variableY","Variavel Y:",
                                           choices = colnames(dados)),
                               selectInput("grafico2","Graficos:",
                                           choices = c("Barras" = "barras2")))
             ),
             tabBox(width=12,
                    id = "tabset1", height = "250px",
                    tabPanel("Grafico",
                             conditionalPanel("input.qtdVar == 1",
                                              plotOutput("grafico1Out"))),
                    tabPanel("Sumario",
                             conditionalPanel("input.qtdVar == 1",
                                              verbatimTextOutput("sumario1")),
                             conditionalPanel("input.qtdVar == 2",
                                              verbatimTextOutput("sumario2"))),
                    tabPanel("Tabela",
                             conditionalPanel("input.qtdVar == 1",
                                              DT::dataTableOutput("tabela1")),
                             conditionalPanel("input.qtdVar == 2",
                                              DT::dataTableOutput("tabela2")))
             )
             )
    )
  )
)