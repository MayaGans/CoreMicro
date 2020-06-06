#' Calculate the mean, variance and CV of each OTU
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @return a dataframe with the Mean, Variance and CV for each OTU
#'
#' @examples
#' summarize_OTUS(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr group_by
#' @importFrom dplyr summarise
#' @importFrom rlang .data
#'
#' @export

summarize_OTUS <- function(otu_table) {
  otu_table %>%
    tidyr::pivot_longer(-1) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(Mean = mean(value), Variance = var(value), CV = Variance/Mean)
}
