#' Import the raw data file  and infer the replicates and the ct range.
#'
#' @param file the text file that exported from sds software
#'
#' @importFrom magrittr %>%
#'
#' @return a list containing a wide form and a long form dataframe
#' @export
#'
#' @examples
#'
import_data <- function(file) {

  data_raw <-  read.csv(file = file, header = TRUE, sep = "\t", skip = 10, stringsAsFactors = FALSE)

  data_long <- data_raw %>%
    dplyr::filter(Reporter == "SYBR") %>%
    janitor::clean_names() %>%
    dplyr::select(well, sample_name, detector_name , ct) %>%
    dplyr::mutate_at(c("well", "ct"), as.numeric) %>%
    dplyr::group_by(sample_name, detector_name) %>%
    dplyr::mutate(replicate = dplyr::row_number(),
                  diff_ct = max(ct)-min(ct)) %>%
    dplyr::mutate(replicate = as.character(replicate))

  data_wide <- data_long %>%
    tidyr::pivot_wider(
      id_cols = c("sample_name", "replicate"),
      names_from = detector_name,
      values_from = ct)


  return(list(long = data_long, wide = data_wide))

}
