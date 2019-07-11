#' @export
checkboxTextInput <- function(id, label){
  html <- tags$div(
    id = id,
    class="siny-input-container checkbox-text-container",
    tags$input(type="checkbox", style="margin-right: 4px;"),
    tags$span(label),
    tags$input(type="text", class="other-radio-text-input form-control shiny-bound-input")
  )
  attachShinyInputsDep(html, widget='checkbox text')
}