library(magrittr)
library(dplyr)
library(tidyr)
library(ggplot2)


# Question 1
# Plot the county and state data using maps  
temp_q1<-nh %>%
  select(Federal.Provider.Number, Provider.Zip.Code ,County, Provider.State)%>%
  distinct()
  
nh_by_county<-plyr::count(temp_q1,c("County","Provider.State"))
nh_by_state<-plyr::count(temp_q1,c("Provider.State"))
nh_by_zip<-plyr::count(temp_q1,c("Provider.Zip.Code"))

# Question 2
temp_q2<-nh%>%
  select(Federal.Provider.Number, Provider.Name, Provider.Zip.Code, County, Provider.State, Shortage.of.Aides,Shortage.of.Clinical.Staff, Shortage.of.Nursing.Staff, Shortage.of.Other.Staff )%>%
  mutate(Shortage.of.Aides=sub("Y",1,Shortage.of.Aides))%>%
  mutate(Shortage.of.Aides=sub("N",0,Shortage.of.Aides))%>%
  mutate(Shortage.of.Clinical.Staff=sub("Y",1,Shortage.of.Clinical.Staff))%>%
  mutate(Shortage.of.Clinical.Staff=sub("N",0,Shortage.of.Clinical.Staff))%>%
  mutate(Shortage.of.Nursing.Staff=sub("Y",1,Shortage.of.Nursing.Staff))%>%
  mutate(Shortage.of.Nursing.Staff=sub("N",0,Shortage.of.Nursing.Staff))%>%
  mutate(Shortage.of.Other.Staff=sub("Y",1,Shortage.of.Other.Staff))%>%
  mutate(Shortage.of.Other.Staff=sub("N",0,Shortage.of.Other.Staff))%>%
  mutate_at(vars(Shortage.of.Aides), funs(as.numeric))%>%
  mutate_at(vars(Shortage.of.Clinical.Staff), funs(as.numeric))%>%
  mutate_at(vars(Shortage.of.Nursing.Staff), funs(as.numeric))%>%
  mutate_at(vars(Shortage.of.Other.Staff), funs(as.numeric))

# Shortages of aides, nursing staff, clinical staff, and other staff by facilities (computed as total number of weeks)
staff_shortages_facilities<- temp_q2 %>%
  group_by(Federal.Provider.Number)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)

# Shortages of aides, nursing staff, clinical staff, and other staff by zip code (computed as average number of weeks)
staff_shortages_zip<- temp_q2 %>%
  group_by(Provider.Zip.Code)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)%>%
  left_join(nh_by_zip, by = c("Provider.Zip.Code")) %>%
  mutate(avg_aides=(Shortage.of.Aides/freq), avg_clinical=(Shortage.of.Clinical.Staff/freq), avg_nursing=(Shortage.of.Nursing.Staff/freq), avg_other=(Shortage.of.Other.Staff/freq) )%>%
  

# Shortages of aides, nursing staff, clinical staff, and other staff by counties (computed as average number of weeks)
staff_shortages_counties<- temp_q2 %>%
  group_by(County, Provider.State)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)%>%
  left_join(nh_by_county, by = c("County", "Provider.State")) %>%
  mutate(avg_aides=(Shortage.of.Aides/freq), avg_clinical=(Shortage.of.Clinical.Staff/freq), avg_nursing=(Shortage.of.Nursing.Staff/freq), avg_other=(Shortage.of.Other.Staff/freq) )

# Shortages of aides, nursing staff, clinical staff, and other staff by states (computed as average number of weeks)
staff_shortages_states<- temp_q2 %>%
  group_by( Provider.State)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)%>%
  left_join(nh_by_state, by = c("Provider.State")) %>%
  mutate(avg_aides=(Shortage.of.Aides/freq), avg_clinical=(Shortage.of.Clinical.Staff/freq), avg_nursing=(Shortage.of.Nursing.Staff/freq), avg_other=(Shortage.of.Other.Staff/freq) )

# Shortages of aides, nursing staff, clinical staff, and other staff national level (computed as average number of weeks)
staff_shortages_national_avg<- temp_q2 %>%
  group_by(Federal.Provider.Number)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)%>%
  mutate(country="US") %>%
  group_by(country)%>%
  summarise_at(vars(Shortage.of.Aides: Shortage.of.Other.Staff), sum, na.rm = TRUE)%>%
  mutate(avg_aides=(Shortage.of.Aides/15412), avg_clinical=(Shortage.of.Clinical.Staff/15412), avg_nursing=(Shortage.of.Nursing.Staff/15412), avg_other=(Shortage.of.Other.Staff/15412))

# Question 3 same as question 2

# Question 4 
# Beds and ventilator metrics by facilities. You need to adjust for time
beds_ventilators_facilities<- nh %>%
  select(Federal.Provider.Number, Provider.Name, Provider.Zip.Code, County, Provider.State, Number.of.All.Beds, Total.Number.of.Occupied.Beds, Number.of.Ventilators.in.Facility, Number.of.Ventilators.in.Use.for.COVID.19)%>%
  mutate(Number.of.beds.available=(Number.of.All.Beds-Total.Number.of.Occupied.Beds), Ventilator.Ratio=Number.of.Ventilators.in.Use.for.COVID.19/Number.of.Ventilators.in.Facility) 

# Beds and ventilator metrics by counties. You need to adjust for time
beds_ventilators_counties<- nh %>%
  select(Federal.Provider.Number, Provider.Name, Provider.Zip.Code, County, Provider.State, Number.of.All.Beds, Total.Number.of.Occupied.Beds, Number.of.Ventilators.in.Facility, Number.of.Ventilators.in.Use.for.COVID.19)%>%
  mutate(Number.of.beds.available=(Number.of.All.Beds-Total.Number.of.Occupied.Beds), Ventilator.Ratio=Number.of.Ventilators.in.Use.for.COVID.19/Number.of.Ventilators.in.Facility)%>%
  group_by(County)
  

