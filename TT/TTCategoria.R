tt.categoria <- function(TT){
  
  TT%>%
    ggplot(aes(x = reorder(AREA_INCIDENTE, Total),
               y = Total,
               fill=ESTADO_TICKET,
               label=Total)) +
    geom_bar(position = "stack", stat = "identity") +
    coord_flip() +
    scale_fill_brewer(palette="Blues") +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold')+
    xlab('Categoria')+
    ylab('Cantidad TT')+
    guides(fill=guide_legend(title="Estado TT")) + 
    theme(legend.position="bottom") +
    ggtitle("TT Categoria") +
    theme(plot.title = element_text(hjust = 0.5))
  
}