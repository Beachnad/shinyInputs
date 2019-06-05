#' Adds the content of www to shinyWidgets/
#'
#' @importFrom shiny addResourcePath registerInputHandler
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('shinyInputs', system.file('www', package = 'shinyInputs'))
}