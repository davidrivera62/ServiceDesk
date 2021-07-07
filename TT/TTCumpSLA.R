tt.cumplimiento.sla <- function(TT,Paleta) {
  
  TT%>%
    ggplot(aes(x=EVALUAR_SLA, y=Perc, fill = SLA_CUMPLE, label=Perc)) +
    geom_bar(position="stack", stat="identity") +
    geom_text(aes(label = paste0(sprintf("%0.1f",round(Perc, digits = 1)), "%")), size = 3, vjust = 0.5, hjust = 0.5,
              position = position_stack(vjust = 0.1),
              check_overlap = FALSE) +
    facet_grid(~mes) +
    scale_fill_brewer(palette = Paleta) +
    xlab('Tipo SLA')+
    ylab('%')+
    guides(fill=guide_legend(title="Estado SLA")) +
    ggtitle("Cumplmiento SLA para TT / mes") +
    theme(plot.title = element_text(hjust = 0.5),
          legend.position="bottom")
  
}