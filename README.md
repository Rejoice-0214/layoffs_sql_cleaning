# Data Cleaning Project Report on Layoffs Dataset using MySQL
Introduction
This report documents the process of cleaning a dataset named layoffs using MySQL. The dataset contains information on various companies that have undergone layoffs, including details such as the company's name, location, industry, and other related metrics. The primary goal of this project was to clean the data by removing duplicates, standardizing the data, handling null values, and removing unnecessary columns.

# Dataset Overview
The layoffs dataset includes the following columns:

company
location
industry
total_laid_off
percentage_laid_off
date
stage
country
funds_raised_in_millions

# Data Cleaning Process
Step 1: Create a Backup of the Original Data
Before making any modifications, a copy of the original data was created to ensure data integrity and to provide a reference for comparison.

Step 2: Remove Duplicate Records
Duplicates can lead to inaccurate analysis, so it was crucial to remove any duplicate entries in the dataset.

Step 3: Standardize the Data
Standardizing data helps in maintaining consistency across the dataset. This includes converting text to a consistent case, formatting dates, and ensuring numerical data is in a consistent format.

Step 4: Remove Null Values
Null values can cause issues in data analysis. These were either removed or replaced with appropriate default values where necessary.

Step 5: Remove Unnecessary Columns
To streamline the dataset, columns that were not needed for analysis were removed after careful consideration.

Conclusion
The data cleaning process effectively removed duplicates, standardized the data, handled null values, and removed unnecessary columns from the layoffs dataset. This cleaned dataset is now more consistent, accurate, and ready for further analysis. The use of MySQL for data cleaning provided a robust and efficient means to handle these tasks, ensuring data integrity and quality throughout the process.
