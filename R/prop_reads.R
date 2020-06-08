#' Proportion of Reads:
#'
#' @description This method assigns taxa to the core if they are in the top X% of reads.
#' Taxa are ranked in abundance and the cumulative sum is recorded.
#' Any taxa which appears before some cutoff percentage is included in the core.
#' In this example, a taxa will be assigned to the core if they account for the first 75% of the reads
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @param perc blah blah
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
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

prop_reads <- function(otu_table, perc = 0.75, taxa_as_rows =TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-X) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(otuappearance = sum(value)) %>%
    dplyr::arrange(-otuappearance) %>%
    dplyr::mutate(s = sum(otuappearance),
           prop = otuappearance/s,
           cumsum = cumsum(prop)) %>%
    dplyr::filter(cumsum <= perc) %>%
    dplyr::pull(X)
}
