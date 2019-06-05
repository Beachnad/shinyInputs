#' Create choice options
#' 
choiceOpts <- function(choices=NULL, choiceNames=NULL, choiceValues=NULL){
  if (is.null(choices)) {
    if (is.null(choiceNames) | is.null(choiceValues)) stop("choiceNames and choiceValues must be supplied")
  } else {
    if (!is.null(choiceNames) | !is.null(choiceValues)) stop("choiceNames and choiceValues must be NULL")
    choiceNames <- choices
    choiceValues <- choices
  }
  list(
    names = choiceNames,
    values = choiceValues
  )
}

ifnull <- function(x, expr){
  ifelse(is.null(x), expr, x)
}

