# Load required libraries
library(tidyverse)
library(car) # for vif()

# Load data and model
data_tips <- read_csv("_output/data_tips.csv")
model_predict_tip <- readRDS("_output/model_predict_tip.rds")

# Load coefficients
# Extract coefficients from the model and format them into a data frame
coef_df <- as.data.frame(coef(model_predict_tip))
coef_df$variable <- rownames(coef_df)
colnames(coef_df) <- c("coefficient", "variable")
write_csv(coef_df, file = "_output/coef_df.csv")

# Performance Evaluation
summary(model_predict_tip)

# R²
r_squared <- 1 - (logLik(model_predict_tip) / logLik(lm(tip ~ 1, data = data_tips)))

# AIC (Akaike Information Criterion)
aic_value <- AIC(model_predict_tip)

# MSE (Mean Squared Error) and RMSE (Root Mean Squared Error)
mse_value <- mean(residuals(model_predict_tip)^2)
rmse_value <- sqrt(mse_value)

# Residual analysis
residuals <- residuals(model_predict_tip)

# Residuals visualization
ggplot(data_tips, aes(x = residuals)) +
  geom_histogram(binwidth = 0.1, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Residuals Distribution", x = "Residuals", y = "Frequency") +
  theme_minimal()

# Significance of variables
coefficients_summary <- summary(model_predict_tip)$coefficients

# VIF (Variance Inflation Factor) to check for multicollinearity
vif_values <- vif(model_predict_tip, type = 'predictor')
