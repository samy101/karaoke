#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)

# urls = c("https://raw.githubusercontent.com/samy101/karaoke/master/www/agaya.mp3",
#          "https://raw.githubusercontent.com/samy101/karaoke/master/www/inbame.mp3",
#          "https://raw.githubusercontent.com/samy101/karaoke/master/www/kannizhandha.mp3")

urls = read.csv("urls.csv", stringsAsFactors = F)$urls



ui <- dashboardPage( 
    
    #useShinyjs(),
    
    dashboardHeader(title = "Karaoke Guess"),
    dashboardSidebar(disable = TRUE),
    dashboardBody(
        fluidRow(
            box(status = "primary", align = "center",
                
                fluidRow(uiOutput('my_audio')),
                br(),
                fluidRow(
                    # actionButton("play", h5("Play Next Karaoke"))
                    actionBttn(
                        inputId = "play",
                        label = "Play next",
                        style = "jelly",
                        color = "success",
                        icon = icon("play")
                    ))
            )
        )
    )
)


# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#     
#     useShinyjs(),
#     
#     tags$script('volumeChange = function(){document.getElementById("my_audio_player").volume = 0.3;}'),
#     
# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
#         
#         
#         #calibration slider
#         #sliderInput("levelSlider", "Level:",min = 0, max = 1, value = 0.3),
#         # calibrate level button
#         
#         
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             #actionButton("play", "Play next Karaoke", onclick=paste0("volumeChange(0.3)")),
#             actionButton("play", "Play next Karaoke"),
#            #plotOutput("distPlot"),
#            uiOutput('my_audio')
#            #textOutput("text"),
#            #actionButton("NextButton", "Next button")
#         )
#     )
# )

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    # Render the audio player
    # output$my_audio <- renderUI({
    #     
    #     # url <- input$my_url
    #     # 
    #     # tags$audio(id='my_audio_player',
    #     #            controls = "controls",
    #     #            tags$source(
    #     #                src = 'https://raw.githubusercontent.com/samy101/karaoke/master/www/inbame.mp3'))
    #     
    # })
    
    get_audio_tag <- function(filename) {
        tags$audio(src = filename,
                   type = "audio/mp3",
                   autoplay = T,
                   controls = "controls")
    }
    
    
    observeEvent(input$play, {
        
        ix = sample(1:length(urls), 1)
        
        url = urls[ix]
        print(url)
        
        output$my_audio <-renderUI(get_audio_tag(url))
        
        
        # #removeUI(selector = "#play")
        # insertUI(selector = "#play",
        #          where = "afterEnd",
        #          immediate = TRUE,
        #          ui = tags$audio(src = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3", 
        #                          type = "audio/mp3", 
        #                          autoplay = T, 
        #                          controls = "controls")  
        # )
        
    })
    
    output$text <- renderText({
        #document.getElementById("my_audio_player")
    })
    
    
    

}

# Run the application 
shinyApp(ui = ui, server = server)
