# Homework 1
# Jordan Lian
# Section 01

library(tidyverse)
setwd('C:/Users/Jordan Lian/OneDrive - Northeastern University/Spring 2021/IE 6600/Assignment 1')

# Problem 1-----------------------------------

  # 1. Read the two data files in R Studio
    # Original Files
    origin_roster <- read_csv("roster.csv")
    origin_attendance <- read_csv("attendance.csv")
  
    # Copy Data Frames to Modify
    roster <- origin_roster
    attendance <- origin_attendance
  
  ' 2. Write a code to aggregate attendance, i.e., how many lectures were attended by each student. 
  If a student has not attended any lectures, set the value as zero. The code should be effective 
  in case of multiple instances of the same first name or last name (or both). These values must be updated in the roster.'
    # Combine first and last name in attendance data frame to match up with roster, create new column
    attendance$fullname <- paste(attendance$lastname, attendance$firstname, sep=", ")
    
    # Create new data frame using a table which gets the counts of the names
    attendance_count <- as.data.frame(table(attendance$fullname))
    colnames(attendance_count) <- c("names", "freq")
    
    # Put values into roster, use match() to match the names from the roster and attendance_count dataset
    roster$Count = attendance_count$freq[match(roster$names, attendance_count$names)]
    
    # Where values are NA, mark attendance as 0
    roster$Count[is.na(roster$Count)] <- 0
    
    # Separate first and last names, reorder the columns to print first name before last name
    roster <- roster %>% separate(names, c("Last Name", "First Name"), sep = ", ")
    roster <- roster[, c(2, 1, 3)]
    
  # 3. The output of the code should generate a roster data frame as given below.
  roster
  
# Problem 2-----------------------------------
wine_data <- read_csv("wine_data.csv")

  # 1. Write a code to calculate the frequency count of "variety" variable from the dataset. Display top 10 variety by count (10 points)
    # Create table, change column names
    var_freq <- as.data.frame(table(wine_data$variety))
    colnames(var_freq) <- c("variety", "freq")
    
    # Get top 10 values, and arrange in descending order
    var_top10 <- var_freq %>% 
      top_n(10, freq) %>%
      arrange(desc(freq))

  # 2. Write a code to calculate the average points by country (10 points)
  avg_pts <- wine_data %>% 
    group_by(country) %>%
    summarise(avg_points = mean(points)) 

  # 3. Which province has the highest average price? (10 points)
    # Modify data frame to get average price based off province
    price <- wine_data %>% 
      group_by(province) %>%
      summarise(avg_price = mean(price, na.rm = T))
    
    # Print province with highest average price
    max_price <- price %>% 
      top_n(1, avg_price)
    
  # 4. Which province in the US has the highest average price? (10 points)
    # Modify data frame, where the country must be the US
    US_price <- wine_data[wine_data$country == "US",] %>%
      group_by(province) %>%
      summarise(avg_price = mean(price, na.rm = T))

    # Print US province with highest average price
    max_price <- US_price %>% 
      top_n(1, avg_price)
    
  # 5. From the "designation" variable calculate the number of 20 year old wine (20 points) - solve
    # Use filter() and grepl() to modify the data frame to wines with 20 years in their description
    wine20 <- wine_data %>% 
      filter(grepl("20-Year|20-year|20-Years|20 Anos|20 Year|20 Years|20-Year-Old|20 yr.|20 Yr.|20th Anniversary|20 Anni", wine_data$designation))
    
    # Count total rows
    num_20 <- count(wine20)