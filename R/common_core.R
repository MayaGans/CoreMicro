#' Common Core
#' 
#' Using the core_methods output,
#' return a dataframe of taxa IDs,
#' the number of core methods they are included in,
#' and the name of the core methods of inclusion
#'
#' @param data the \code{core_methods} output of your taxa table
#' @param threshhold number of methods to include in results, all methods included by default
#' @examples
#' \dontrun{
#' core_methods(arabidopsis) %>% common_core(threshhold = 2)
#' }
#' @export
#'
common_core <- function(data, threshhold = 0) {

  dat <- data.frame(data)

  dat %>%
    dplyr::distinct(.data$X) %>%
    dplyr::left_join(
      dat %>%
        dplyr::filter(.data$value != 0) %>%
        dplyr::group_by(.data$X) %>%
        dplyr::summarise(
          num_methods = sum(.data$value),
          methods = list(unique(as.character(.data$name)))
        )
    ) %>%
    tidyr::replace_na(replace = list(count = 0L)) %>%
    dplyr::filter(.data$num_methods == .data$threshhold)
}
