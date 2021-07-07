plot.codigocierre <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(x = reorder(CATEGORIA_OC, Total),
               y = Total,
               fill=CODIGO_CIERRE,
               label=Total)) +
    geom_bar(position = "stack", stat = "identity") +
    coord_flip() +
    scale_fill_brewer(palette=Paleta) +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold')+
    xlab('Categoria')+
    ylab('Cantidad OC')+
    guides(fill=guide_legend(title="Codigo de Cierre")) + 
    theme(legend.position="bottom") +
    ggtitle("Estado de tareas al Cierre") +
    theme(plot.title = element_text(hjust = 0.5))
  
}