df <- read.csv("C:/Users/rocka/OneDrive/Documents/county_surgery_data.csv", header = TRUE)

# Filtering records for the year 2016 onwards
df_filtered <- subset(df, Year >= 2016)

#'County' and 'Surgery' to factors
df_filtered$County <- as.factor(df_filtered$County)
df_filtered$Surgery <- as.factor(df_filtered$Surgery)


# Building the initial model on the filtered data
model_initial <- glm(TotalCases ~ Year + County + Surgery, family = 'poisson', data = df_filtered)

# Displaying summary of the initial model
summary(model_initial)

#Splitting the data into testing and training sets
set.seed(1234)
nobs <- nrow(df_filtered)
train <- sample(1:nobs, 2600)
test <- setdiff(1:nobs, train)

train_data <- df_filtered[train, ]
test_data <- df_filtered[test, ]

# Building the model on the training set
model_train <- glm(TotalCases ~ Year + County + Surgery, family = 'poisson', data = train_data)

summary(model_train)
# Predictions on the training set
predictions_train <- predict(model_train, newdata = train_data, type = "response")

# Calculate Mean Squared Error (MSE) for the training set
mse_train <- mean((train_data$TotalCases - predictions_train)^2)
rmse_train <- sqrt(mse_train)

print(paste("Mean Squared Error (MSE) on the training set:", mse_train))
print(paste("Root Mean Squared Error (RMSE) on the training set:", rmse_train))

# Predictions on the test set
predictions_test <- predict(model_train, newdata = test_data, type = "response")

# Calculate Mean Squared Error (MSE) for the test set
mse_test <- mean((test_data$TotalCases - predictions_test)^2)
rmse_test <- sqrt(mse_test)

print(paste("Mean Squared Error (MSE) on the test set:", mse_test))
print(paste("Root Mean Squared Error (RMSE) on the test set:", rmse_test))

# Testing new data for prediction by using an unknown year 2022
new_data <- data.frame(Year = 2022, County = "Los Angeles", Surgery = "Breast")

# Predict using the new data
predicted_cases <- predict(model_train, newdata = new_data, type = "response")

# Display the predicted cases
print(round(predicted_cases, 0))



