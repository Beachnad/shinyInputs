#' @export
checkboxTextInput <- function(id, label, value=NULL){
  html <- tags$div(
    id = id,
    class="siny-input-container checkbox-text-container",
    tags$input(type="checkbox"),
    tags$span(label),
    tags$input(type="text", class="other-radio-text-input form-control shiny-bound-input", value=value)
  )
  
  attachShinyInputsDep(html, widget='checkbox text')
}