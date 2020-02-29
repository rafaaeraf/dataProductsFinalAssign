library(shiny)
library(leaflet)
library(Cairo)
library(ggplot2)

# Define UI for application
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Brazil's National Male Football Championship"),
    
    # Sidebar with a selection of clubs to be shown
    sidebarLayout(
        sidebarPanel(
            width = 2,
            checkboxGroupInput("clubNames", "Select clubs:",
                               c('Atletico Mineiro' = 'Atletico Mineiro',
                                 'Atletico Paranaense' = 'Atletico Paranaense',
                                 'Bahia' = 'Bahia',
                                 'Botafogo' = 'Botafogo',
                                 'Corinthians' = 'Corinthians',
                                 'Coritiba' = 'Coritiba',
                                 'Cruzeiro' = 'Cruzeiro',
                                 'Flamengo' = 'Flamengo',
                                 'Fluminense' = 'Fluminense',
                                 'Gremio' = 'Gremio',
                                 'Guarani' = 'Guarani',
                                 'Internacional' = 'Internacional',
                                 'Palmeiras' = 'Palmeiras',
                                 'Santos' = 'Santos',
                                 'Sao Paulo' = 'Sao Paulo',
                                 'Sport' = 'Sport',
                                 'Vasco da Gama' = 'Vasco da Gama')) 
        ),
        
        # Show plots
        mainPanel(
            p("This application shows the number of titles in Brazil's National Male Football Championship per year. It also shows the stadium location of each club.
              Only the clubs that have at least one title are available. \nTo see the plots, just select the clubs names on the checkbox."),
            plotOutput("titlesPlot", height = "240"),
            leafletOutput("map", height = "310"),
            width = 10
        )
    )
))
