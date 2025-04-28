# Load required libraries
library(tidyverse)

# Load datasets
data_tips_predictions <- read_csv("_output/data_tips_predictions.csv")
coef_df <- read_csv("_output/coef_df.csv")

# Distribution of Prediction Errors
plot_distribution <- ggplot(data_tips_predictions, aes(prediction_error_abs)) +
  geom_density(fill = "#993366", alpha = 0.5, size = 0.5) +
  labs(
    title = "Distribution of Absolute Prediction Errors",
    x = "Absolute Prediction Error",
    y = "Density"
  ) +
  theme_minimal()

# Save plot as PNG
ggsave("_output/plot_distribution.png", plot = plot_distribution, width = 8, height = 6)

# Actual vs. Predicted Tip Amounts
plot_actual_vs_predicted <- ggplot(data_tips_predictions, aes(x = tip, y = predicted_tip)) +
  geom_point(aes(color = prediction_error_rel < 0.25), alpha = 0.6) +
  scale_color_manual(
    values = c("TRUE" = "#00B050", "FALSE" = "#C00000"),
    labels = c("Inaccurate (≥25%)", "Accurate (<25%)"),
    name = "Prediction Accuracy:"
  ) +
  labs(
    title = "Actual vs. Predicted Tip Amounts",
    x = "Actual Tip",
    y = "Predicted Tip"
  ) +
  theme_minimal() +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

# Save plot as PNG
ggsave("_output/plot_actual_vs_predicted.png", plot = plot_actual_vs_predicted, width = 8, height = 6)

# Model Coefficients (Feature Effects)
plot_model_coefficients <- coef_df %>%
  filter(variable != "(Intercept)") %>%
  ggplot(aes(x = reorder(variable, coefficient), y = coefficient)) +
  geom_col(fill = "#993366") +
  coord_flip() +
  labs(
    title = "Estimated Effects of Model Features",
    x = "Feature",
    y = "Coefficient"
  ) +
  theme_minimal()

# Save plot as PNG
ggsave("_output/plot_model_coefficients.png", plot = plot_model_coefficients, width = 8, height = 6)
