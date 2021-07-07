plot.SerieOC <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(x=as.Date(day),
               y=Total))+
    geom_line(color=Paleta)+
    geom_point(color=Paleta)+
    scale_x_date(date_breaks = "1 day", date_labels = "%D") +
    geom_text(aes(label = Total),
              vjust = "inward", hjust = "inward",
              show.legend = FALSE,
              size=5) +
    xlab('Dia')+
    ylab('Cantidad OC')+
    ggtitle("Cantidad de OC Atendidos por Dia") +
    theme(axis.text.x=element_text(angle=60, hjust=1),
          plot.title = element_text(hjust = 0.5),
          panel.background = element_rect(fill = NA),
          panel.grid.major = element_line(colour = "azure2"))
  
  
  
}