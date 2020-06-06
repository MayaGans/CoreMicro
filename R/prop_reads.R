#' Proportion of Reads:
#'
#' @description This method assigns taxa to the core if they are in the top X% of reads.
#' Taxa are ranked in abundance and the cumulative sum is recorded.
#' Any taxa which appears before some cutoff percentage is included in the core.
#' In this example, a taxa will be assigned to the core if they account for the first 75% of the reads
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @return the names of OTUs which meet the proportion of reads criteria
#'
#' @examples
#' prop_reads(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export

prop_reads <- function(otu_table) {
  otu_table %>%
    tidyr::pivot_longer(-X) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(otuappearance = sum(value)) %>%
    dplyr::arrange(-otuappearance) %>%
    dplyr::mutate(s = sum(otuappearance),
           prop = otuappearance/s,
           cumsum = cumsum(prop)) %>%
    dplyr::filter(cumsum <= 0.75) %>%
    dplyr::pull(X)
}
