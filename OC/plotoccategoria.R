plot.oc.categoria <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(fill=ESTADO_TAREA,
               y=Total,
               x=reorder(CATEGORIA_OC, Total),
               label=Total))+
    geom_bar(position = "stack", stat = "identity")+
    scale_fill_brewer(palette = Paleta)+
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold',
              check_overlap = TRUE)+
    xlab('Categoria')+
    ylab('Cantidad OC')+
    guides(fill=guide_legend(title="Estado Tarea")) + 
    theme(legend.position="bottom") +
    coord_flip() + 
    ggtitle("Cantidad de tareas por Categoría") +
    theme(plot.title = element_text(hjust = 0.5))
  
}