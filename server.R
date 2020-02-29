library(shiny)
library(ggplot2)
library(leaflet)
library(Cairo)

# Define server logic required to draw plots
shinyServer(function(input, output) {
    
    clubTitles <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vRjpWJG9GAN--7cPqRglmlyFZpRjd0l0Pcl2G9EQIX4lkRje9_BZEXCPaLpdFky5Th5y73HaWTM0EZ-/pub?output=csv")
    clubInfo <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTthOhJxcjCF7QmuktROn8sigt1CDvo3PB_Pkv6TWnaEKaeCfCJwGWbGnqPxiaveVTqIZE-Ng30Qhg4/pub?output=csv")
    
    output$titlesPlot <- renderPlot({
        filtTitles <- clubTitles[clubTitles$Club %in% input$clubNames, ]
        ggplot(filtTitles, aes(x = Year, y = Titles, color = Club)) +
            geom_step() + geom_point() +
            scale_y_continuous(breaks = seq(0, 10), limits = c(0, 10), minor_breaks = NULL) +
            scale_x_continuous(limits = c(1959, 2019), breaks = seq(1960, 2020, 10)) +
            ggtitle("Number of Titles per Year")
    })
    
    output$map <- renderLeaflet({
        filtInfo <- clubInfo[clubInfo$Club %in% input$clubNames, ]
        if (length(input$clubNames) > 0) {
            filtInfo$popup <- paste(filtInfo$Club, "-", filtInfo$Titles, "titles")
            clubIcons <- icons(iconUrl = filtInfo$Icon,
                               iconWidth = 31,
                               iconHeight = 31,
                               iconAnchorX = 31 / 2)
            filtInfo %>%
                leaflet() %>%
                addTiles() %>%
                addControl("Stadium Location", position = "topright") %>%
                addMarkers(icon = clubIcons, popup = filtInfo$popup, 
                           lng = filtInfo$Longitude, lat = filtInfo$Latitude)
        }
    })
})
