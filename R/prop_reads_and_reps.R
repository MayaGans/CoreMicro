#' Proportion of Reads and Replicates:
#'
#' @description This method assigns taxa to the core if they account for some proportion of the total reads for the sequencing run and if they are present in at least x% of the total number of replicates. In this example, a core taxa must account for 0.01% of the total reads for the entire otu table and be present in at least 50% of sites.
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @param sites the percent of sites the OTU needs to be present in
#' @return the names of OTUs which meet the proportion of reads and replicate criteria
#'
#' @examples
#' prop_reads(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export

prop_reads_and_reps <- function(otu_table, sites = 0.5) {
  otu_table %>%
    tidyr::pivot_longer(-X) %>%
    dplyr::group_by(X) %>%
    dplyr::mutate(row_sum = sum(value)) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(s = sum(unique(row_sum))) %>%
    dplyr::filter(value > 0) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(
      num_sites = n(),
      N = ncol(otu_table) - 1) %>%
    dplyr::filter(num_sites >= N * sites) %>%
    dplyr::pull(X)
}