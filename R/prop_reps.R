#' Proportion of Replicates
#'
#' @description This method assigns taxa to the core if they account for some proportion of the total reads for the sequencing run and if they are present in at least x% of the total number of replicates. In this example, a core taxa must account for 0.01% of the total reads for the entire otu table and be present in at least 50% of sites.
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @return the names of OTUs which meet the proportion of replicate criteria
#'
#' @examples
#' prop_reps(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export

prop_reps <- function(otu_table) {
  otu_table %>%
    tidyr::pivot_longer(-1) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(abundance = sum(value)) %>%
    dplyr::filter(abundance > 10*ncol(otu_table)) %>%
    dplyr::pull(X)
}
