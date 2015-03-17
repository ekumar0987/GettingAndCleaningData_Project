## Getting and cleaning data - Course Project

### Project Background 
The objective of this project was to create a tidy dataset using the "Human Activity Recognition using Smartphones" dataset that can be obtained from the following url - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This initial  data is the result of certain experiments that were carried out with a group of 30 volunteers in the age bracket of 19-48 years. Each person performed 6 different activities - Walking, Walking Upstairs, Walking Downstaris, Sitting, Standing and Laying using a smart phone (Samsung Galaxy S II) on their waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. More details about the data collected during the experiments and the variables used for the data analysis has been included in the document __Code Book__ that has been included in this repository. The original dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The purpose of this assignment was to achieve the goals listed below and in the process generate a tidy data set. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The script that achieves this is called **run_analysis.R** that can also be found in this repository

### Required Files
Before begining the data clean up process, the initial data set needs to be unzipped and saved into your R working directory. In this project, we worked 
with data from the following files - 

* X_test.txt - Test data measurements
* subject_test.txt - Volunteers whose results were added to test data
* y_test.txt - Activity ID

* X_train.txt - Training data measurements
* subject_train.txt - Volunteers whose results were added to training data
* y_train.txt - Activity ID

* features.txt - List of measurement variables
* activity_labels.txt - Activity ID and labels

### Steps involved in the script to create a tidy data set

The script **run_analysis.R** has been divided into five parts to address each of the five requirements listed above

1. **Part 1**
  + Read all the required files into data tables in R
  + Appropriate labels are added to the data. The data provided in features.txt and activity_labels.txt was used. These variables names will be further cleaned up in the subsequent steps
  + Data from various data tables are then complete to create one dataset. This data includes both test and training data measurements along with the       volunteer and activity details
2. **Part 2**
  + Extract all those columns whose name matches "mean" or "std". Note: Columns with "meanFreq" in the column name has also been included so as to include
  all columns that hold a certain mean value
3. **Part 3**
  + Rename the activity codes in the data set to their appropriate activity labels to make the data more readable and easy to use
4. **Part 4**
  + Rename column variables to more descriptive labels. This constitutes an important aspect of tidy data
  + For the purpose of this assignment, pattern matching was done to find and replace variables with better names. For example "Acceleration" instead of "Acc", "Magnitude" instead of "Mag" and so on. Special character were also removed from column names
5. **Part 5**
  + Compute the average of each variable in the data set obtained in part 4 i.e the average of each variable for each activity and each subject
  + The data was then written to a text file
  + The contents of this file has been uploaded to the repository by the name **CourseProject_Output_tidyData.txt**
  
### Tidy data
From the above analysis we can see how a tidy dataset has been generated. This dataset addresses the requirements of a tidy data set by satisfying the following conditions - 

* Each variable measured is specified in a single column
* Each different observation of that variable is in a different row
* There is one table for each kind of variable
* The variable names are included in the top row of the file
* variable names have been converted to human readable format. For example "fBodyGyro-meanFreq()-X" to"fBodyAngularVelocityMeanFrequencyX"
* Data from one table is saved into its own unique file

### Code Book
Details describing the variables used for the data analsyis has been included in **Codebook.txt** file
