# Auto Visualization Dashboard 

## Project Description
An interactive & responsive web app where you can import a csv data and got the simple visualization right away. It is built using Rshiny and deployed in rshinyapps

## App Flow 
<img width="80%" alt="Screen Shot 2022-12-17 at 21 05 15" src="https://user-images.githubusercontent.com/72438807/208245846-6345aa5e-78ca-4d9e-8881-eb5ab3ee2cca.png">

In the Data sidebar, you can input csv data with Separator, Quote, and Display setting options. If the data is uploaded, then go to the Visualization sidebar to see the visualization. 


<img width="80%" alt="screencapture-arethalevi-shinyapps-io-dashboard-rshiny-2022-12-17-21_11_05" src="https://user-images.githubusercontent.com/72438807/208246209-263c53cd-584a-40cc-99e8-a7ce7dc0edbb.png">


In the visualization part, there are 4 basic charts visualization which user can select the variables they want to see using dropdown. 

- <b>Scatter Plot: </b> user can pick numerical variable for X axis and Y axis. 
- <b>Box Plot: </b> user can pick categorical variable for X axis and numerical variable for Y axis
- <b>Bar Chart: </b> user can pick a categorical variable
- <b>Density Plot: </b> user can pick a numerical variable

Note that the system will automatically separate numerical and categorical variables. So for example, in scatter plot visualization, the categorical variables will not be available to select from the dropdown, because scatter plot is only for numerical variables for X axis and Y axis. This applies to the other visualization too. 

The visualization made using PlotLy is interactive, user can zoom in and out, autoscale, and download the png. 

## 
You can visit the project [here](https://arethalevi.shinyapps.io/dashboard-rshiny/)
