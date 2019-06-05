#' Extends options for a vertical tabset panel from the shinyWidgets library
#' 
#' @author DannyBeachnau
#' 
#' @importFrom shinyWidgets verticalTabsetPanel
#' @importFrom htmltools tags
#' 
#' @export
extVerticalTabsetPanel <- function(..., selected=NULL, id=NULL, color = "#112446", contentWidth = 9, menuSide = "left", addButton=F){
  tabSet <- shinyWidgets::verticalTabsetPanel(..., selected=selected, id=id, color = color, contentWidth = contentWidth, menuSide = menuSide)
  if(addButton){
    add_btn <- tags$button(class="list-group-item text-center vt-add-btn", style='height: 70px;',tags$h4(style="text-align: center;",tags$i(class="fa fa-plus fa-2x")))
    i <- length(tabSet[[2]]$children[[1]]$children[[1]]$children) + 1
    tabSet[[2]]$children[[1]]$children[[1]]$children[[i]] <- add_btn
  }
  
  tabSet[[1]][[1]] <- shiny::tags$link(href='shinyInputs/ExtendVerticalTabPanel/vertical-tab-panel.css')
  tabSet[[3]][[1]] <- shiny::tags$script(src='shinyInputs/ExtendVerticalTabPanel/vertical-tab-panel.js')
  tabSet[[3]][[2]] <- shiny::tags$script(src='shinyInputs/ExtendVerticalTabPanel/vertical-tab-panel-bindings.js')
  tabSet
}