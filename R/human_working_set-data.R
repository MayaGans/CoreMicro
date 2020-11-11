#' Descritpion for human microbiome project phyloseq objects. 
#' 
#' This datsaet was used for comparison of core assignment methods. This human_ps phyloseq object contains all samples
#' from the human microbiome project. Methods for filtering of the original dataset to include only stool
#' samples can be found in data-raw/human.R. The entire raw human datset is named human_ps. 
#' The stool subset of the human dateset is named human_working_set. 
#'
#' @docType data
#'
#' @usage data(human_working_set)
#'
#' @keywords datasets, human microbiome, stool
#'
#' @references Consortium, Human Microbiome Project, and others. 2012. “Structure, Function and Diversity of the Healthy Human Microbiome.” 
#' Nature 486 (7402). Nature Research: 207–14.
#'
#' @source \href{https://hmpdacc.org/ihmp/}{https://hmpdacc.org/ihmp/} 
#' @source \href{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}
#' @source \href{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}
#'
#' @examples
#' data(human_working_set)
"human_working_set"
