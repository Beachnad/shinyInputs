library(htmltools)

dynamicAddFilterInputUI <- function(id, label, choices, placeholder=""){
  filterElement <- function(){
    dropDownItems <- shiny::tagList(sapply(choices, function(x){
      shiny::tags$a(x, class="dropdown-item", href="#")
    }, simplify = F))
    
    dropDownMenu <- shiny::tags$div(class="dropdown-menu", dropDownItems)
    element <- shiny::tags$span(
      class="filter-element",
      shiny::tags$div(
        class="input-group=prepend",
        shiny::tags$div(
          class="filter-type input-group-text w-100px",
          choices[1]
        ),
        shiny::tags$button(
          class="input-group-text btn dropdown-toggle dropdown-toggle-split",
          type="button",
          `data-toggle`="dropdown",
          `aria-haspopup`="true",
          `aria-expanded`="false",
          shiny::tags$span(class="sr-only", "Toggle Dropdown")
        ),
        dropDownMenu
      ),
      shiny::tags$input(
        type="text",
        class="form-control",
        placeholder=placeholder
      ),
      shiny::tags$div(
        class='input-group-append',
        shiny::tags$button(
          class="btn remove-element red input-group-text w-50px justify-center",
          shiny::icon('minus')
        )
      )
    )
    element
  }
  
  addFilter <- shiny::tags$span(
    class="input-group mb-2",
    shiny::tags$div(
      class="input-group-prepend",
      shiny::tags$button(
        class="btn add-element green fitler-type input-group-text w-50px justify-center",
        shiny::icon('plus')
      )
    ),
    shiny::tags$input(
      type="text",
      class="form-control",
      readonly=NA
    )
  )
  
  container <- shiny::tags$div(
    id=id,
    class="dynamic-filter-container",
    shiny::tags$label(`for`=id, label),
    filterElement(),
    addFilter
  )
  return(container)
}

#' @importFrom shiny tags tagList
#' 
#' @export
dynamicAddFilterInputUI <- function(id, label, choices, placeholder=""){
  ui <- dynamicAddFilterInput(id, label, choices, placeholder)
  return(ui)
}

dep <- htmltools::htmlDependency(
  name = "dynamicAddFilter",
  version = "0.1",
  src = c(href="shinyInputs/dynamicAddFilter"),
  script = "add-filter.js",
  stylesheet = "add-filter.css"
)

htmltools::attachDependencies(dynamicAddFilterInputUI, dep)
