# Load required libraries
library(tidyverse)
library(glmulti)

# Load dataset
data_tips_raw <- read_csv("_data/data_tips_raw.csv")

# Prepare and clean dataset
data_tips <- data_tips_raw %>%
  mutate(
    gender = factor(gender),
    smoker = factor(smoker),
    day = factor(day),
    time = factor(time)
  )

# Save prepared dataset
write_csv(data_tips, file = "_output/data_tips.csv")

# Build the model using glmulti
model_tip_glmulti <- glmulti(
  tip ~ total_bill + gender + smoker + day + time + size,
  data = data_tips,
  level = 2,
  method = "h",
  crit = "aic",
  confsetsize = 5
)

# Extract the best model
best_model <- model_glmulti@objects[[1]]

# Save best model
saveRDS(best_model, file = "_output/model_predict_tip.rds")

# Make predictions on the training dataset
data_tips_predictions <- data_tips %>%
  mutate(
    predicted_tip = round(predict(best_model, newdata = .), 2),
    prediction_error_abs = round(abs(predicted_tip - tip), 2),
    prediction_error_rel = round(prediction_error / tip, 2)
  )

# Save prediction dataset
write_csv(data_tips_predictions, "_output/data_tips_predictions.csv")

# Create a prediction function for new data
predict_tip <- function(total_bill = NA, gender = NA, smoker = NA, day = NA, time = NA, size = NA) {
  # Prepare new data input
  new_data <- data.frame(
    total_bill = ifelse(is.na(total_bill), mean(data_tips$total_bill, na.rm = TRUE), total_bill),
    gender = factor(ifelse(is.na(gender), "Male", gender), levels = levels(data_tips$gender)),
    smoker = factor(ifelse(is.na(smoker), "No", smoker), levels = levels(data_tips$smoker)),
    day = factor(ifelse(is.na(day), "Sun", day), levels = levels(data_tips$day)),
    time = factor(ifelse(is.na(time), "Dinner", time), levels = levels(data_tips$time)),
    size = ifelse(is.na(size), mean(data_tips$size, na.rm = TRUE), size)
  )
  
  # Predict tip amount
  predicted_tip <- predict(best_model, newdata = new_data) %>%
    round(2)
  
  return(predicted_tip)
}

# Example usage of the prediction function
predict_tip(
  total_bill = 50, 
  gender = "Male", 
  smoker = "No", 
  day = "Fri", 
  time = "Dinner", 
  size = 2
)