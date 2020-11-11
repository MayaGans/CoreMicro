#' Hard Cut-Off
#'
#' @description This method assigns taxa to the core
#' if they are present in more than a pre-determined number of sites
#' and have a total abidance greater than a pre-determined number of reads.
#' In our example we set the minimum number of sites to 5 and the minimum number of reads to 25.
#' Here we use the hard cut off described in Lundberg (2012), but realize this is any threshold.
#'
#' @param otu_table a dataframe of OTUs where the first row is the OTU ID and column names refer to sites
#' @param cutoff the threshhold minimum number of reads - defaults to 25
#' @param sites the theshhold minimum number of sites - defaults to 5
#'
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
#' @return the names of OTUs which meet the hard cut off criteria
#'
#' @examples
#' prop_reads(arabidopsis)
#'
#' @export

hard_cutoff <- function(otu_table, cutoff = 25, sites = 5, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  otu_table %>%
    tidyr::pivot_longer(-.data$X) %>%
    dplyr::select(-.data$name) %>%
    dplyr::filter(.data$value > cutoff) %>%
    dplyr::group_by(.data$X) %>%
    dplyr::count() %>%
    dplyr::ungroup() %>%
    dplyr::filter(.data$n >= sites) %>%
    dplyr::pull(.data$X)
}

