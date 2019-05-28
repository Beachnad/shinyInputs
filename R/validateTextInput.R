validateInputWrapper <- function(id, label, validate_input, type, valid_feedback=NULL, invalid_feedback=NULL){
  shiny::tagList(
    shiny::tags$div(
      class="validate-input",
      shiny::tags$div(
        class=paste('form-group shiny-input-container'),
        `data-type`=type,
        shiny::tags$label(`for`=id, label),
        validate_input,
        shiny::tags$div(class='valid-feedback', valid_feedback),
        shiny::tags$div(class='invalid-feedback', invalid_feedback)
      )
    )
  )
}

#' @export
validateNumber <- function(id, label, valid_feedback=NULL, invalid_feedback=NULL, value=50, min=0, max=100, required=TRUE, ...){
  input <- shiny::tags$input(
    id=id,
    value=value,
    type='number',
    class="form-control",
    min=min,
    max=max,
    ...
  )
  if(required){input$attribs$required <- NA}
  return(validateInputWrapper(id, label, input, 'number',valid_feedback, invalid_feedback))
}

#' @export
validateText <- function(id, label, valid_feedback=NULL, invalid_feedback=NULL, value=NULL,
                         max_length=NULL, min_length=NULL, required=TRUE, ...){
  input <- shiny::tags$input(
    id=id,
    value=value,
    type='text',
    class="form-control",
    `max-length`=max_length,
    `min-length`=min_length,
    ...
  )
  if(required){input$attribs$required <- NA}
  return(validateInputWrapper(id, label, input, 'text', valid_feedback, invalid_feedback))
}

#' @export
validateCheckboxGroup <- function(id, label, choices, selected=NULL, valid_feedback=NULL, invalid_feedback=NULL){
  if(is.null(selected)){selected <- choices[1]}
  
  radio_items <- mapply(function(choice){
    inner <- shiny::tags$input(type='checkbox', name=id, value=choice)
    if(choice == selected){inner$checked <- "checked"}
    
    shiny::tagList(
      shiny::tags$div(
        class='checkbox',
        shiny::tags$label(inner, shiny::tags$span(choice))
      )
    )

  }, choice=choices)
  
  return(validateInputWrapper(id, label, tagList(radio_items), 'checkbox-group',valid_feedback, invalid_feedback))
}

#' @export
validateForm <- function(id, label, ...){
  addResourcePath(
    prefix = 'shinyInputs', directoryPath = system.file('www', package='shinyInputs')
  )
  
  shiny::tagList(
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(type="text/javascript", src="shinyInputs/formValidation.js"),
        shiny::tags$script(
          src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js",
          integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o",
          crossorigin="anonymous"
        ),
        shiny::tags$link(
          href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css",
          rel="stylesheet",
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T",
          crossorigin="anonymous"
        )
      )
    ),
    shiny::tags$div(
      class='validate-input-group',
      shiny::tags$label(`for`=id, label),
      shiny::tags$form(
        id=id, class='needs-validation', novalidate=NA,
        shiny::tagList(...),
        shiny::tags$button(class="btn btn-primary btn-validate", type="submit", 'Submit form')
      )
    ) 
  )
}
