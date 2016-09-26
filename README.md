# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.

The data for this project is contained in:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


The R script, `run_analysis.R`, does the following:


1. Downloada and extracts the dataset if it does not already exist in the working directory
2. Loads the activity and feature information
3. It then loads the training and test datasets by retaining only the mean and standard deviation columns.
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset
5. Merges the two datasets
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair.

Ouput is saved in file `tidy_output.txt`.
