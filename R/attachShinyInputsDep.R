#' Attach shinyInputs dependancies
#'
#' @param tag An object which has (or should have) HTML dependencies.
#' @param widget Name of a widget for particular dependancies
#'
#' @noRd
#' @importFrom utils packageVersion
#' @importFrom htmltools htmlDependency attachDependencies findDependencies
#' @importFrom shiny icon
#'
attachShinyInputsDep <- function(tag, widget=NULL){
  version <- as.character(utils::packageVersion("shinyInputs")[[1]])
  
  custom_dep <- htmltools::htmlDependency(
      name = "shinyInputs",
      version = version,
      src = c(href = "shinyInputs"),
      script = "shinyInputs-bindings.js",
      stylesheet = "shinyInputs.css"
  )
  
  jquery_dep <- htmltools::htmlDependency(
    name = 'jQuery', version='3.4.1',
    src = c(href='shinyInputs/jQuery'),
    script = "jquery.min.js"
  )
  
  bs_dep <- htmltools::htmlDependency(
    name='bootstrap', version='4.3.1',
    src = c(href="shinyInputs/Bootstrap"),
    script = "bootstrap.min.js",
    stylesheet = "bootstrap.min.css"
  )
  
  popper_dep <- htmltools::htmlDependency(
    name='popper', version='1.14.7',
    src = c(href="shinyInputs/Popper"),
    script = "popper.min.js"
  )
  
  if(widget=="adder"){
    dep <- list(
      custom_dep,
      popper_dep,
      # jquery_dep,
      htmltools::htmlDependency(
        name = "adderInput",
        version = version,
        src = c(href = "shinyInputs/Adder"),
        script = "add.js",
        stylesheet = "add.css"
      )
    )
  } else if (widget=="dynamic"){
    dep <- list(
      custom_dep,
      # jquery_dep,
      htmltools::htmlDependency(
        name = "dynamicInput",
        version = version,
        src = c(href = "shinyInputs/DynamicWrapper"),
        script = "dynamic.js",
        stylesheet = "dynamic.css"
      )
    )
  } else if (widget == 'toggle button'){
    dep <- list(
      custom_dep,
      # jquery_dep,
      htmltools::htmlDependency(
        name = "toggleButton",
        version = version,
        src = c(href = "shinyInputs/ToggleButton"),
        script = "toggle.js",
        stylesheet = "toggle.css"
      )
    )
  } else if (widget == 'radio other'){
    dep <- list(
      custom_dep,
      # jquery_dep,
      htmltools::htmlDependency(
        name = "radioOther",
        version = version,
        src = c(href = "shinyInputs/RadioOther"),
        script = "radio_other.js",
        stylesheet = "radio_other.css"
      )
    )
  }
  
  htmltools::attachDependencies(tag, dep, append = TRUE)
}