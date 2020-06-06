#' Generate a plot using the output from \code{combined_methods}
#'
#' @param combined_otu_data the dataframe output of \code{combined_methods}
#' @param low the hexidecimal code of the low color
#' @param high the hexidecimal code of the high color
#' @param legend_title title display above legend
#'
#' @examples
#' \dontrun{
#' core_arabidopsis <- combine_methods(arabidopsis)
#' core_plots(
#'   core_arabidopsis,
#'    high = "#2D5062",
#'    low = "#E6ECF1",
#'    legend_title = "Arabidopsis Taxa Count"
#' )
#' }
#'
#' @return a ggplot2 object of methods...
#'
#' @export

core_plots <- function(combined_otu_data,
                       low = "#EAE6f3",
                       high = "#432976",
                       legend_title = "Taxa Count") {

  UseMethod("core_plots", combined_otu_data)

}


#' @importFrom glue glue
#' @importFrom rlang abort
#' @return NULL
#' @export
#' @rdname core_plots
core_plots.default <- function(combined_otu_data,
                               low = "#EAE6f3",
                               high = "#432976",
                               legend_title = "Taxa Count") {

  x <- deparse(substitute(combined_otu_data))

  rlang::abort(
    glue::glue("to create plot,
               {x} must be of type core_methods.
               Please run core_methods({x})  prior to plotting")
    )

}


#' @importFrom rlang .data
#' @import ggplot2
#'
#' @return a dataframe with all observed taxa,
#' their inclusion to the core by method (delineated as a 1 or 0),
#' the mean, variance, and coefficient of variation.
#'
#' @export
#' @rdname core_plots
core_plots.core_methods  <- function(combined_otu_data,
                                     low = "#EAE6f3",
                                     high = "#432976",
                                     legend_title = "Taxa Count") {

    combined_otu_data %>%
      ggplot() +
      aes(x = log(Mean), y = CV, color = as.factor(value)) +
      geom_hex(bins = 30) +
      scale_color_manual(values = c("lightgray", "black")) +
      scale_fill_gradient(low = low, high = high) +
      theme_bw() +
      facet_grid(.~ name) +
      guides(color = FALSE) +
      ylab("Coefficient of Variance") +
      labs(fill = legend_title)

}


