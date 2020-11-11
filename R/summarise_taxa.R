#' Calculate the mean, variance and CV of each OTU
#'
#' @param otu_table a dataframe of OTUs
#'  where the first row is the OTU ID and column names refer to sites
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
#' @return a dataframe with the Mean, Variance and CV for each OTU
#'
#' @examples
#' summarise_taxa(arabidopsis)
#'
#' @export

summarise_taxa <- function(otu_table, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-1) %>%
    dplyr::group_by(.data$X) %>%
    dplyr::summarise(Mean = mean(.data$value),
                     Variance = stats::var(.data$value),
                     CV = .data$Variance/.data$Mean)
}
