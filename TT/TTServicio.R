tt.servicio <- function(TT,Paleta){
  
  TT %>%
    ggplot(aes(x = reorder(SERVICIO_EMPRESARIAL, Total),
               y = Total,
               fill=ESTADO_TICKET,
               label=Total)) +
    geom_bar(position = "stack", stat = "identity") +
    coord_flip() +
    scale_fill_brewer(palette=Paleta) +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold')+
    xlab('Servicio Afectado')+
    ylab('Cantidad TT')+
    guides(fill=guide_legend(title="Estado TT")) + 
    theme(legend.position="bottom") +
    ggtitle("Afectacion de Servicios") +
    theme(plot.title = element_text(hjust = 0.5))
  
}