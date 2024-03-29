#' Descritpion for subset of Arabidopsis dataset used for comparison of core assignment methods
#'
#' Data derived from Lundberg et al. 2012. Dataset used for core assignment comparisons is a subset of the entire
#' core Arabidopsis thaliana root microbiome dataset. We utilized only the rhizosphere samples from the M21 site
#' for our comparisons of core assignment methods.
#' 
#' Script used to prune dataset to only rhizosphere samples can be 
#' found (\href{https://github.com/MayaGans/CoreMicro/blob/master/data-raw/arabidopsis.R }{here}).
#'
#' @docType data
#'
#' @usage data(arabidopsis)
#'
#' @keywords datasets
#'
#' @references D.S. Lundberg, S.L. Lebeis, S.H. Paredes, S. Yourstone, J. Gehring, S. Malfatti, J. Tremblay, A. Engelbrektson,
#' V. Kunin, T.G. del Rio, R.C. Edgar, T. Eickhorst, R.E. Ley, P. Hugenholtz, S.G. Tringe, J.L. Dangl, Defining the core
#' Arabidopsis thaliana root microbiome, Nature. 488 (2012) 86–90. doi:10.1038/nature11237.
#' (\href{https://www.nature.com/articles/nature11237}{Nature})
#'
#'What does QTL Archive thing mean?
#' @source \href{https://www.nature.com/articles/nature11237}{Nature}
#'
#' @examples
#' \dontrun{data(arabidopsis_rhizo)}
#' \dontrun{core_methods(arabidopsis_rhizo)}
"arabidopsis_rhizo"
