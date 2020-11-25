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
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#' @param prop_reads percentage of reads
#' @param prop_reps percentage of replicates
#'
#' @return the names of OTUs which meet the proportion of reads and replicate criteria
#'
#' @examples
#' prop_reads_and_reps(arabidopsis)
#'
#' @export

prop_reads_and_reps <- function(otu_table, prop_reps = 0.5, prop_reads = 0.0002, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-.data$X) %>%
    dplyr::group_by(.data$X) %>%
    # count the number of reads of each OTU across sites
    dplyr::mutate(num_reads = sum(.data$value)) %>%
    # number of sites (should be the same number for entire column)
    dplyr::add_count(.data$X) %>%
    dplyr::ungroup() %>%
    # get total number of reads for the entire OTU table
    dplyr::mutate(s = sum(.data$num_reads)/.data$n) %>%
    dplyr::ungroup() %>%
    # remove the rows with no values
    # so we can count the number of sites each OTU is present in
    dplyr::filter(.data$value > 0) %>%
    dplyr::group_by(.data$X) %>%
    dplyr::mutate(
      # sites per OTU
      num_sites = dplyr::n()
    ) %>%
    dplyr::ungroup() %>%
    # this one gives us results
    dplyr::filter(.data$num_sites >= .data$n * prop_reps) %>%
    # this leaves us with nothing...
    dplyr::filter(.data$num_reads >= prop_reads * .data$s) %>%
    dplyr::pull(.data$X) %>%
    unique()
}
