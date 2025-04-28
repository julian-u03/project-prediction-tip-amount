# Tipping the Scale: A Machine Learning Dive Into Restaurant Data

This project aims to predict the tip amount using a regression model based on various factors such as the total bill, gender, smoker status, day of the week, time of day, and the size of the party. The model was built using the `glmulti` package in R, which allows for model selection based on the AIC criterion.

## Dataset

The dataset used for this project consists of the following variables:

- `total_bill`: The total bill amount.
- `tip`: The tip amount.
- `gender`: Gender of the customer (Male, Female).
- `smoker`: Whether the customer is a smoker (Yes, No).
- `day`: Day of the week when the transaction took place (Fri, Thur, Sat, Sun).
- `time`: Time of the meal (Dinner, Lunch).
- `size`: Number of people in the party.

## Model

The regression model is built using the `glmulti` function, which selects the best model based on the Akaike Information Criterion (AIC). The predictors in the model include:

- `total_bill`
- `gender`
- `smoker`
- `day`
- `time`
- `size`

A function named `predict_tip` was created to make predictions on new data based on the model.

## Prediction Function

The function `predict_tip()` takes the following parameters to predict the tip amount:

- `total_bill`: Total bill amount (numeric).
- `gender`: Gender of the customer (character, "Male" or "Female").
- `smoker`: Smoker status (character, "Yes" or "No").
- `day`: Day of the week (character, one of "Fri", "Thur", "Sat", "Sun").
- `time`: Time of day ("Dinner" or "Lunch").
- `size`: Party size (numeric).

### Example Usage:

```r
predict_tip(
  total_bill = 50, 
  gender = "Male", 
  smoker = "No", 
  day = "Fri", 
  time = "Dinner", 
  size = 2
)
```

## Model Evaluation

The following metrics were calculated to evaluate the model's performance:

 - R²: The coefficient of determination.
 - AIC: Akaike Information Criterion, used to compare models.
 - MSE: Mean Squared Error, the average squared difference between actual and predicted values.
 - RMSE: Root Mean Squared Error, the square root of MSE.
 - Residuals: The difference between the observed and predicted tip amounts.
 - Coefficients: The estimated coefficients for each predictor in the model.
 - VIF: Variance Inflation Factor, used to detect multicollinearity.

## Visualizations

The following visualizations were created to assess model performance and interpret the results:

### Distribution of Prediction Errors: A plot showing the distribution of the absolute prediction errors.

<img align="left" src="https://github.com/julian-u03/project-prediction-tip-amount/blob/main/_output/plot_distribution.png">

</br>

### Actual vs. Predicted Tip Amounts: A scatter plot comparing the actual tip amounts to the predicted values, with color-coding to highlight accurate vs. inaccurate predictions.

<img align="left" src="https://github.com/julian-u03/project-prediction-tip-amount/blob/main/_output/plot_actual_vs_predicted.png">

</br>

### Model Coefficients (Feature Effects): A bar plot showing the estimated effect of each feature in the model.

<img align="left" src="https://github.com/julian-u03/project-prediction-tip-amount/blob/main/_output/plot_model_coefficients.png">

</br>

## Conclusion
The regression model provides an effective way to predict tip amounts based on various factors. The model evaluation metrics (R², AIC, MSE, RMSE, and VIF) indicate its performance and reliability. The visualizations help in interpreting the results, highlighting the distribution of prediction errors, the accuracy of predictions, and the impact of each feature on the model's predictions.
