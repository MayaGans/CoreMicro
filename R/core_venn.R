#' Core Venn Diagram
#'
#' Create a venn diagram using the output of core_methods to find which core taxa are included
#' in which methods
#'
#' @param combined_taxa_data the taxa data of type \code{core_methods}
#' @param category_names the names of the core inclusion methods.
#' @param low the low hexedicmal color
#' @param high the high hexidecimal color
#'
#' @examples
#' \dontrun{
#' core_arabidopsis <- core_methods(arabidopsis)
#' core_venn(core_arabidopsis)
#' }
#' @export
core_venn <- function(combined_taxa_data,
                             category_names = c("Proportion of \n Sequence Reads",
                                                "Proportion of \n Sequence Replicates",
                                                "Proportion of \n Sequence Reads and Replicates",
                                                "Hard Cut Off"),
                             low = "white",
                             high = "#7E191B") {

  UseMethod("core_venn", combined_taxa_data)

}


#' @importFrom glue glue
#' @importFrom rlang abort
#' @return NULL
#' @export
#' @rdname core_venn
core_venn.default <- function(combined_taxa_data,
                             category_names = c("Proportion of \n Sequence Reads",
                                                "Proportion of \n Sequence Replicates",
                                                "Proportion of \n Sequence Reads and Replicates",
                                                "Hard Cut Off"),
                             low = "white",
                             high = "#7E191B") {

  x <- deparse(substitute(combined_otu_data))

  rlang::abort(
    glue::glue("to create plot,
               {x} must be of type core_methods.
               Please run core_methods({x})  prior to plotting")
  )

}


#' @importFrom ggplot2 scale_fill_gradient
#' @importFrom ggVennDiagram ggVennDiagram
#
#' @return a venn diagram of the taxa included within each core method
#'
#' @export
#' @rdname core_venn
core_venn.core_methods <- function(combined_taxa_data,
                                     category_names = c("Proportion of \n Sequence Reads",
                                                        "Proportion of \n Sequence Replicates",
                                                        "Proportion of \n Sequence Reads and Replicates",
                                                        "Hard Cut Off"),
                                     low = "white",
                                     high = "#7E191B") {

    temp <-
      combined_taxa_data %>%
      dplyr::filter(value == 1) %>%
      dplyr::select(X, name)

    temp <- lapply(split(temp, temp$name), `[[`, "X")

    suppressMessages(
      suppressWarnings(
        ggVennDiagram::ggVennDiagram(temp, category.names = category_names) +
          ggplot2::scale_fill_gradient(low=low,high = high)
      )
    )

}

