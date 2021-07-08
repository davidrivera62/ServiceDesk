## app.R ##
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(scales)
library(DT)
theme_set(theme_classic())

## Scripts datos OC Ambientes

source("OC/OC.R")
source("OC/plotocanalista.R")
source('OC/plottiempopromedio.R')
source('OC/plotoccategoria.R')
source('OC/plotcumplimientoans.R')
source('OC/plotSerieOC.R')
#source('OC/ocfiltrada.R')
#source('OC/CumpANS.R')
source('OC/OCCumpSLA.R')
source('OC/plotcodcierre.R')

## Scripts datos TT Ambientes

source("TT/TT.R")
source('TT/TTClasif.R')
source('TT/TTAnalista.R')
source('TT/TTServicio.R')
source('TT/TTCategoria.R')
source('TT/TTIndisp.R')
source('TT/TTAtrib.R')
source('TT/TTCumplSLA.R')
source('TT/TTSerie.R')
source('TT/TTCumpSLA.R')

## Scripts datos OC DevOps
source('DevOps/OC/DevOps_OC.R')

## Scripts datos TT DevOps
source('DevOps/TT/DevOps_TT.R')
source('DevOps/TT/DevOps_TTClasif.R')
source('DevOps/TT/DevOps_TTIndisp.R')

ui <- dashboardPage(
  dashboardHeader(title = "C&R Mnt Dash"),
  dashboardSidebar(
    dateRangeInput("dateRange",
                   label = "Date range input: yyyy-mm-dd",
                   start = Sys.Date() - 7,
                   end = Sys.Date() + 1),
    sidebarMenu(
      menuItem("OC Op Ambientes", icon = icon('buffer'),
               uiOutput("EstadoOClist"),
               uiOutput("OperacionOClist"),
               menuSubItem('Tablero Indicadores',tabName = 'indicators',icon = icon('dashboard')),
               menuSubItem('Tablero Gráficas',tabName = 'ocamb',icon = icon('bar-chart-o')),
               menuSubItem('Tabla Valores',tabName = 'tablaoc',icon = icon('table'))),
      menuItem('TT Op Ambientes',icon = icon('buffer'),
               uiOutput('EstadoTTlist'),
               uiOutput('OperacionTTlist'),
               uiOutput('OrigenTTlist'),
               menuSubItem('Tablero Indicadores',tabName = 'ttindamb',icon = icon('dashboard')),
               menuSubItem('Tablero Gráficas',tabName = 'ttgrap', icon = icon('bar-chart-o')),
               menuSubItem('Tabla Valores',tabName = 'tttabl',icon = icon('table'))),
      menuItem('OC DevOps',icon = icon('buffer'),
               uiOutput("EstadoDevOpsOClist"),
               menuSubItem('Tablero Indicadores',tabName = 'DevOpsindicators',icon = icon('dashboard')),
               menuSubItem('Tablero Gráficas',tabName = 'DevOpsocgrap', icon = icon('bar-chart-o')),
               menuSubItem('Tabla Valores',tabName = 'DevOpsoctabl',icon = icon('table'))),
      menuItem('TT DevOps',icon = icon('buffer'),
               uiOutput('EstadoDevOpsTTlist'),
               uiOutput('OrigenDevOpsTTlist'),
               menuSubItem('Tablero Indicadores',tabName = 'DevOpsttind',icon = icon('dashboard')),
               menuSubItem('Tablero Gráficas',tabName = 'DevOpsttgrap', icon = icon('bar-chart-o')),
               menuSubItem('Tabla Valores',tabName = 'DevOpstttabl',icon = icon('table')))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "indicators",
              fluidRow(
                box(plotOutput('OC_SLA_Comp')),
                box(column(12,
                           includeHTML("SLA_OC.html")))
              )),
      tabItem(tabName = "ocamb",
              fluidRow(
                box(plotOutput('OC_Analista')),
                box(plotOutput('Tiempo_Promedio')),
                box(plotOutput('OC_Categoria')),
                box(plotOutput('Cumplimiento_ANS')),
                box(plotOutput('CodigoCierre')),
                box(plotOutput('SerieOC'))
                              )),
      tabItem(tabName = 'tablaoc',
              fluidRow(
                column(12,
                       DTOutput('tablaoc'))
              )),
      tabItem(tabName = 'ttindamb',
              fluidRow(
                box(plotOutput('TT_SLA_Comp')),
                box(column(12,
                           includeHTML("SLA_TT.html")))
              )),
      tabItem(tabName = 'ttgrap',
              fluidRow(box(plotOutput('ttclasif')),
                       box(plotOutput('ttanalista')),
                       box(plotOutput('ttservicio')),
                       box(plotOutput('ttcategoria')),
                       box(plotOutput('ttindisp')),
                       box(plotOutput('ttatrib')),
                       box(plotOutput('ttcumplsla')),
                       box(plotOutput('ttserie')))),
      tabItem(tabName = 'tttabl',
              fluidRow(
                column(12,
                       DTOutput('tablatt'))
              )),
      tabItem(tabName = 'DevOpsindicators',
              fluidRow(
                box(plotOutput('DevOps_OC_SLA_Comp')),
                box(column(12,
                           includeHTML("DevOps/DevOps_SLA_OC.html"))))),
      tabItem(tabName = 'DevOpsocgrap',
              fluidRow(box(plotOutput('DevOps_OC_Analista')),
                       box(plotOutput('DevOps_Tiempo_Promedio')),
                       box(plotOutput('DevOps_OC_Categoria')),
                       box(plotOutput('DevOps_Cumplimiento_ANS')),
                       box(plotOutput('DevOps_SerieOC')))),
      tabItem(tabName = 'DevOpsoctabl',
              fluidRow(
                column(12,
                       DTOutput('DevOps_tablaoc'))
              )),
      tabItem(tabName = 'DevOpsttind',
              fluidRow(box(plotOutput('DevOps_TT_SLA_Comp')),
                       box(column(12,
                                  includeHTML("DevOps/DevOps_SLA_TT.html"))))),
      tabItem(tabName = 'DevOpsttgrap',
              fluidRow(box(plotOutput('DevOps_ttclasif')),
                       box(plotOutput('DevOps_ttanalista')),
                       box(plotOutput('DevOps_ttservicio')),
                       box(plotOutput('DevOps_ttindisp')),
                       box(plotOutput('DevOps_ttatrib')),
                       box(plotOutput('DevOps_ttcumplsla')),
                       box(plotOutput('DevOps_ttserie')))),
      tabItem(tabName = 'DevOpstttabl',
              fluidRow(column(12,
                              DTOutput('DevOps_tablatt'))))
    )
  )
)

