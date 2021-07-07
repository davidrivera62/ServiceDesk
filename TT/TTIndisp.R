tt.indisponibilidad <- function(TT){
  
  TT %>%
    ggplot(aes(x = reorder(SERVICIO_EMPRESARIAL, Indisponibilidad),
               y = Indisponibilidad,
               fill=RESPONSABLE,
               label=sprintf("%0.1f",round(Indisponibilidad, digits = 1)))) +
    geom_bar(position = "stack", stat = "identity") +
    coord_flip() +
    scale_fill_brewer(palette="Blues") +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold')+
    xlab('Servicio Afectado')+
    ylab('Horas Indisponibilidad')+
    guides(fill=guide_legend(title="Responsable")) + 
    theme(legend.position="bottom") +
    ggtitle("Horas de Indisponibilidad por Servicio") +
    theme(plot.title = element_text(hjust = 0.5))
  
}