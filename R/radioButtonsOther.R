#' Shiny radio buttons with other input os last item
#' 
#' Given an input id, label, and possible choices, will
#' generate radio buttons. The final radio button will
#' be a text input field labeled as other.
#' 
#' @author Danny Beachnau
#' @param id The input slot that will be used to access the value.
#' @param label Display label for the control, or NULL for no label.
#' @param choices List of values to select from (if elements of
#'     the list are named then that name rather than the value
#'     is displayed to the user). If this argument is provided,
#'     then choiceNames and choiceValues must not be provided, and
#'     vice-versa. The values should be strings; other types (such
#'     as logicals and numbers) will be coerced to strings.
#' @param selected The initially selected value (if not specified then defaults to the first value)
#' @export
radioButtonsOther <- function(id, label, choices = NULL,
                              choiceNames=NULL, choiceValues=NULL, selected=NULL, otherLabel="Other", placeholder=NULL) {
  library(shinyWidgets)
  shinyWidgets::prettyRadioButtons(id, label, choices = choices)
  
  if (is.null(choices)) {
    if (is.null(choiceNames) | is.null(choiceValues)) stop("choiceNames and choiceValues must be supplied")
  } else {
    if (!is.null(choiceNames) | !is.null(choiceValues)) stop("choiceNames and choiceValues must be NULL")
    choiceNames <- choices
    choiceValues <- choices
  }
  
  
  selected <-
    if (is.null(selected))
      choiceNames[1]
  else
    selected
  
  radio_item_wrapper <- function(radio_value, input_html, span=T){
    
    shiny::tagList(
      list(
        tags$div(prettyRadioButtons(paste0('hack_pretty-', id), 'Hacking', choices=c(1, 2, 3)), style="display:None;"),
        shiny::tags$div(style="height:3px;"),
        shiny::tags$div(
          class="pretty p-default p-round",
          input_html,
          shiny::tags$div(
            class = "state p-primary",
            style = 'margin-right: 5px;',
            shiny::tags$label(tags$span(radio_value))
          )
        ) 
      )
    )

  }
  radio_item <- function(value, label){
    if (value == selected)
      el <- radio_item_wrapper(value, shiny::tags$input(type="radio", name=id, value=value, checked='checked'))
    else
      el <- radio_item_wrapper(value, shiny::tags$input(type="radio", name=id, value=value))
    el
  }
  
  print(choiceValues)
  print(choiceNames)
  
  rad_items <- mapply(radio_item, value=choiceValues, label=choiceNames)
  shiny_default_class <- "form-group shiny-input-radiogroup shiny-input-container"
  div_class <- paste(shiny_default_class, "si-radio-group")
  
  addResourcePath(
    prefix = 'shinyInputs', directoryPath = system.file('www', package='shinyInputs')
  )
  
  tagList(
    # This makes web page load the JS file in the HTML head.
    # The call to singleton ensures it's only included once
    # in a page.
    shiny::singleton(
      shiny::tags$head(
        shiny::tags$script(src="shinyInputs/radioButtonsOther-bindings.js"),
        tags$link(rel="stylesheet", type="text/css", href="shinyInputs/shinyInputs.css")
      )
    ),
    
    shiny::tags$div(
      id=id,
      class = 'cust-input-radiogroup form-group shiny-input-radiogroup shiny-input-container',
      shiny::tags$label(label, `for` = id, class="control-label"),
      shiny::tags$div(
        class="shiny-options-group",
        shiny::tags$div(style="height:7px;"),
        rad_items,
        tagList(
          radio_item_wrapper(
            radio_value = otherLabel,
            input_html = tagList(
              shiny::tags$input(
                class="other-radio-input",
                type="radio",
                placeholder=placeholder,
                name=id,
                # shiny::tags$span(otherLabel, class='other-radio-label'),
                shiny::tags$input(id=paste0(id, '-text'), class='other-radio-text-input form-control', type='text')
              )
            ),
            span = F
          )
        )
      )
    )
  )
}

