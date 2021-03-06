#' Proportion of Replicates
#'
#' @description This method assigns taxa to the core
#' if they account for some proportion of the total reads for the sequencing run
#' and if they are present in at least x% of the total number of replicates.
#' In this example, a core taxa must account for 0.01% of the total reads
#' for the entire otu table and be present in at least 50% of sites.
#'
#' @param otu_table a dataframe of OTUs where
#' the first row is the OTU ID and column names refer to sites
#'
#' @param prop_reps some definition
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
#' @return the names of OTUs which meet the proportion of replicate criteria
#'
#' @examples
#' prop_reps(arabidopsis)
#'
#' @export

prop_reps <- function(otu_table, prop_reps = 0.5, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-1) %>%
    dplyr::group_by(.data$X) %>%
    dplyr::summarise(abundance = sum(.data$value)) %>%
    dplyr::filter(.data$abundance > prop_reps * ncol(otu_table)) %>%
    dplyr::pull(.data$X)

}
