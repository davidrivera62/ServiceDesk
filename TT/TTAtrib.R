tt.atribucion <- function(TT,Paleta){
  
  TT %>%
    ggplot(aes(x = reorder(SERVICIO_EMPRESARIAL, Total), 
               y = Total,
               fill = RESPONSABLE,
               label = Total)) +
    geom_bar(position = "stack", stat = "identity")+
    scale_fill_brewer(palette = Paleta)+
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold',
              check_overlap = TRUE) +
    xlab('Servicio Afectado') +
    ylab('Cantidad TT') +
    facet_wrap(~IMPACTO) +
    coord_flip() +
    theme(legend.position="bottom") +
    ggtitle("Servicio, Impacto y Responsables") +
    theme(plot.title = element_text(hjust = 0.5))
  
}