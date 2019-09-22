#' Shiny checbox buttons with other input os last item
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
checkBoxesOther <- function(id, label, choices = NULL, choiceNames=NULL, choiceValues=NULL, selected=NULL, otherLabel="Other", placeholder=NULL, ...) {
  choice_opts <- choiceOpts(choices, choiceNames, choiceValues)
  
  html <- shinyWidgets::prettyCheckboxGroup(id, label,
                                            choiceNames = choice_opts$names,
                                            choiceValues = choice_opts$values,
                                            selected = selected,
                                            ...)
  
  otherValue <- selected[!selected %in% choice_opts$values]
  if (length(otherValue) > 1){
    warning('otherValue is contains more than one item. Only using the first.')
    otherValue <- otherValue[1]
  }
  
  html$attribs$class <- "form-group cust-input-checkbox-group shiny-input-container"
  
  if (is.null(selected)){
    html$children[[2]]$children
  }
  
  new_html <- tail(html$children[[2]]$children[[2]], 1)[[1]][[1]]
  new_html$children[[1]]$attribs$class <- "other-checkbox-input"
  if(length(otherValue)==1){
    new_html$children[[1]]$attribs$checked <- 'checked' 
  }
  
  new_html$children[[2]]$children[[2]]$children[[1]] <- span(otherLabel)
  new_html$children[[3]] <- tags$input(type='text', class='other-checkbox-text-input form-control shiny-bound-input', `initial-value`=otherValue)
  

  
  
  i <- length(html$children[[2]]$children) + 1
  html$children[[2]]$children[[i]] <- new_html
  
  attachShinyInputsDep(html, 'checkbox other')
}