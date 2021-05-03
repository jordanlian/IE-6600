library(tidyverse)
library(ggplot2)

setwd("C:/Users/Jordan Lian/OneDrive - Northeastern University/Spring 2021/IE 6600/Assignment 4")

'Question 1 (20 points) From the New York collision dataset create the following parallel coordinate plot'

  # Original Plot
  library(GGally)
  origin_df <- read_csv("ny_accidents.csv")
  df <- origin_df
  names_vec <- colnames(df)[13:18]
  df <- df[!is.na(df$BOROUGH),]
  par_cord <- aggregate(cbind(df$`NUMBER OF PEDESTRIANS INJURED`, 
                              df$`NUMBER OF PEDESTRIANS KILLED`, 
                              df$`NUMBER OF CYCLIST INJURED`, 
                              df$`NUMBER OF CYCLIST KILLED`,
                              df$`NUMBER OF MOTORIST INJURED`,
                              df$`NUMBER OF MOTORIST KILLED`),
                        by=list(Category=df$BOROUGH), FUN=sum)
  
  colnames(par_cord) <- c("BOROUGH", names_vec)
  ggparcoord(par_cord, columns = 2:7, groupColumn = 1,
             showPoints = TRUE,
             title = "Parallel Coordinate Plot for NY Collisions",
             scale="globalminmax") + scale_x_discrete(guide = guide_axis(n.dodge=2))
  
  # Improved Solution

  # Combine two stacked columns with borough column, 

    # Injured data frame
    injured <- cbind(par_cord$BOROUGH,stack(par_cord[,c(2, 4, 6)]))
    colnames(injured) <- c("BOROUGH", "Values", "Accident")
    injured
    
    # Killed data frame
    killed <- cbind(par_cord$BOROUGH, stack(par_cord[,c(3, 5, 7)]))
    colnames(killed) <- c("BOROUGH","Values", "Accident")
    killed
    
    # Injured heat map
    ggplot(injured, aes(fill=Values, y=Accident, x=BOROUGH)) +
      geom_tile() +
      ggtitle("Injured Heat Map")
    
    # Killed heat map
    ggplot(killed, aes(fill=Values, y=Accident, x=BOROUGH)) +
      geom_tile() +
      ggtitle("Killed Heat Map")
  
'Question 2 (60 points)
From the link (http://profiles.doe.mass.edu/statereport/sat.aspx) download the average
SAT scores for the year 2013-14 and create the following plots'

  # Read Data
  library(readxl)
  origin_data <- read_excel('sat_performance.xlsx')
  data <- origin_data
  colnames(data)[2] <- c("District_Code")
  
  # For paired correlation
  ggpairs(data[,4:6])
  
  # For boxplot
  library(reshape2)
  ggplot(data = melt(data[,4:6]), aes(x=variable, y=value)) + 
    geom_boxplot(aes(fill=variable)) +
    xlab("Test Subjects") +
    ylab("Average Test Score") +
    labs(fill="Subject") +
    ggtitle("Boxplot for Reading, Writing, and Math Test Scores")
  
  # For density
  mod_data <- stack(data[,4:6])
  colnames(mod_data) <- c("Score", "Subject")
  ggplot(mod_data, aes(x=Score)) + 
    geom_density(aes(group=Subject, colour=Subject, fill=Subject), alpha=0.5) +
    ylab("Density") +
    ggtitle("Density Plot for Reading, Writing, and Math Test Scores")

'Question 3 (20 points)
Create a visualization that captures the relation between Avg. SAT scores (use data from question 2)
and median household income in that school district. For the median household income of the school districts use
http://www.usa.com/rank/massachusetts-state--median-household-income--school-district-rank.htm
Write your observations from the visualization'

income <- read_excel('median_income.xlsx')
colnames(income)[2] <- c("Income")
data$Income <- income$Income[match(data$District_Code, income$Code)]
data$Overall <- data$Reading + data$Writing + data$Math

library(ggpubr)
ggplot(data, aes(x=Income, y=Overall)) + 
  geom_point() +
  xlab("Median Household Income") +
  ylab("Average SAT Score") +
  ggtitle("Average SAT Scores vs Median Household Income") +
  stat_cor(label.x = 150000, label.y = 1500) +
  geom_smooth(method='auto')