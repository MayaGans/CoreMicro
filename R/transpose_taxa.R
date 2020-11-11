#' If data are arranged where taxa are columns and sites rows
#' we need to transpose the data for downstream analysis
#'
#' @param taxa_table the table to transpose

transpose_taxa <- function(taxa_table) {
  suppressWarnings(
    taxa_table %>%
      tidyr::gather(key = "key", value = "value", 2:ncol(taxa_table)) %>%
      tidyr::spread(key = names(taxa_table)[1], value = "value") %>%
      dplyr::rename("X" = .data$key)
  )
}
