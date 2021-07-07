devops.tt.clasificacion <- function(TT){
  
  TT%>%
    ggplot(aes(fill=ORIGEN_ESCALAMIENTO, y = Total, x= ESTADO_TICKET, label=Total)) +
    geom_bar(position = "stack", stat = "identity")+
    scale_fill_brewer(palette = "PuRd")+
    guides(fill=guide_legend(title="Origen")) +
    geom_text(size = 4, vjust = 0.5, hjust = -0.5,
              position = position_stack(vjust = 0.7),
              fontface='bold',
              check_overlap = TRUE) +
    xlab('Estado TT') +
    ylab('Cantidad TT') +
    coord_flip() +
    theme(legend.position="bottom") +
    ggtitle("Clasificación TT") +
    theme(plot.title = element_text(hjust = 0.5))
  
}