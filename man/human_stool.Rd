% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/human_stool-data.R
\docType{data}
\name{human_stool}
\alias{human_stool}
\title{Descritpion for subset of the human microbiome dataset used for comparison of core assignment methods. 
Methods for filtering of the original dataset can be found in data-raw/human.R.}
\format{
An object of class \code{data.frame} with 11752 rows and 320 columns.
}
\source{
\href{https://hmpdacc.org/ihmp/}{https://hmpdacc.org/ihmp/}

\href{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}{http://downloads.hmpdacc.org/data/HMQCP/otu_table_psn_v35.txt.gz}

\href{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}{http://downloads.hmpdacc.org/data/HMQCP/v35_map_uniquebyPSN.txt.bz2}
}
\usage{
data(human_stool)
}
\description{
#' Script used to prune dataset to only rhizosphere samples can be 
found (\href{https://github.com/MayaGans/CoreMicro/blob/master/data-raw/human.R}{here}).
}
\examples{
\dontrun{data(human_stool)}
\dontrun{core_methods(human_stool)}
}
\references{
Consortium, Human Microbiome Project, and others. 2012. “Structure, Function and Diversity of the Healthy Human Microbiome.” 
Nature 486 (7402). Nature Research: 207–14.
}
\keyword{datasets}
