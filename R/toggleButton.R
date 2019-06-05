source('./R/utils.R')

#' Button that iterates over options on each click
#' 
#' @author Danny Beachnau
#' @importFrom htmltools tags
#' 
#' @export
toggleButton <- function(id, label, selected=NULL, choices=NULL, choiceNames=NULL, choiceValues=NULL){
  choice_opts <- choiceOpts(choices, choiceNames, choiceValues)
  
  if (is.null(selected)){
    selectedName = choice_opts$names[1]
    selected = choice_opts$values[1]
  } else {
    selectedName = choice_opts$names[selected == choice_opts$values]
  }
  
  if(is.null(label)){
    label = htmltools::tags$label(style='display:none;')
  } else {
    label = htmltools::tags$label(class='control-label',`for`=id, label)
  }
  
  html <- htmltools::tags$div(
    id=id,
    class='toggle-button-container shiny-input-widget',
    label,
    htmltools::tags$div(
      class='content-group',
      htmltools::tags$button(
        class="btn btn-default toggle-button",
        type="button",
        value=selected,
        selectedName
      ),
      htmltools::tags$ul(
        class='toggle-opts',
        htmltools::tagList(mapply(
          function(n, v){
            if(v == selected){
              htmltools::tags$li(class='toggle-opt', selected='selected',value=v, n)
            } else {
              htmltools::tags$li(class='toggle-opt', value=v, n)
            }
          }, n=choice_opts$names, v=choice_opts$values, SIMPLIFY = F)
        )
      )
    )

  )
  attachShinyInputsDep(html, 'toggle button')
}