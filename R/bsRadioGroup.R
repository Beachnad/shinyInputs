#' @export
bsRadioGroup <- function(id, label, choices, selected){
  radio_item <- function(value, label){
    shiny::tagList(
      shiny::tags$div(
        class='form-check',
        shiny::tags$input(
          class='form-check-input',
          type='radio',
          name=id,
          value=value
        ),
        shiny::tags$label(
          class='form-check-label',
          label
        )
      ) 
    )
  }
  
  choiceNames <- choices
  choiceValues <- choices
  
  shiny::tagList(
    # This makes web page load the JS file in the HTML head.
    # The call to singleton ensures it's only included once
    # in a page.
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src="shinyInputs/bsRadioGroup-bindings.js"),
        shiny::tags$link(href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css",
                    rel="stylesheet",
                    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T",
                    crossorigin="anonymous")
      )
    ),
    shiny::tags$div(
      class='form-group shiny-input-container',
      shiny::tags$label(`for`=id, label),
      shiny::tagList(mapply(radio_item, value=choiceValues, label=choiceNames))
    )
  )
}
