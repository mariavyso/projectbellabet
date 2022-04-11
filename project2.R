## Start with cleaning data in our tables
daily_activity <- dailyActivity_merged %>%
  select(Id, ActivityDate,TotalSteps, TotalDistance, TrackerDistance, Calories)


sleepDay_merged$ActivityDate <- gsub('.{12}$', '', sleepDay_merged$SleepDay)
sleep_day <- sleepDay_merged %>%
  select(Id, ActivityDate, TotalMinutesAsleep)


hourlyCalories_merged$ActivityDate <- gsub('.{11}$', '', hourlyCalories_merged$ActivityHour)
calories_hour <- hourlyCalories_merged %>%
  select(Id, ActivityDate, Calories)


weightLogInfo_merged$ActivityDate <- gsub('.{11}$', '', weightLogInfo_merged$Date)
weightLogInfo_merged
weight <- weightLogInfo_merged %>%
  select(Id, ActivityDate, WeightPounds, BMI)


## put all our tables in one dataframe
df <- full_join(daily_activity,sleep_day)
df1 <- full_join(df, weight)

## clean names of columns
new_df <-clean_names(df1)
new_df %>% group_by(id)


## some different plots to find patterns
plot1 <- ggplot(data = new_df, mapping = aes( x = total_distance, y = calories)) + geom_line()+facet_wrap(facets = vars(id)) +
  labs(title = "Relationship between total distance of walk and calories burned by person")
                                                                                                                         
ggplot(data = new_df, mapping = aes( x = total_minutes_asleep, y = calories)) + 
  geom_line()+
  facet_wrap(facets = vars(id)) +
  labs(title = "Relationship between total minutes of sleep and calories burned by person")
