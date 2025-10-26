library(readr)
library(dplyr)
library(glmnet)
library(caret)
library(tidyr)

if (file.exists("../data/train.csv")) {
  train <- read_csv("../data/train.csv", show_col_types = FALSE)
} else if (file.exists("src/data/train.csv")) {
  train <- read_csv("src/data/train.csv", show_col_types = FALSE)
} else {
  stop("train.csv not found!")
}
cat("train is read and relevant packages are imported!\n")

train <- train %>%
  drop_na() %>%
  distinct() %>%
  mutate(Sex = ifelse(Sex == "male", 0, 1))
cat("Duplicates and na are dropped! male is set to 0 and female is set to 1!\n")

features <- c("Pclass", "Sex", "Age")
X <- train[, features]
y <- train$Survived

model <- glm(Survived ~ Pclass + Sex + Age, data = train, family = "binomial")
cat("I use Pclass, sex and age to predict.\n")

y_pred_train_prob <- predict(model, newdata = X, type = "response")
y_pred_train <- ifelse(y_pred_train_prob > 0.5, 1, 0)
train_acc <- mean(y_pred_train == y)
cat(sprintf("accuracy: %.3f\n", train_acc))

if (file.exists("../data/test.csv")) {
  test <- read_csv("../data/test.csv", show_col_types = FALSE)
} else if (file.exists("src/data/test.csv")) {
  test <- read_csv("src/data/test.csv", show_col_types = FALSE)
} else {
  stop("test.csv not found!")
}

test <- test %>%
  drop_na() %>%
  distinct() %>%
  mutate(Sex = ifelse(Sex == "male", 0, 1))

X_test <- test[, features]
y_pred_test_prob <- predict(model, newdata = X_test, type = "response")
y_pred_test <- ifelse(y_pred_test_prob > 0.5, 1, 0)
cat("read test!\n")

if (file.exists("../data/gender_submission.csv")) {
  y_pred_ref <- read_csv("../data/gender_submission.csv", show_col_types = FALSE)
} else if (file.exists("src/data/gender_submission.csv")) {
  y_pred_ref <- read_csv("src/data/gender_submission.csv", show_col_types = FALSE)
} else {
  stop("gender_submission.csv not found!")
}

y_pred_ref <- y_pred_ref %>%
  filter(PassengerId %in% test$PassengerId) %>%
  select(Survived)

test_acc <- mean(y_pred_ref$Survived == y_pred_test)
cat(sprintf("accuracy: %.3f\n", test_acc))

