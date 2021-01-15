#' Title Create an overview of the Ct value of all samples
#'
#' @param data_long  long data frame from the output of import_data function
#' @param ct_diff the threshold for big variation of the replicate wells, the default is 0.5
#'
#'
#' @return a ggplotly object showing in row and column with tooltip(ct, well id, different ct)
#' @export
#'
#' @examples
#'
qview_data <- function(data_long, ct_diff=0.5) {


  data <- dplyr::mutate(data_long, row = LETTERS[ceiling(well/24)],
                              col=(well-1) %% 24 + 1)

  p_ct_qview <- data %>%
    ggplot(aes(x=2, y=ct,
               text = paste('sample name:', sample_name,
                            '<br>detector name:', detector_name,
                            '<br>ct value: ', round(ct,1),
                            '<br>well ID: ', well,
                            '<br>ct range: ', round(diff_ct, 2)))
    ) +
    geom_point(aes(shape=factor(replicate))) +
    facet_grid(row ~ col) +
    labs(title = "Ct value Qview\n\n",
         x="", y="Ct value\n")+
    theme_bw()


  p_ct_qview <- p_ct_qview +
    geom_point(data=subset(data, diff_ct > ct_diff),
               aes(x=2, y=ct, color="red", shape=factor(replicate))) +

        theme( plot.title = element_text(face = "bold",
                                     size = rel(1.2),
                                     hjust = 0.5),
           axis.title = element_text(face = "bold",size = rel(1)),
           axis.text.x = element_blank(),
           strip.text.y = element_text(angle = 0),
           axis.title.y = element_text(margin = margin(t = 0, r = 40, b = 0, l = 0)),
           legend.position = "none" )


  plotly_ct_qview <- plotly::ggplotly(p_ct_qview, tooltip = "text")

  return(plotly_ct_qview)

}


