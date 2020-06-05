#' Hard Cut-Off
#'
#' @description This method assigns taxa to the core if they are present in more than a pre-determined number of sites and have a total abidance greater than a pre-determined number of reads. In our example we set the minimum number of sites to 5 and the minimum number of reads to 25. Here we use the hard cut off described in Lundberg (2012), but realize this is any threshold.
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @param cutoff the threshhold minimum number of reads
#' @param sites the theshhold minimum number of sites
#'
#' @return the names of OTUs which meet the hard cut off criteria
#'
#' @examples
#' prop_reads(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @import dplyr
#'
#' @export

hard_cutoff <- function(otu_table, cutoff = 25, sites = 5) {
  otu_table %>%
    tidyr::pivot_longer(-X) %>%
    dplyr::select(-name) %>%
    dplyr::filter(value > cutoff) %>%
    dplyr::group_by(X) %>%
    dplyr::summarise(count = n()) %>%
    dplyr::filter(count >= sites) %>%
    dplyr::pull(X)
}
