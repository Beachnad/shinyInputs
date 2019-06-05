
#' @export
#' @importFrom htmltools tags
#' @importFrom shiny actionButton
dynamicWrapper <- function(id, wrapped_element){
  ns <- NS(id)
  
  wellWrapElement <- function(x){
    htmltools::tags$div(
      class='well wrapped-element',
      style='margin:8px;',
      x
    )
  }

  html <- htmltools::tags$div(
    id=id,
    class='dynamic-wrapper-container shiny-input-widget',
    style='width: 500px; padding: 20px; border: 1px solid black;',
    htmltools::tags$div(
      class='multi-container',
      htmltools::tags$div(
        class='element-copy',
        style='display: none;',
        wellWrapElement(wrapped_element)
      ),
      wellWrapElement(wrapped_element)
    ),
    htmltools::tags$hr(),
    htmltools::tags$div(
      id='control-panel',
      shiny::actionButton(ns('add_new'), 'New', icon('plus'), class='add-btn')
    )
  )
  
  attachShinyInputsDep(html, 'dynamic')
}