server <- function(input, output) { 
  
  ## Manejo datos OC Ambientes ###
  
  OC_data <- OC() %>%
    filter(CATEGORIA_OC!='Delivery.Entrega de Plataforma/Aplicación a Operaciones' | 
             is.na(CATEGORIA_OC)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'David Rivera' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Jaime Gomez' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Yonny Escobar' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA))
  
  colnames(OC_data)[colnames(OC_data) == 'SLA_EVALUADO'] <- 'EVALUAR_SLA'
  colnames(OC_data)[colnames(OC_data) == 'OPERACION'] <- 'NEGOCIO'
    
  #OC_data <- mutate(OC_data, OPERACION =ifelse(grepl("emilla|WL12",OC_data$CATEGORIA_OC), "Movil","Fijo"))
  
  output$EstadoOClist <- renderUI({
    
    EstadoOClist <- sort(unique(as.vector(OC_data$ESTADO_TAREA)), decreasing = FALSE)
    EstadoOClist <- append(EstadoOClist, "All", after = 0)
    selectizeInput("EstadoOCchoose","Estado OC",EstadoOClist)
    
  })
  
  output$OperacionOClist <- renderUI({
    
    OperacionOClist <- sort(unique(as.vector(OC_data$NEGOCIO)), decreasing = FALSE)
    OperacionOClist <- append(OperacionOClist, "All", after = 0)
    selectizeInput("OperacionOCchoose","Operacion",OperacionOClist)
    
  })
  
  OC_Analista <- reactive({
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(ANALISTA_RESPONSANBLE_CIERRE_TAREA,NUM_OC,ESTADO_TAREA) %>%
      group_by(ANALISTA_RESPONSANBLE_CIERRE_TAREA,ESTADO_TAREA) %>%
      summarise(Total = length(!is.na(NUM_OC)), .groups = 'drop')
    
  })
  
  
  output$OC_Analista <- renderPlot({
    
    plot.oc.analista(OC_Analista(),"Blues")
    
  })
  
  OC_Promedio <- reactive({
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(CATEGORIA_OC,DIFERENCIA_MINUTOS_CERRADO_TAREA,ESTADO_TAREA)%>%
      filter(CATEGORIA_OC!='Delivery.Entrega de Plataforma/Aplicación a Operaciones' | 
               is.na(CATEGORIA_OC))%>%
      group_by(CATEGORIA_OC,ESTADO_TAREA) %>%
      summarise(Media = mean(DIFERENCIA_MINUTOS_CERRADO_TAREA,na.rm = TRUE)/60,.groups = 'drop')
    
  })
  
  output$Tiempo_Promedio <- renderPlot({
    
    plot.tiempo.promedio(OC_Promedio(),"Blues")
    
  })
  
  OC_dataCategoria <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(CATEGORIA_OC,NUM_OC,ESTADO_TAREA) %>%
      group_by(CATEGORIA_OC,ESTADO_TAREA) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$OC_Categoria <- renderPlot({
    
    plot.oc.categoria(OC_dataCategoria(),"Blues")
    
  })
  
  OC_ANS <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      filter(ESTADO_TAREA == 'COMP') %>%
      filter(EVALUAR_SLA !="No Aplica"|is.na(EVALUAR_SLA)) %>%
      select(SLA_ESTADO,CATEGORIA_OC,NUM_OC,ESTADO_TAREA) %>% 
      group_by(CATEGORIA_OC,SLA_ESTADO,ESTADO_TAREA) %>% 
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$Cumplimiento_ANS <- renderPlot({
    
    plot.cumplimiento.ans(OC_ANS(),"Blues")
    
  })
  
  OC_CodigoCierre <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(NUM_OC,CATEGORIA_OC,CODIGO_CIERRE) %>%
      group_by(CATEGORIA_OC,CODIGO_CIERRE) %>%
      summarise(Total = length(!is.na(NUM_OC)), .groups = 'drop')
    
  })
  
  output$CodigoCierre <- renderPlot({
    
    plot.codigocierre(OC_CodigoCierre(),"Blues")
    
  })
  
  OC_Serie <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(FECHA_CIERRE_TAREA, NUM_OC) %>%
      group_by(day=floor_date(as_datetime(FECHA_CIERRE_TAREA), "day")) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$SerieOC <- renderPlot({
    
    plot.SerieOC(OC_Serie(),"steelblue1")
  })
  
  OC_filtrada <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(NUM_OC, 
             ANALISTA_RESPONSANBLE_CIERRE_TAREA,
             ESTADO_TAREA,
             CATEGORIA_OC,
             FECHA_INICIO_TAREA,
             DIFERENCIA_MINUTOS_CERRADO_TAREA) %>%
      rename(OC = NUM_OC,
             Analista = ANALISTA_RESPONSANBLE_CIERRE_TAREA,
             Estado = ESTADO_TAREA,
             Categoria = CATEGORIA_OC,
             Fecha = FECHA_INICIO_TAREA,
             Tiempo = DIFERENCIA_MINUTOS_CERRADO_TAREA)
    
  })
  
  output$tablaoc <- renderDT(filter='top', 
                             OC_filtrada(),
                             options = list(scrollX = TRUE))
  
  OC_SLA_Comp_data <- reactive({
    
    req(input$EstadoOCchoose)
    req(input$OperacionOCchoose)
    
    if (input$EstadoOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoOCchoose)
    }
    
    if (input$OperacionOCchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionOCchoose)
    }
    
    OC_data %>%
      #filter_(filt2) %>%
      filter(between(as.Date(FECHA_CIERRE_TAREA,"%Y-%m-%d"),
                     floor_date(today(), unit = "month") %m-% months(3), 
                     today()+1)) %>%
      filter(ESTADO_TAREA == 'COMP') %>%
      filter(EVALUAR_SLA !="No Aplica"|is.na(EVALUAR_SLA)) %>%
      group_by(mes=floor_date(as_datetime(FECHA_CIERRE_TAREA), "month")) %>%
      select(NUM_OC, EVALUAR_SLA, SLA_ESTADO, mes) %>%
      group_by(mes, EVALUAR_SLA, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop') %>%
      group_by(mes,EVALUAR_SLA) %>%
      mutate(TotalSLA= sum(Total)) %>%
      summarise(SLA_ESTADO,Perc = Total/TotalSLA*100, .groups = 'drop')
    
    
    
  })
  
  output$OC_SLA_Comp <- renderPlot({
    
    oc.cumplimiento.sla(OC_SLA_Comp_data(),"Blues")
    
  })
  
  
  ### Manejo Datos TT ###
  
  TT_data <- TT() %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'David Rivera'| is.na(ANALISTA_RESPONSABLE_CIERRE) ) %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'Jaime Gomez'| is.na(ANALISTA_RESPONSABLE_CIERRE) ) %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'Yonny Escobar'| is.na(ANALISTA_RESPONSABLE_CIERRE) )
  
  colnames(TT_data)[colnames(TT_data) == 'SLA_EVALUADO'] <- 'EVALUAR_SLA'
  colnames(TT_data)[colnames(TT_data) == 'OPERACION'] <- 'NEGOCIO'
  
  output$EstadoTTlist <- renderUI({
    
    EstadoTTlist <- sort(unique(as.vector(TT_data$ESTADO_TICKET)), decreasing = FALSE)
    EstadoTTlist <- append(EstadoTTlist, "All", after = 0)
    selectizeInput("EstadoTTchoose","Estado TT",EstadoTTlist)
    
  })
  
  output$OperacionTTlist <- renderUI({
    
    OperacionTTlist <- sort(unique(as.vector(TT_data$NEGOCIO)), decreasing = FALSE)
    OperacionTTlist <- append(OperacionTTlist, "All", after = 0)
    selectizeInput("OperacionTTchoose","Operación",OperacionTTlist)
    
  })
  
  output$OrigenTTlist <- renderUI({
    
    OrigenTTlist <- sort(unique(as.vector(TT_data$ORIGEN_ESCALAMIENTO)), decreasing = FALSE)
    OrigenTTlist <- append(OrigenTTlist, "All", after = 0)
    selectizeInput("OrigenTTchoose","Origen TT",OrigenTTlist)
    
  })
  
  TT_Clas <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, ESTADO_TICKET, NEGOCIO, ORIGEN_ESCALAMIENTO) %>%
      group_by(ESTADO_TICKET, NEGOCIO, ORIGEN_ESCALAMIENTO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttclasif <- renderPlot({
    
    tt.clasificacion(TT_Clas())
    
  })
  
  TT_Analista <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, ANALISTA_RESPONSABLE_CIERRE, ESTADO_TICKET, NEGOCIO, ORIGEN_ESCALAMIENTO) %>%
      group_by(ANALISTA_RESPONSABLE_CIERRE, ESTADO_TICKET) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttanalista <- renderPlot({
    tt.analista(TT_Analista(),"Blues")
  })
  
  TT_Servicio <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL, ESTADO_TICKET, NEGOCIO, ORIGEN_ESCALAMIENTO) %>%
      group_by(SERVICIO_EMPRESARIAL, ESTADO_TICKET) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttservicio <- renderPlot({
    
    tt.servicio(TT_Servicio(),"Blues")
    
  })
  
  TT_Categoria <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, AREA_INCIDENTE, ESTADO_TICKET, NEGOCIO, ORIGEN_ESCALAMIENTO) %>%
      group_by(AREA_INCIDENTE, ESTADO_TICKET) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttcategoria <- renderPlot({
    
    tt.categoria(TT_Categoria())
    
  })
  
  TT_Indisp <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,DIFERENCIA_MINUTOS_APERTURA_CIERRE, QUIEN, QUE_CAUSO,ATRIBUCION) %>%
      mutate(INDISPONIBILIDAD =ifelse(grepl("indisponibilidad|Indisponibilidad|Fallo",QUE_CAUSO), "I","")) %>%
      filter(INDISPONIBILIDAD == "I"| is.na(INDISPONIBILIDAD)) %>%
      group_by(SERVICIO_EMPRESARIAL,ATRIBUCION) %>%
      summarise(Indisponibilidad=sum(DIFERENCIA_MINUTOS_APERTURA_CIERRE)/60,.groups = 'drop')
    
  })
  
  output$ttindisp <- renderPlot({
    
    tt.indisponibilidad(TT_Indisp())
    
  })
  
  
  TT_Atrib <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,DIFERENCIA_MINUTOS_APERTURA_CIERRE, IMPACTO, QUIEN, QUE_CAUSO,ATRIBUCION) %>%
      mutate(INDISPONIBILIDAD =ifelse(grepl("indisponibilidad|Indisponibilidad|Fallo",QUE_CAUSO), "I","")) %>%
      group_by(SERVICIO_EMPRESARIAL, IMPACTO, ATRIBUCION) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttatrib <- renderPlot({
    
    tt.atribucion(TT_Atrib(),"Blues")
    
  })
  
  TT_filtrada <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET,
             ESTADO_TICKET,
             ANALISTA_RESPONSABLE_CIERRE,
             IMPACTO,
             SERVICIO_EMPRESARIAL,
             AREA_INCIDENTE,
             FECHA_INICIO_TICKET,
             DIFERENCIA_MINUTOS_APERTURA_CIERRE,
             QUIEN,
             QUE_CAUSO) %>%
      rename(TT = NUM_TICKET,
             Estado = ESTADO_TICKET,
             Analista = ANALISTA_RESPONSABLE_CIERRE,
             Impacto = IMPACTO,
             Aplicacion = SERVICIO_EMPRESARIAL,
             Catergoria = AREA_INCIDENTE,
             Fecha = FECHA_INICIO_TICKET,
             Tiempo = DIFERENCIA_MINUTOS_APERTURA_CIERRE,
             Resonsable = QUIEN,
             Causo = QUE_CAUSO)
    
  })
  
  output$tablatt <- renderDT(filter='top', 
                             TT_filtrada(),
                             options = list(scrollX = TRUE))
  
  TT_CumpSLA <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,IMPACTO, DIFERENCIA_MINUTOS_APERTURA_CIERRE,SLA_ESTADO) %>%
      filter(IMPACTO != "") %>%
      group_by(SERVICIO_EMPRESARIAL, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$ttcumplsla <- renderPlot({
    
    tt.cumpl.sla(TT_CumpSLA(),"Blues")
    
  })
  
  TT_Serie_Data <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      filter_(filt1) %>%
      filter_(filt2) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(FECHA_CIERRE_TICKET, NUM_TICKET) %>%
      group_by(day=floor_date(as_datetime(FECHA_CIERRE_TICKET), "day")) %>%
      summarise(Total = length(!is.na(NUM_TICKET)),.groups = 'drop')
    
  })
  
  output$ttserie <- renderPlot({
    
    tt.serie(TT_Serie_Data(),"steelblue1")
    
  })
  
  TT_SLA_Comp_data <- reactive({
    
    req(input$EstadoTTchoose)
    req(input$OperacionTTchoose)
    req(input$OrigenTTchoose)
    
    if (input$EstadoTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoTTchoose)
    }
    
    if (input$OperacionTTchoose =='All') {
      filt2 <- quote(NEGOCIO != "@?><")
    } else {
      filt2 <- quote(NEGOCIO == input$OperacionTTchoose)
    }
    
    if (input$OrigenTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenTTchoose)
    }
    
    TT_data %>%
      #filter_(filt1) %>%
      #filter_(filt2) %>%
      #filter_(filt3) %>%
      filter(between(as.Date(FECHA_CIERRE_TICKET,"%Y-%m-%d"),
                     floor_date(today(), unit = "month") %m-% months(3), 
                     today()+1)) %>%
      select(NUM_TICKET, FECHA_CIERRE_TICKET, ESTADO_TICKET, SERVICIO_EMPRESARIAL,IMPACTO, 
             DIFERENCIA_MINUTOS_APERTURA_CIERRE, QUIEN,EVALUAR_SLA,QUIEN,SLA_ESTADO,ATRIBUCION) %>%
      #filter(ESTADO_TICKET == "Cerrado-Resuelto" | is.na(ESTADO_TICKET)) %>%
      filter(IMPACTO != ""|is.na(IMPACTO)) %>%
      filter(ATRIBUCION == "Operación"| is.na(ATRIBUCION) | ATRIBUCION == "") %>%
      filter(EVALUAR_SLA != "No Identificado"|is.na(EVALUAR_SLA)) %>%
      group_by(mes=floor_date(as_datetime(FECHA_CIERRE_TICKET), "month")) %>%
      select(NUM_TICKET, EVALUAR_SLA, SLA_ESTADO, mes) %>%
      group_by(mes, EVALUAR_SLA, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)),.groups = 'drop') %>%
      group_by(mes,EVALUAR_SLA) %>%
      mutate(TotalSLA= sum(Total)) %>%
      summarise(SLA_ESTADO,Perc = Total/TotalSLA*100, .groups = 'drop')
    
  })
  
  output$TT_SLA_Comp <- renderPlot({
    
    tt.cumplimiento.sla(TT_SLA_Comp_data(),"Blues")
    
  })
  
  ## Manejo datos OC DevOps ###
  
  DevOps_OC_data <- DevOps_OC() %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'David Rivera' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Jaime Gomez' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Yonny Escobar' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(CATEGORIA_OC!='Delivery.Entrega de Plataforma/Aplicación a Operaciones'| is.na(CATEGORIA_OC))
  
  colnames(DevOps_OC_data)[colnames(DevOps_OC_data) == 'SLA_EVALUADO'] <- 'EVALUAR_SLA'
  
  output$EstadoDevOpsOClist <- renderUI({
    
    EstadoDevOpsOClist <- sort(unique(as.vector(DevOps_OC_data$ESTADO_TAREA)), decreasing = FALSE)
    EstadoDevOpsOClist <- append(EstadoDevOpsOClist, "All", after = 0)
    selectizeInput("EstadoDevOpsOCchoose","Estado OC DevOps",EstadoDevOpsOClist)
    
  })
  
  DevOPS_OC_Analista <- reactive({
    req(input$EstadoDevOpsOCchoose)
    
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(ANALISTA_RESPONSANBLE_CIERRE_TAREA,NUM_OC,ESTADO_TAREA) %>%
      group_by(ANALISTA_RESPONSANBLE_CIERRE_TAREA,ESTADO_TAREA) %>%
      summarise(Total = length(!is.na(NUM_OC)), .groups = 'drop')
    
  })
  
  
  output$DevOps_OC_Analista <- renderPlot({
    
    plot.oc.analista(DevOPS_OC_Analista(),"PuRd")
    
  })
  
  DevOPS_OC_Promedio <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(CATEGORIA_OC,DIFERENCIA_MINUTOS_CERRADO_TAREA,ESTADO_TAREA)%>%
      filter(CATEGORIA_OC!='Delivery.Entrega de Plataforma/Aplicación a Operaciones' | 
               is.na(CATEGORIA_OC))%>%
      group_by(CATEGORIA_OC,ESTADO_TAREA) %>%
      summarise(Media = mean(DIFERENCIA_MINUTOS_CERRADO_TAREA,na.rm = TRUE)/60,.groups = 'drop')
    
  })
  
  output$DevOps_Tiempo_Promedio <- renderPlot({
    
    plot.tiempo.promedio(DevOPS_OC_Promedio(),"PuRd")
    
  })
  
  DevOps_OC_dataCategoria <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(CATEGORIA_OC,NUM_OC,ESTADO_TAREA) %>%
      group_by(CATEGORIA_OC,ESTADO_TAREA) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$DevOps_OC_Categoria <- renderPlot({
    
    plot.oc.categoria(DevOps_OC_dataCategoria(),"PuRd")
    
  })
  
  DevOps_OC_ANS <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      filter(ESTADO_TAREA == 'COMP') %>%
      filter(EVALUAR_SLA !="No Aplica"|is.na(EVALUAR_SLA)) %>%
      select(SLA_ESTADO,CATEGORIA_OC,NUM_OC,ESTADO_TAREA) %>% 
      group_by(CATEGORIA_OC,SLA_ESTADO,ESTADO_TAREA) %>% 
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$DevOps_Cumplimiento_ANS <- renderPlot({
    
    plot.cumplimiento.ans(DevOps_OC_ANS(),"PuRd")
    
  })
  
  DevOps_OC_Serie <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(FECHA_CIERRE_TAREA, NUM_OC) %>%
      group_by(day=floor_date(as_datetime(FECHA_CIERRE_TAREA), "day")) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop')
    
  })
  
  output$DevOps_SerieOC <- renderPlot({
    
    plot.SerieOC(DevOps_OC_Serie(),"deeppink")
    
  })
  
  DevOps_OC_filtrada <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    DevOps_OC_data %>%
      filter_(filt1) %>%
      filter(FECHA_CIERRE_TAREA > input$dateRange[1] & FECHA_CIERRE_TAREA < input$dateRange[2]) %>%
      select(NUM_OC, 
             ANALISTA_RESPONSANBLE_CIERRE_TAREA,
             ESTADO_TAREA,
             CATEGORIA_OC,
             FECHA_INICIO_TAREA,
             DIFERENCIA_MINUTOS_CERRADO_TAREA) %>%
      rename(OC = NUM_OC,
             Analista = ANALISTA_RESPONSANBLE_CIERRE_TAREA,
             Estado = ESTADO_TAREA,
             Categoria = CATEGORIA_OC,
             Fecha = FECHA_INICIO_TAREA,
             Tiempo = DIFERENCIA_MINUTOS_CERRADO_TAREA)
    
  })
  
  output$DevOps_tablaoc <- renderDT(filter='top', 
                                    DevOps_OC_filtrada(),
                                    options = list(scrollX = TRUE))
  
  DevOps_OC_SLA_Comp_data <- reactive({
    
    req(input$EstadoDevOpsOCchoose)
    
    if (input$EstadoDevOpsOCchoose =='All') {
      filt1 <- quote(ESTADO_TAREA != "@?><")
    } else {
      filt1 <- quote(ESTADO_TAREA == input$EstadoDevOpsOCchoose)
    }
    
    DevOps_OC_data %>%
      #filter_(filt1) %>%
      filter(between(as.Date(FECHA_CIERRE_TAREA,"%Y-%m-%d"),
                     floor_date(today(), unit = "month") %m-% months(3), 
                     today()+1)) %>%
      filter(ESTADO_TAREA == 'COMP') %>%
      filter(EVALUAR_SLA !="No Aplica"|is.na(EVALUAR_SLA)) %>%
      group_by(mes=floor_date(as_datetime(FECHA_CIERRE_TAREA), "month")) %>%
      select(NUM_OC, EVALUAR_SLA, SLA_ESTADO, mes) %>%
      group_by(mes, EVALUAR_SLA, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_OC)),.groups = 'drop') %>%
      group_by(mes,EVALUAR_SLA) %>%
      mutate(TotalSLA= sum(Total)) %>%
      summarise(SLA_ESTADO,Perc = Total/TotalSLA*100, .groups = 'drop')
    
  })
  
  output$DevOps_OC_SLA_Comp <- renderPlot({
    
    oc.cumplimiento.sla(DevOps_OC_SLA_Comp_data(),"PuRd")
    
  })
  
  ## Manejo datos TT DevOps ###
  
  DevOps_TT <- DevOps_TT() %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'David Rivera'| is.na(ANALISTA_RESPONSABLE_CIERRE) ) %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'Jaime Gomez'| is.na(ANALISTA_RESPONSABLE_CIERRE) ) %>%
    filter(ANALISTA_RESPONSABLE_CIERRE != 'Yonny Escobar'| is.na(ANALISTA_RESPONSABLE_CIERRE) ) %>%
    mutate(ORIGEN_ESCALAMIENTO = ifelse(grepl("alarma",DESCRIPCION_TICKET),"Monitoreo","Area Cliente"))
  
  colnames(DevOps_TT)[colnames(DevOps_TT) == 'SLA_EVALUADO'] <- 'EVALUAR_SLA'

  
  output$EstadoDevOpsTTlist <- renderUI({
    
    EstadoDevOpsTTlist <- sort(unique(as.vector(DevOps_TT$ESTADO_TICKET)), decreasing = FALSE)
    EstadoDevOpsTTlist <- append(EstadoDevOpsTTlist, "All", after = 0)
    selectizeInput("EstadoDevOpsTTchoose","Estado TT",EstadoDevOpsTTlist)
    
  })
  
  
  output$OrigenDevOpsTTlist <- renderUI({
    
    OrigenDevOpsTTlist <- sort(unique(as.vector(DevOps_TT$ORIGEN_ESCALAMIENTO)), decreasing = FALSE)
    OrigenDevOpsTTlist <- append(OrigenDevOpsTTlist, "All", after = 0)
    selectizeInput("OrigenDevOpsTTchoose","Origen TT",OrigenDevOpsTTlist)
    
  })
  
  DevOps_TT_Clas <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, ESTADO_TICKET, ORIGEN_ESCALAMIENTO) %>%
      group_by(ESTADO_TICKET, ORIGEN_ESCALAMIENTO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$DevOps_ttclasif <- renderPlot({
    
    devops.tt.clasificacion(DevOps_TT_Clas())
    
  })
  
  DevOps_TT_Analista <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, ANALISTA_RESPONSABLE_CIERRE, ESTADO_TICKET, ORIGEN_ESCALAMIENTO) %>%
      group_by(ANALISTA_RESPONSABLE_CIERRE, ESTADO_TICKET) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$DevOps_ttanalista <- renderPlot({
    
    tt.analista(DevOps_TT_Analista(),"PuRd")
    
  })
  
  DevOps_TT_Servicio <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL, ESTADO_TICKET, ORIGEN_ESCALAMIENTO) %>%
      group_by(SERVICIO_EMPRESARIAL, ESTADO_TICKET) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$DevOps_ttservicio <- renderPlot({
    
    tt.servicio(DevOps_TT_Servicio(),"PuRd")
    
  })
  
  DevOps_TT_Indisp <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,DIFERENCIA_MINUTOS_APERTURA_CIERRE, QUIEN, QUE_CAUSO,ATRIBUCION) %>%
      mutate(INDISPONIBILIDAD =ifelse(grepl("indisponibilidad|Indisponibilidad|Fallo",QUE_CAUSO), "Indisponibilidad","")) %>%
      group_by(SERVICIO_EMPRESARIAL,ATRIBUCION,INDISPONIBILIDAD) %>%
      summarise(Indisponibilidad=sum(DIFERENCIA_MINUTOS_APERTURA_CIERRE)/60,.groups = 'drop')
    
  })
  
  output$DevOps_ttindisp <- renderPlot({
    
    devops.tt.indisponibilidad(DevOps_TT_Indisp())
    
  })
  
  DevOps_TT_Atrib <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,DIFERENCIA_MINUTOS_APERTURA_CIERRE, IMPACTO, QUIEN, QUE_CAUSO, ATRIBUCION) %>%
      mutate(INDISPONIBILIDAD =ifelse(grepl("indisponibilidad|Indisponibilidad|Fallo",QUE_CAUSO), "I","")) %>%
      group_by(SERVICIO_EMPRESARIAL, IMPACTO, ATRIBUCION) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$DevOps_ttatrib <- renderPlot({
    
    tt.atribucion(DevOps_TT_Atrib(),"PuRd")
    
  })
  
  DevOps_TT_filtrada <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET,
             ESTADO_TICKET,
             ANALISTA_RESPONSABLE_CIERRE,
             IMPACTO,
             SERVICIO_EMPRESARIAL,
             AREA_INCIDENTE,
             FECHA_INICIO_TICKET,
             DIFERENCIA_MINUTOS_APERTURA_CIERRE,
             QUIEN,
             QUE_CAUSO) %>%
      rename(TT = NUM_TICKET,
             Estado = ESTADO_TICKET,
             Analista = ANALISTA_RESPONSABLE_CIERRE,
             Impacto = IMPACTO,
             Aplicacion = SERVICIO_EMPRESARIAL,
             Catergoria = AREA_INCIDENTE,
             Fecha = FECHA_INICIO_TICKET,
             Tiempo = DIFERENCIA_MINUTOS_APERTURA_CIERRE,
             Resonsable = QUIEN,
             Causo = QUE_CAUSO)
  })
  
  output$DevOps_tablatt <- renderDT(filter='top', 
                                    DevOps_TT_filtrada(),
                                    options = list(scrollX = TRUE))
  
  
  
  DevOps_TT_CumpSLA <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(NUM_TICKET, SERVICIO_EMPRESARIAL,IMPACTO, DIFERENCIA_MINUTOS_APERTURA_CIERRE,SLA_ESTADO) %>%
      filter(IMPACTO != "") %>%
      group_by(SERVICIO_EMPRESARIAL, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)), .groups = 'drop')
    
  })
  
  output$DevOps_ttcumplsla <- renderPlot({
    
    tt.cumpl.sla(DevOps_TT_CumpSLA(),"PuRd")
    
  })
  
  DevOops_TT_Serie_Data <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      filter_(filt1) %>%
      filter_(filt3) %>%
      filter(FECHA_CIERRE_TICKET > input$dateRange[1] & FECHA_CIERRE_TICKET < input$dateRange[2]) %>%
      select(FECHA_CIERRE_TICKET, NUM_TICKET) %>%
      group_by(day=floor_date(as_datetime(FECHA_CIERRE_TICKET), "day")) %>%
      summarise(Total = length(!is.na(NUM_TICKET)),.groups = 'drop')
    
  })
  
  output$DevOps_ttserie <- renderPlot({
    
    tt.serie(DevOops_TT_Serie_Data(),"deeppink")
    
  })
  
  DevOps_TT_SLA_Comp_data <- reactive({
    
    req(input$EstadoDevOpsTTchoose)
    req(input$OrigenDevOpsTTchoose)
    
    if (input$EstadoDevOpsTTchoose =='All') {
      filt1 <- quote(ESTADO_TICKET != "@?><")
    } else {
      filt1 <- quote(ESTADO_TICKET == input$EstadoDevOpsTTchoose)
    }
    
    
    if (input$OrigenDevOpsTTchoose =='All') {
      filt3 <- quote(ORIGEN_ESCALAMIENTO != "@?><")
    } else {
      filt3 <- quote(ORIGEN_ESCALAMIENTO == input$OrigenDevOpsTTchoose)
    }
    
    DevOps_TT %>%
      #filter_(filt1) %>%
      #filter_(filt3) %>%
      filter(between(as.Date(FECHA_CIERRE_TICKET,"%Y-%m-%d"),
                     floor_date(today(), unit = "month") %m-% months(3), 
                     today()+1)) %>%
      select(NUM_TICKET, FECHA_CIERRE_TICKET, ESTADO_TICKET, SERVICIO_EMPRESARIAL,IMPACTO, 
             DIFERENCIA_MINUTOS_APERTURA_CIERRE, QUIEN,EVALUAR_SLA,QUIEN,SLA_ESTADO,ATRIBUCION) %>%
      #filter(ESTADO_TICKET == "Cerrado-Resuelto" | is.na(ESTADO_TICKET)) %>%
      filter(IMPACTO != ""|is.na(IMPACTO)) %>%
      filter(ATRIBUCION == "Operación"| is.na(ATRIBUCION) | ATRIBUCION == "") %>%
      filter(EVALUAR_SLA != "No Identificado"|is.na(EVALUAR_SLA)) %>%
      group_by(mes=floor_date(as_datetime(FECHA_CIERRE_TICKET), "month")) %>%
      select(NUM_TICKET, EVALUAR_SLA, SLA_ESTADO, mes) %>%
      group_by(mes, EVALUAR_SLA, SLA_ESTADO) %>%
      summarise(Total = length(!is.na(NUM_TICKET)),.groups = 'drop') %>%
      group_by(mes,EVALUAR_SLA) %>%
      mutate(TotalSLA= sum(Total)) %>%
      summarise(SLA_ESTADO,Perc = Total/TotalSLA*100, .groups = 'drop')
    
  })
  
  output$DevOps_TT_SLA_Comp <- renderPlot({
    
    tt.cumplimiento.sla(DevOps_TT_SLA_Comp_data(),"PuRd")
    
  })
  
}

shinyApp(ui, server)