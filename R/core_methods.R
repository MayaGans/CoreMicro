#' Combine Methods
#'
#' @description A wrapper for
#' \code{summarise_taxa}
#' \code{prop_reads},
#' \code{prop_reps},
#' \code{prop_reads_and_reps} and
#' \code{hard_cutoff} methods
#'
#' @param otu_table a dataframe of OTUs where
#' the first row is the OTU ID and column names refer to sites
#'
#' @return a dataframe with all observed taxa,
#' their inclusion to the core by method (delineated as a 1 or 0),
#' the mean, variance, and coefficient of variation.
#'
#' @examples
#' core_methods(arabidopsis)
#'
#' @importFrom tidyr pivot_longer
#' @import dplyr
#' @importFrom rlang .data
#'
#' @export

core_methods <- function(otu_table) {
  temp <- summarise_taxa(otu_table) %>%
    dplyr::mutate(
      `Proportion of Sequence Reads` = X %in% prop_reads(otu_table),
      `Proportion of Sequence Reads and Replicates` = X %in% prop_reads_and_reps(otu_table),
      `Hard Cut Off` = X %in% hard_cutoff(otu_table),
      `Proportion of Sequence Replicates` = X %in% prop_reps(otu_table)) %>%
    dplyr::mutate_if(is.logical, as.numeric) %>%
    tidyr::pivot_longer(cols = 5:8) %>%
    dplyr::mutate(name = factor(name, levels = c("Proportion of Sequence Reads",
                                          "Proportion of Sequence Replicates",
                                          "Proportion of Sequence Reads and Replicates",
                                          "Hard Cut Off")))

  class(temp) <- append(class(temp),"core_methods")
  return(temp)
}
