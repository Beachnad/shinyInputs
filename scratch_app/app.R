#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(shinyInputs)
library(shinyWidgets)

tglBtn <- toggleButton('toggleButton2', 'some label',
                       choiceNames = c('Male', 'Female', 'Unknown'),
                       choiceValues = c('M', 'F', 'U'))

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
    shinyjs::useShinyjs(),

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        fluidRow(
            style='padding: 30px;',
            actionButton('clear', 'Clear Form'),
            checkBoxesOther(
                'checkbox_other_id',
                'Checkboxes Other',
                choices = c('Apples', 'Pears', 'Plums'),
                selected = c('Apples', 'Peaches', 'Apricot')
            ),
            verbatimTextOutput('checkbox_other_id_val'),
            
            radioButtonsOther(
                'radio_other_id',
                'Radio Other',
                choices = c('Car', 'Truck', 'Plane'),
                selected = "Train"
            ),
            verbatimTextOutput('radio_other_id_val')
        ),
        # Show a plot of the generated distribution
        mainPanel(
            tableOutput("table"),
            verbatimTextOutput('toggle_btn')
        )
    )
))

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$checkbox_other_id_val <- renderText(input$checkbox_other_id)
    
    output$radio_other_id_val <- renderText(input$radio_other_id)
    
    
    observeEvent(input$clear, shinyjs::runjs("$('input:checked').removeAttr('checked')"))

    
}

shinyApp(ui, server)
