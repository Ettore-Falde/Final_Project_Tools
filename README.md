# Final_Project_Tools
 Final Project of the Tools and Decision Making course

## Project Overview

This project was developed by Ettore Falde, Samoussa Fofana, and Federico Basaglia. The objective is to analyze the Human Resources status of an IT company with two locations: London and Barcelona. The analysis addresses gender equality, office structure, employee satisfaction, and succession strategy.

## Table of Contents

1. [Introduction](#introduction)
2. [Setup the Software](#setup-the-software)
3. [Importing Data](#importing-data)
4. [Cleaning Data](#cleaning-data)
5. [Analysis](#analysis)
6. [Succession Strategy](#succession-strategy)
7. [Adding Dataset](#adding-dataset)
8. [Conclusions](#conclusions)
9. [References](#references)

## Introduction

The new CEO of an IT company requested an analysis of the current Human Resources status, focusing on gender equality, office structure, employee satisfaction, and succession planning. The company operates in London and Barcelona. This project includes exploratory data analysis, a technical report, and a technical presentation.

## Setup the Software

The software used for the analysis and report generation is R. The following libraries are required:
- tidyverse
- ggplot2
- GGally
- gridExtra
- yardstick
- broom
- janitor
- caTools
- ROCR
- corrplot
- tidytext
- glue
- scales
- plotly
- patchwork
- skimr
- RColorBrewer

## Importing Data

The dataset is loaded and analyzed for variable names and structure. The dataset contains 1506 observations and 36 variables. Key variables include age, attrition, business travel, daily rate, department, distance from home, education, environment satisfaction, gender, hourly rate, job involvement, job level, job role, job satisfaction, marital status, monthly income, number of companies worked, overtime, performance rating, relationship satisfaction, stock option level, total working years, training times last year, work-life balance, years at the company, years in current role, years since last promotion, years with current manager, and city.

## Cleaning Data

Data cleaning involves renaming variables for consistency, checking dataset dimensions, removing blank rows and duplicates, and dropping rows with missing values. The dataset is prepared for analysis by ensuring all necessary values are correctly formatted and outliers are filtered.

## Analysis

The analysis is divided into several sections:
1. **Gender Equality**: Analyzes gender distribution, monthly income by gender, department distribution by gender, job roles by gender, seniority by gender, education fields by gender, and regression analysis on gender-related factors.
2. **Attrition Analysis**: Examines factors affecting employee attrition, including gender, marital status, and regression analysis on attrition predictors.
3. **Satisfaction Analysis**: Investigates job satisfaction, environmental satisfaction, and differences in satisfaction levels between the two cities.

## Succession Strategy

The analysis provides insights into the company's succession strategy, identifying potential successors and suggesting improvements to ensure smooth transitions.

## Adding Dataset

Additional datasets are incorporated to enhance the analysis, including comparisons with UK and Barcelona datasets.

## Conclusions

The final section summarizes key findings and provides recommendations based on the analysis conducted. It highlights areas for improvement and suggests strategies to address identified issues.

## References

A list of references and external sources used in the analysis and report preparation.

---

For detailed analysis and visualizations, refer to the main project report and the accompanying technical presentation.


