#' Proportion of Reads and Replicates:
#'
#' @description This method assigns taxa to the core
#' if they account for some proportion of the total reads for the sequencing run
#' and if they are present in at least x% of the total number of replicates.
#'
#' In this example, a core taxa must account for 0.02% of the total reads
#' for the entire otu table and be present in at least 50% of sites.
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @param sites the percent of sites the OTU needs to be present in
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
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

prop_reads_and_reps <- function(otu_table, prop_reps = 0.5, prop_reads = 0.02, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-X) %>%
    dplyr::group_by(X) %>%
    # count the number of reads of each OTU across sites
    dplyr::mutate(num_reads = sum(value)) %>%
    dplyr::add_count(X) %>%
    dplyr::ungroup() %>%
    # get total number of reads for every unique OTU
    dplyr::mutate(s = sum(num_reads)/n) %>%
    dplyr::ungroup() %>%
    # remove the rows with no values
    # so we can count the number of sites each OTU is present in
    dplyr::filter(value > 0) %>%
    dplyr::group_by(X) %>%
    dplyr::mutate(
      # sites per OTU
      num_sites = n(),
      # total sites
      N = ncol(otu_table) - 1) %>%
    dplyr::ungroup() %>%
    # this one gives us results
    dplyr::filter(num_sites >= N * prop_reps) %>%
    # this leaves us with nothing...
    dplyr::filter(num_reads >= prop_reads*s) %>%
    dplyr::pull(X)
}
