#' Combine Plot
#'
#' @description Generate a plot using the output from \code{combined_methods}
#'
#' @param combined_otu_data the dataframe output of \code{combined_methods}
#' @param low the hexidecimal code of the low color
#' @param high the hexidecimal code of the high color
#' @param legend_title the
#' @return a dataframe with all observed taxa, their inclusion to the core by method (delineated as a 1 or 0), the mean, variance, and coefficient of variation.
#'
#' @examples
#' combined_arabidopsis <- combine_methods(arabidopsis)
#' combine_plots(combined_arabidopsis, high = "#2D5062", low = "#E6ECF1", legend_title = "Arabidopsis Taxa Count")
#'
#' @import ggplot2
#'
#' @export

combine_plots <- function(combined_otu_data, low = "#EAE6f3", high = "#432976", legend_title) {
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
