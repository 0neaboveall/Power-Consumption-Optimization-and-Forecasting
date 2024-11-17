##clear your working directory
#rm(list = ls())

# libraries
library(data.table)  
library(ggplot2)     
library(forecast)  
library(cluster)     
library(fpp2)   

# data
data <- fread("File Path")

print(head(data))

# Convert datetime information
data[, datetime := as.POSIXct(Datetime, format="%m/%d/%Y %H:%M")]

# Handle missing values
data[is.na(PowerConsumption_Zone3), PowerConsumption_Zone3 := median(PowerConsumption_Zone3, na.rm = TRUE)]

# Normalize data
data_scaled <- scale(data$PowerConsumption_Zone3)

# Elbow Method for Identifying the Optimal Number of Clusters
wss <- numeric(14)
for (i in 2:15) {
  wss[i-1] <- sum(kmeans(data_scaled, centers = i)$withinss)
}
plot(2:15, wss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")+
  title("Elbow Method for Identifying the Optimal Number of Clusters.")

# K-means clustering
set.seed(123)
km_res <- kmeans(data_scaled, centers = 4)
data[, cluster := as.factor(km_res$cluster)]

# Visualization of clusters
ggplot(na.omit(data), aes(x=datetime, y=PowerConsumption_Zone3, color=cluster)) + 
  geom_line() + labs(title = "Power Consumption Clusters for Zone 3")

# Splitting the data
set.seed(123)  
train_index <- sample(1:nrow(data), 0.8 * nrow(data))  # 80% training data
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# Converting the training data 
power_ts_train <- ts(train_data$PowerConsumption_Zone3, frequency=144)  

# Polynomial regression 
poly_model_train <- lm(PowerConsumption_Zone3 ~ poly(Temperature, 2) + poly(Humidity, 2) + poly(WindSpeed, 2), data = train_data)
summary(poly_model_train)  # Output the summary of the polynomial regression model

# Exponential Smoothing 
fit <- ets(power_ts_train, model="AAN")
summary(fit)

# Forecast future power consumption
forecasted <- forecast(fit, h=48)  # Forecast the next 48 hours

# Plotting forecast
autoplot(forecasted) + labs(title="c")

# Evaluate polynomial model's performance on the test data
test_predictions <- predict(poly_model_train, newdata = test_data)
test_mse <- mean((test_predictions - test_data$PowerConsumption_Zone3)^2)

# Plot observed vs. predicted values from the polynomial model on test data
ggplot(test_data, aes(x = seq_along(PowerConsumption_Zone3))) +
  geom_line(aes(y = PowerConsumption_Zone3, colour = "Observed"), size = 1) +
  geom_line(aes(y = test_predictions, colour = "Predicted"), size = 1, linetype = "dashed") +
  labs(title = "Observed vs Predicted Power Consumption for Zone 3", x = "Index", y = "Power Consumption") +
  scale_colour_manual("", breaks = c("Observed", "Predicted"), values = c("blue", "red"))

# mean and standard deviation of power consumption
mean_consumption <- mean(data$PowerConsumption_Zone3, na.rm = TRUE)
sd_consumption <- sd(data$PowerConsumption_Zone3, na.rm = TRUE)

# no. of days for simulation and no. of simulation iterations
num_days <- 30
num_simulations <- 1000

# matrix to store simulation results
simulation_results <- matrix(nrow = num_simulations, ncol = num_days)

# Monte Carlo simulations
set.seed(123) 
for (i in 1:num_simulations) {
  simulation_results[i, ] <- rnorm(num_days, mean = mean_consumption, sd = sd_consumption)
}

# average simulated power consumption for each day
average_simulation <- colMeans(simulation_results)

# Plot the results
days <- 1:num_days
plot(days, average_simulation, type = "l", col = "blue", xlab = "Day", ylab = "Average Power Consumption",
     main = "Monte Carlo Simulation of Daily Power Consumption")



