# Power Consumption Optimization and Forecasting

This project analyzes and forecasts power consumption patterns using advanced statistical techniques and machine learning. By exploring the relationship between environmental variables and energy usage, it aims to improve operational efficiency, reduce costs, and promote sustainability.

## Overview

- **Business Need:** Effective power consumption management can significantly reduce costs and improve energy efficiency for businesses and organizations. This project addresses the growing need for reliable forecasting to manage variability and ensure grid stability.
- **Techniques Used:**
  - K-means clustering for consumption pattern identification.
  - Time series forecasting using Exponential Smoothing (ETS).
  - Polynomial regression for nonlinear relationships.
  - Monte Carlo simulations for predicting uncertainty in power usage.

## Dataset

- **Timeframe:** January 1, 2017 – December 31, 2017.
- **Features:** Hourly data for temperature, humidity, wind speed, and power consumption across three zones.

## Goals

1. Identify distinct power consumption patterns using clustering techniques.
2. Forecast future power consumption using time series models.
3. Analyze the impact of environmental factors (temperature, humidity, wind speed) on energy usage.
4. Provide actionable insights for energy optimization and sustainability.

## Methodology

1. **Data Cleaning and Preparation:**
   - Missing values handled using median imputation.
   - Dataset normalized for clustering and regression.
2. **K-means Clustering:**
   - Optimal clusters determined using the Elbow Method.
   - Clustering results used to categorize power consumption trends.
3. **Forecasting Models:**
   - Exponential Smoothing (ETS) for time series forecasting.
   - Polynomial regression for capturing nonlinear relationships.
4. **Monte Carlo Simulation:**
   - Simulated power consumption over 30 days to model uncertainty and variability.

## Key Results

- Identified four distinct power consumption patterns influenced by environmental conditions.
- Accurate forecasts for low-demand periods, with challenges during peak consumption.
- Monte Carlo simulations revealed fluctuations in average daily power usage, helping anticipate high-demand days.

## Repository Structure

   ```bash
   git clone https://github.com/0neaboveall/Power-Consumption-Optimization-and-Forecasting.git
   cd Power-Consumption-Optimization-and-Forecasting

