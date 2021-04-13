#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Online Two Sample T Test with plot"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            # Add instructions for use
            p("Welcome to my online two sample t.test with plot Shiny App"),
            p("Please provide two sample files with one measurement per line"),
            p("Headers are fine, but please tick/untick the headers box as appropriate"),
            p("Then Press 'Go!'"),
            
            # Define sample A input file
            fileInput("file1", "Sample A File",
                      accept = c(
                          "text/csv",
                          "text/comma-separated-values,text/plain",
                          ".csv")
            ),
            # Define sample B input file
            fileInput("file2", "Sample B File",
                      accept = c(
                          "text/csv",
                          "text/comma-separated-values,text/plain",
                          ".csv")
            ),
            tags$hr(),
            # Add check box to identify if there are headers in the input file
            checkboxInput("header", "Header", TRUE),
            tags$head(tags$script(src = "message-handler.js")),
            # Add an action button to plot the files and perform the t.tesr
            actionButton("do", "Go!")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            # Display the density plot
            plotOutput("distPlot"),
            # Display the output of the t.test
            verbatimTextOutput("txt")
        )
    )
))