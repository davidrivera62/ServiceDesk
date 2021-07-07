plot.oc.analista <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(x = reorder(ANALISTA_RESPONSANBLE_CIERRE_TAREA, Total),
             y = Total,
             fill=ESTADO_TAREA,
             label=Total)) +
    geom_bar(position = "stack", stat = "identity") +
    coord_flip() +
    scale_fill_brewer(palette=Paleta) +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold')+
    xlab('Analista')+
    ylab('Cantidad OC')+
    guides(fill=guide_legend(title="Estado Tarea")) + 
    theme(legend.position="bottom") +
    ggtitle("Atención de tareas") +
    theme(plot.title = element_text(hjust = 0.5))
  
}