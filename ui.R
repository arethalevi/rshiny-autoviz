library("shinydashboard")
library("shiny")
library("ggplot2")
library("dplyr")
library("plotly")
#############
ui <- dashboardPage(skin='red',
                    dashboardHeader(title = "Viz Dashboard"),
                    ## Sidebar content
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Data", tabName = "dashboard"), 
                        menuItem("Visualization", tabName = "plot")
                      ) ),
                    
                    ## Body content
                    dashboardBody(
                      tabItems(
                        tabItem(tabName = "dashboard",
                                fluidPage(titlePanel("DATA"),
                                          fluidRow(
                                            column(width=4,
                                                   fileInput("file1", "Input your CSV file here",
                                                             multiple = TRUE,
                                                             accept = c("text/csv",
                                                                        "text/comma-separated-values,text/plain",
                                                                        ".csv"))),
                                            column(width=2,checkboxInput("header", "Header", TRUE)),
                                            column(width=2,radioButtons("sep","Separator",
                                                                        choices = c(Comma=",",
                                                                                    Semicolon = ";",
                                                                                    Tab = "\t"),
                                                                        selected = ",")),
                                            column(width=2,radioButtons("quote", "Quote",
                                                                        choices = c(None = "",
                                                                                    "Double Quote" = '"',
                                                                                    "Single Quote" = "'"),
                                                                        selected = '"')),
                                            column(width=2,radioButtons("disp", "Display",
                                                                        choices = c(Head = "head",
                                                                                    All = "all"),
                                                                        selected = "head"))
                                          ),
                                          tableOutput("contents")
                                )),
                        
                        tabItem(tabName="plot",
                                fluidRow(
                                  column(6, h3("Scatter plot"),
                                         selectInput("scat_x","X variable for scatter plot: ",choices = "Input data"),
                                         selectInput("scat_y","Y variable for scatter plot: ",choices = "Input data"),
                                         box(
                                           title = "Scatter plot",
                                           status= "primary",
                                           solidHeader = TRUE,
                                           collapsible = TRUE,
                                           width=NULL,
                                           plotlyOutput("plota"))),
                                  column(6, h3("Boxplot"),
                                         selectInput("box_x","X variable for boxplot: ",choices = "Input data"),
                                         selectInput("box_y","Y variable for boxplot: ",choices = "Input data"),
                                         box(
                                           title = "Box plot",
                                           status= "primary",
                                           solidHeader = TRUE,
                                           collapsible = TRUE,
                                           width = NULL,
                                           plotlyOutput("plotc")))
                                  
                                ),
                                fluidRow(
                                  column(6,
                                         h3("Bar Chart"),
                                         selectInput("bo","Variable for bar chart:",choices = "Input data"),
                                         box(
                                           title = "Bar Chart",
                                           status= "primary",
                                           solidHeader = TRUE,
                                           collapsible = TRUE,
                                           width = NULL,
                                           plotlyOutput("plotb"))),
                                  column(6, h3("Density plot"),
                                         selectInput("dens","Variable for density plot: ",choices = "Input data"),
                                         box(
                                           title = "Density plot",
                                           status= "primary",
                                           solidHeader = TRUE,
                                           collapsible = TRUE,
                                           width=NULL,
                                           plotlyOutput("plotd")))
                                )
                                
                        )
                      )
                    ))
