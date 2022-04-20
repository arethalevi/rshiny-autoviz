server <- function(input, output,session) {
  #reactive
  dataset <- reactive({
    req(input$file1)
    dat <- read.csv(input$file1$datapath,
                    header = input$header,
                    sep = input$sep,
                    quote = input$quote)
    #define numerical variables
    numvar <- select_if(dat,is.numeric)
    
    #define categorical variables
    catvar <- select(dat, -any_of(names(numvar)))
    
    #update select input above
    updateSelectInput(session,"scat_x",choices=names(numvar))
    updateSelectInput(session,"scat_y",choices = names(numvar))
    updateSelectInput(session,"bo",choices=names(catvar))
    updateSelectInput(session,"box_x",choices=names(catvar))
    updateSelectInput(session,"box_y",choices=names(numvar))
    updateSelectInput(session,"dens",choices=names(numvar))
    dat
  })
  
  categories<- reactive({levels(factor(dataset()[[input$bo]]))})
  
  #output tabeldataset
  output$contents <- renderTable({
    df <- dataset()
    if(input$disp == "head") {
      return(head(df))
    }
    else {
      return(df)
    }
  })
  
  #output viz - plot -a  
  output$plota <- renderPlotly({
    ggplotly(ggplot(data = dataset(),
                    mapping=aes(x=dataset()[[input$scat_x]],y=dataset()[[input$scat_y]],
                                text=paste("X:",dataset()[[input$scat_x]],
                                           "<br>Y:",dataset()[[input$scat_y]])))+
               geom_point(color="cornflowerblue")+
               geom_smooth(formula = y~x,method="lm")+
               labs(title=sprintf("Scatter plot of %s and %s",input$scat_x,input$scat_y),
                    x=input$scat_x,
                    y=input$scat_y)+
               theme_light()
             ,tooltip="text")
  })
  
  #output viz - plot -b
  output$plotb <- renderPlotly({
    ggplotly(ggplot(data=dataset(),aes(x= .data[[input$bo]],
                                       text=after_stat(paste("Category:",categories()[x],
                                                             "<br>Count:",count))))+
               geom_bar(fill='seagreen3',color="black")+
               labs(title=sprintf("Bar chart of %s",input$bo),
                    x=input$bo,y="Frequency")+
               theme_light(),
             tooltip="text")
  })
  
  #output viz - plot -c
  output$plotc <- renderPlotly({
    ggplotly(ggplot(data=dataset(), aes(x=dataset()[[input$box_x]],y=dataset()[[input$box_y]],
                                        text=paste("Category:",dataset()[[input$box_x]],
                                                   "<br>Value:",dataset()[[input$box_y]])))+
               geom_point(aes(color=dataset()[[input$box_x]]),alpha=0.6)+
               geom_boxplot(alpha=0.3,colour="brown")+
               labs(title=sprintf("Boxplot of %s and %s",input$box_x,input$box_y),
                    x=input$box_x, y=input$box_y)+
               guides(colour=FALSE)+
               theme_light(),
             tooltip="text")
    
  })
  
  #output viz - plot -d
  output$plotd <- renderPlotly({
    ggplotly(
      ggplot(data=dataset(),aes(x=dataset()[[input$dens]],
                                text=paste("")))+
        geom_density(fill="indianred3")+
        labs(title = sprintf("Density plot of %s",input$dens),x=input$dens, y="density")+
        theme_light()
    ,tooltip="text")
    
  })
}