library(htmltools)

VALID_SIZES <- c('xs', 'sm', 'md', 'lg', 'xl')

#' @importFrom htmltools tags tagList
adderInputUI <- function(id, label, choices, placeholder="", label_size='lg', toggle_button=NULL){
  if(!is.null(toggle_button)){
    # removes the label
    toggle_button$children[[1]] <- NULL
  }
  
  
  filterElement <- function(){
    dropDownItems <- shiny::tagList(sapply(choices, function(x){
      htmltools::tags$li(htmltools::tags$a(x, class="dropdown-item"))
    }, simplify = F))
    
    if(!label_size %in% VALID_SIZES){
      stop('Not a valid size!')
    }
    
    dropDownMenu <- htmltools::tags$div(
      class="btn-group fill flex-container",
      htmltools::tags$button(
        class="btn btn-default flex-item filter-type",
        type="button",
        choices[1],
        htmltools::tags$button(
          type="button",
          class="btn btn-default dropdown-toggle flex-static-xs sharp-corners pd-0",
          `data-toggle`="dropdown",
          htmltools::tags$span(class='caret'),
          htmltools::tags$span(class='sr-only', "Toggle Dropdown")
        )
      ),
      htmltools::tags$ul(
        class='dropdown-menu',
        dropDownItems
      )
    )
    
    element <- htmltools::tags$span(
      class="filter-element",
      htmltools::tags$div(
        class="input-group mb-xs flex-container fill",
        {
          htmltools::tags$div(
            class=paste0('input-group-addon flex-static-', label_size),
            dropDownMenu
          )
        },
        {htmltools::tags$input(
          type="text",
          class="form-control flex-item open-ends filter-content",
          placeholder=placeholder
        )},
        {htmltools::tags$button(
          class="btn remove-element red input-group-text fill justify-center flex-static-xs",
          shiny::icon('minus')
        )
        }
      )
    )

    element
  }
  
  addFilter <- htmltools::tags$span(
    class="add-filter-element",
    htmltools::tags$div(
      class='input-group flex-container',
      htmltools::tags$button(
        class="btn add-element flex-static-xs green fitler-type input-group-text justify-center",
        shiny::icon('plus')
      ),
      htmltools::tags$input(
        type="text",
        class="form-control",
        readonly=NA
      ),
      htmltools::tags$div(
        class='flex-item',
        toggle_button
      )
    )
  )
  
  container <- htmltools::tags$div(
    id=id,
    class="dynamic-filter-container shiny-input-widget",
    htmltools::tags$label(`for`=id, label, class="control-label"),
    htmltools::tags$div(
      class='content-group',
      htmltools::tags$div(
        class='filter-elements',
        filterElement()
      ),
      addFilter
    )
  )
  return(container)
}

#' @importFrom htmltools tags tagList
#' 
#' @export
adderInput <- function(id, label, choices, placeholder="", label_size='lg', toggle_button=NULL){

  ui <- adderInputUI(id, label, choices, placeholder, label_size, toggle_button)
  attachShinyInputsDep(ui, 'adder')
}
