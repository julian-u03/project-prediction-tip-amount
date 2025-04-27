# load librarys
library(tidyverse)

# load data
data_tips_raw <- read_csv("_data/data_tips.csv")

# prepare data
data_tips <- data_tips_raw %>%
  mutate(
    gender = factor(gender),
    smoker = factor(smoker),
    day = factor(day),
    time = factor(time)
  )

# create model
model_tips <- lm(tip ~ total_bill + gender + smoker + day + time + size, data = data_tips)

# function for prediction
predict_tip <- function(total_bill = NA, gender = NA, smoker = NA, day = NA, time = NA, size = NA){
  new_data <- data.frame(
    total_bill = ifelse(is.na(total_bill), mean(data_tips$total_bill, na.rm = TRUE), total_bill),
    gender = factor(ifelse(is.na(gender), "Male", gender), levels = levels(data_tips$gender)),
    smoker = factor(ifelse(is.na(smoker), "No", smoker), levels = levels(data_tips$smoker)),
    day = factor(ifelse(is.na(day), "Sun", day), levels = levels(data_tips$day)),
    time = factor(ifelse(is.na(time), "Dinner", time), levels = levels(data_tips$time)),
    size = ifelse(is.na(size), mean(data_tips$size, na.rm = TRUE), size)
  )
  predicted_tip <- predict(model_tips, newdata = new_data)
  return(predicted_tip)
}

predict_tip(total_bill = 50, gender = "Male", smoker = "No", day = "Fri", time = "Dinner", size = 2)
