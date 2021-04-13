#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    observeEvent(input$do, {
        output$distPlot <- renderPlot({
            # Grab the input file and stop if it is null
            inFile1 <- input$file1
            if (is.null(inFile1))
                return(NULL)
            
            # Grab the input file and stop if it is null      
            inFile2 <- input$file2
            if (is.null(inFile2))
                return(NULL)
            
            # Read in the two files    
            sample1 <- read.csv(inFile1$datapath, header = input$header)
            sample2 <- read.csv(inFile2$datapath, header = input$header)
        
            # Convert into data.frames and add a sample column (a or b)
            sample1 <- data.frame(measure=sample1,sample=c('a'))
            sample2 <- data.frame(measure=sample2,sample=c('b'))
            
            # Add column names
            colnames(sample1) <- c('measure','sample')
            colnames(sample2) <- c('measure','sample')
   
            # Combine data.fames into a single data frame for plotting
            samples <- rbind(sample1, sample2)
            colnames(samples) <- c('measure','sample')
            
            # Perform t.test and store output
            my.t.test <- t.test(measure ~ sample, data=samples,  alternative = "two.sided", var.equal = FALSE)
           
            # Plot densities
            ggplot(samples, aes(measure, fill=sample)) + 
                geom_density(alpha = 0.2) +
                geom_vline(xintercept = mean(sample1$measure), color="red") +
                geom_vline(xintercept = mean(sample2$measure), color="blue") +
                geom_text(mapping = aes(x = mean(sample1$measure),
                                        y = 0,
                                        label = "A mean", vjust = -1)) +                                    
                geom_text(mapping = aes(x = mean(sample2$measure),
                                        y = 0,
                                        label = "B mean", vjust = -1)) 
                 
      
        })
        
        # Send output of t.test to output$txt
        output$txt <- renderPrint({print(my.t.test)})
    })
})