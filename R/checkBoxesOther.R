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
checkBoxesOther <- function(id, label, choices = NULL, choiceNames=NULL, choiceValues=NULL, selected=NULL, otherLabel="Other", placeholder=NULL) {
  choice_opts <- choiceOpts(choices, choiceNames, choiceValues)
  selected <- ifnull(selected, choice_opts$names[1])
  
  radio_item_wrapper <- function(radio_value, input_html, span=T){
    shiny::tagList(
      shiny::tags$div(style="height:3px;"),
      shiny::tags$div(
        class="pretty p-default",
        input_html,
        shiny::tags$div(
          class = "state p-primary",
          style = 'margin-right: 5px;',
          shiny::tags$label(tags$span(radio_value))
        )
      ) 
    )
  }
  radio_item <- function(value, label){
    value = ifelse(is.na(value), 'NA', value)
    if (value == selected)
      el <- radio_item_wrapper(value, shiny::tags$input(type="checkbox", name=id, value=value, checked='checked'))
    else
      el <- radio_item_wrapper(value, shiny::tags$input(type="checkbox", name=id, value=value))
    el
  }
  
  rad_items <- mapply(radio_item, value=choice_opts$values, label=choice_opts$names, SIMPLIFY = F)
  shiny_default_class <- "form-group shiny-input-radiogroup shiny-input-container"
  div_class <- paste(shiny_default_class, "si-radio-group")
  
  html <- shiny::tags$div(
    id=id,
    class = 'cust-input-checkbox-group form-group shiny-input-checkboxgroup shiny-input-container',
    shiny::tags$label(label, `for` = id, class="control-label"),
    shiny::tags$div(
      class="shiny-options-group",
      shiny::tags$div(style="height:7px;"),
      tagList(rad_items),
      radio_item_wrapper(
        radio_value = otherLabel,
        input_html = tagList(
          {
            html <- shiny::tags$input(
              class="other-checkbox-input",
              type="checkbox",
              placeholder=placeholder,
              name=id,
              shiny::tags$input(
                id=paste0(id, '-text'),
                class='other-checkbox-text-input form-control',
                type='text',
                value = ifelse(selected %in% choice_opts$names, '', selected)
              )
            )
            # browser()
            if(!selected %in% choice_opts$names){
              html$attribs$checked <- 'checked'
            }
            html
          }
          
        ),
        span = F
      )
    )
  )
  
  attachShinyInputsDep(html, 'checkbox other')
}
