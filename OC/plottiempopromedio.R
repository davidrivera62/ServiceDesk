plot.tiempo.promedio <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(x=reorder(CATEGORIA_OC, Media),
               y=Media,
               fill=ESTADO_TAREA,
               label=sprintf("%0.2f",round(Media, digits = 1))))+
    geom_bar(position = "stack", stat = "identity")+
    scale_fill_brewer(palette = Paleta)+
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.1), 
              fontface='bold',
              check_overlap = FALSE)+
    xlab('Categoria')+
    ylab('Tiempo promedio [H]')+
    guides(fill=guide_legend(title="Estado Tarea")) + 
    theme(legend.position="bottom") +
    coord_flip()+
    ggtitle("Tiempo Promedio Atención OC") +
    theme(plot.title = element_text(hjust = 0.5))
  
}