#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyInputs)
library(shinyWidgets)

tglBtn <- toggleButton('toggleButton2', 'some label',
                       choiceNames = c('Male', 'Female', 'Unknown'),
                       choiceValues = c('M', 'F', 'U'))

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        fluidRow(
            style='padding: 30px;',
            toggleButton('toggleButton', "Toggle Button Demo",
                         choiceNames = c('Male', 'Female', 'Unknown'),
                         choiceValues = c('M', 'F', 'U')),
            adderInput('adder', "My Label", c('Starts with', 'Ends with', 'Contains', 'Is'), placeholder = "Enter Here",
                       toggle_button = tglBtn),
            dynamicWrapper(
                'myDynamicWrapper',
                adderInput('inner_adder', "My Label", c('Starts with', 'Ends with', 'Contains', 'Is'), placeholder = "Enter Here")
            ),
            radioButtonsOther('radOther', 'Radio Buttons w/ Other',
                              choiceNames = c('English', 'Spanish', 'Russian'),
                              choiceValues = c('E', 'S', NA)),
            radioButtonsOther('radOther2', 'Radio Buttons w/ Other 2',
                              choices = c('English', 'Spanish', 'Russian')),
            verbatimTextOutput('radOtherOutput'),
            verticalTabsetPanel(
                verticalTabPanel('Panel 1', tags$h2('Panel Content'), tags$p("Lorem Ipsum ... ")),
                verticalTabPanel('Panel 2', tags$h2('Panel Content'), tags$p("Lorem Ipsum ... ")),
                id = 'vtsp'
            ),
            actionButton('add_vtp', "New", icon('plus'))
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
    
    createNew <- function(id, label){tags$div(
        class='well',
        style='margin:8px;',
        adderInput(id, label, c('Starts with', 'Ends with', 'Contains', 'Is'), placeholder = "Enter Here")
    )}
    
    observeEvent(input$add_new, {
        randomX <- sample(1:100, 1)
        insertUI('#multi-container', 'beforeEnd', createNew(randomX, paste(randomX, 'Filter')))
    })
    
    output$table <- renderTable({
        df <- data.frame(
            labels = unlist(input$adder$labels),
            values = unlist(input$adder$values),
            stringsAsFactors = FALSE
        )
        df
    })
    
    output$toggle_btn <- renderText(input$toggleButton)
    
    data <- reactive({
        input$toggleButton
        print("Hi")
        print(input$inner_adder)
    })
    
    observeEvent(input$toggleButton, {
        data()
    })
    
    output$radOtherOutput <- renderText(input$radOther)
    
    observeEvent(input$add_vtp, {
        appendVerticalTab('vtsp', verticalTabPanel('New Panel', tags$h2('New New New')))
    })
    
}

shinyApp(ui, server)
