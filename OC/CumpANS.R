Cump_ANS <- function(OC,m){
  
  Cump_ANS <- OC %>%
    filter(as.numeric(format(as.Date(FECHA_CIERRE_TAREA,"%Y-%m-%d"), "%m"))==m) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'David Rivera' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Jaime Gomez' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(ANALISTA_RESPONSANBLE_CIERRE_TAREA != 'Yonny Escobar' | is.na(ANALISTA_RESPONSANBLE_CIERRE_TAREA)) %>%
    filter(CATEGORIA_OC!='Delivery.Entrega de Plataforma/Aplicación a Operaciones' | is.na(CATEGORIA_OC)) %>% 
    filter(ESTADO_TAREA == 'COMP' | ESTADO_TAREA =='CNCL') %>%
    mutate( ANS2 = ifelse(DIFERENCIA_MINUTOS_CERRADO_TAREA<240,'CUMPLE','INCUMPLE')) %>%
    select(NUM_OC, CATEGORIA_OC, ESTADO_TAREA, ANS2) %>%
    group_by(ANS2) %>% 
    summarise(Total = length(!is.na(ANS2))) %>%
    mutate(Perc=Total/sum(Total)*100)
  
  return(Cump_ANS[[3]][1])
  
}