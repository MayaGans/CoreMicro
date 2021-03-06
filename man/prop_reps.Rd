% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/prop_reps.R
\name{prop_reps}
\alias{prop_reps}
\title{Proportion of Replicates}
\usage{
prop_reps(otu_table, prop_reps = 0.5, taxa_as_rows = TRUE)
}
\arguments{
\item{otu_table}{a dataframe of OTUs where
the first row is the OTU ID and column names refer to sites}

\item{prop_reps}{some definition}

\item{taxa_as_rows}{\code{logical} data must be in a format where the taxa are rows
and the sites are columns. The default value is \code{TRUE},
if \code{FALSE} data will be transposed for downstream analysis.}
}
\value{
the names of OTUs which meet the proportion of replicate criteria
}
\description{
This method assigns taxa to the core
if they account for some proportion of the total reads for the sequencing run
and if they are present in at least x% of the total number of replicates.
In this example, a core taxa must account for 0.01% of the total reads
for the entire otu table and be present in at least 50% of sites.

According to the mansucript it should be 0.5 x total reps.
I hope we didnt do 10 x totalreps when calculating the number of taxa included etc.
}
\examples{
prop_reps(arabidopsis)

}
