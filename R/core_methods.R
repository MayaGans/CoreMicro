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
#' @param taxa_as_rows \code{logical} data must be in a format where the taxa are rows
#' and the sites are columns. The default value is \code{TRUE},
#' if \code{FALSE} data will be transposed for downstream analysis.
#'
#' @return a dataframe with all observed taxa,
#' their inclusion to the core by method (delineated as a 1 or 0),
#' the mean, variance, and coefficient of variation.
#'
#' @examples
#' \dontrun{core_methods(arabidopsis)}
#'
#' @export

core_methods <- function(otu_table, taxa_as_rows = TRUE) {

  # transpose data if rows are not taxa
  if (!taxa_as_rows) otu_table <- transpose_taxa(otu_table)

  # rename first column `X`
  names(otu_table)[1] <- "X"

  temp <- summarise_taxa(otu_table) %>%
    dplyr::mutate(
      `Summation of Sequence Reads` = .data$X %in% sum_reads(otu_table),
      `Proportion of Sequence Reads and Replicates` = .data$X %in% prop_reads_and_reps(otu_table),
      `Hard Cutoff` = .data$X %in% hard_cutoff(otu_table),
      `Proportion of Sequence Replicates` = .data$X %in% prop_reps(otu_table)) %>%
    dplyr::mutate_if(is.logical, as.numeric) %>%
    tidyr::pivot_longer(cols = 5:8) %>%
    dplyr::mutate(name = factor(.data$name, levels = c("Summation of Sequence Reads",
                                          "Proportion of Sequence Replicates",
                                          "Proportion of Sequence Reads and Replicates",
                                          "Hard Cutoff")))

  class(temp) <- append(class(temp),"core_methods")
  return(temp)

}
