plot.cumplimiento.ans <- function(OC,Paleta){
  
  OC %>%
    ggplot(aes(x=reorder(CATEGORIA_OC,Total),
               y=Total,
               fill=ESTADO_TAREA,
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
    facet_wrap(~ANS2, nrow = 2)+
    theme(legend.position="none") +
    coord_flip()+
    ggtitle("Cumplmiento ANS") +
    theme(plot.title = element_text(hjust = 0.5))
  
}