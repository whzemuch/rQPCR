#' Calculate the relative expression using delta delta ct method
#'
#' @param data a data frame with three columns: sample_name, gene_name, ct
#' @param internal_ctrl GAPDH, ACTIN, etc
#' @param format "long" or "wide"
#'
#' @importFrom magrittr %>%
#' @return a long or wide form data frame
#' @export
#'
#' @examples
#'
Calculate_relative_exp <- function(data_wide, internal_ctrl, format="long") {

    if (is.null(internal_ctrl)) {
      message("You forgot the internal control!")
    }



      df_wide_rq <- data_wide %>%
        dplyr::select(-!!internal_ctrl, !!internal_ctrl) %>%
        dplyr::mutate_if(is.numeric, list(~2^(get(internal_ctrl) - .)))


      df_long_rq <-df_wide_rq %>%
        tidyr::pivot_longer(
                   where(is.numeric),
                   names_to = "detecter_name",
                   values_to = "relativeExp"
                   ) %>%
        dplyr::filter(detecter_name != internal_ctrl)



      if (format=="long") return(df_long_rq) else return(df_wide_rq)



}
