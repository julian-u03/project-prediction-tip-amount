# load librarys
library(tidyverse)
library(glmulti)

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
model_glmulti <- glmulti(
  tip ~ total_bill + gender + smoker + day + time + size,
  data = data_tips,
  level = 2,        # bis zu Interaktionen (1 = nur Haupteffekte, 2 = + Interaktionen)
  method = "h",     # heuristische Suche (schneller)
  crit = "aic",     # Kriterium (AIC minimieren)
  confsetsize = 5   # wie viele Modelle merken
)

# Bestes Modell anschauen
best_model <- lm(summary(model_glmulti)$bestmodel, data = data_tips)

data_tips$predict <- predict(best_model, newdata = data_tips)
