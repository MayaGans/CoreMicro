#' Descritpion for subset of the human microbiome dataset used for comparison of core assignment methods. 
#' Methods for filtering of the original dataset can be found in data-raw/human.R. 
#' 
#' Script used to prune dataset to only rhizosphere samples can be 
#' found (\href{https://github.com/MayaGans/CoreMicro/blob/master/data-raw/human.R}{here}).
#'
#' @docType data
#'
#' @usage data(human_stool)
#'
#' @keywords datasets
#'
#' @references Consortium, Human Microbiome Project, and others. 2012. “Structure, Function and Diversity of the Healthy Human Microbiome.” 
#' Nature 486 (7402). Nature Research: 207–14.
#'
#' @source \href{https://hmpdacc.org/ihmp/}{https://hmpdacc.org/ihmp/}
#' @source \href{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}
#' @source \href{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}
#'
#' @examples
#' \dontrun{data(human_stool)}
#' \dontrun{core_methods(human_stool)}
"human_stool"
