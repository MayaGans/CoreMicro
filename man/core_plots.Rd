% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/core_plots.R
\name{core_plots}
\alias{core_plots}
\alias{core_plots.default}
\alias{core_plots.core_methods}
\title{Generate a plot using the output from \code{combined_methods}}
\usage{
core_plots(
  combined_otu_data,
  low = "#EAE6f3",
  high = "#432976",
  legend_title = "Taxa Count"
)

\method{core_plots}{default}(
  combined_otu_data,
  low = "#EAE6f3",
  high = "#432976",
  legend_title = "Taxa Count"
)

\method{core_plots}{core_methods}(
  combined_otu_data,
  low = "#EAE6f3",
  high = "#432976",
  legend_title = "Taxa Count"
)
}
\arguments{
\item{combined_otu_data}{the dataframe output of \code{combined_methods}}

\item{low}{the hexidecimal code of the low color}

\item{high}{the hexidecimal code of the high color}

\item{legend_title}{title display above legend}
}
\value{
a ggplot2 object of methods...

a dataframe with all observed taxa,
their inclusion to the core by method (delineated as a 1 or 0),
the mean, variance, and coefficient of variation.
}
\description{
Generate a plot using the output from \code{combined_methods}
}
\examples{
\dontrun{
core_arabidopsis <- combine_methods(arabidopsis)
core_plots(
  core_arabidopsis,
   high = "#2D5062",
   low = "#E6ECF1",
   legend_title = "Arabidopsis Taxa Count"
)
}

}
