---
title: "README for run_analysis.R"
author: "Toni Rib"
date: "Sunday, March 22, 2015"
output: html_document
---

This an R Markdown README file for the function run_analysis.R which was written for the Coursera Getting and Cleaning Data course project.

### Prerequisites

Prior to using the run_analysis function, the user must do the following:

1. Download the data from the following url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

2. Save the data in a folder that is a direct subfolder of the current working directory

3. Download run_analysis.R from ToniRib's github repository

4. install the **plyr** and **reshape2** packages using the install.packages command


### Inputs & Outputs

**Input:** directory name that contains all data files

**Output:** tidy data set that contains the average of each variable for each activity and each subject

### Function Call

The function is called using the following format:

tidyData <- run_analysis(directory)

### Function Specifics
The run_analysis function performs the following:

1. Reads in all data from the files: activity_labels, features, subject_test, X_test, y_test, subject_train, X_train, and y_train
      + Feature names are used directly when importing the X_train and X_test sets, so that the column names are set to the feature names.
      + Y and Subject sets are imported as factors for ease of use.

2. Binds the data sets together to create one large data set
      + This is done by first binding the test set together with the left-to-right order of subject, y, X. The same is done for the train set. 
      + The two sets are then bound together with the test set on 'top' of the train set. The full data set has dimensions 10299 by 563.

3. Creates a new data fame from only the columns that are a 'mean' or 'std'
      + This is done using the 'grep' command.
      + Columns with freqMean are ignored, as these frequency mean calculations are different from the mean calculations. For the angular calculations, both means were included, but only the true mean was chosen.
      + At this point in the code, the Subject column must also be refactored so that it can be sorted in decreasing order later in the code. The factors were out of order when imported, so a line is added to refactor them from 1:30.

4. Sorts the data frame in order of ascending Subject and Activity
      + This allows for the user to easily see each category and to see all measurements for one Subject grouped together.
      
5. Renames columns with more descriptive names
      + See the code book for additional information. Columns are renamed for easier viewing by the user.
      
6. Calculates the mean of each variable for each activity and each subject and returns this in a new tidy data frame
      + This is done using the reshape2 package.
      + The code first melts the data frame using Subject_Number and Activity_Name as IDs, so the final form will be able to use those for the tidy data set.
      + The code then recasts the data frame into a new tidy data frame, taking the average of each variable and using Subject_Number and Activity_Name to sort the data.
      + The tidy data frame contains only one observation per row (by Subject and Activity) and contains a measurement in each column. There are no NA or missing values. Each column is labeled appropriately per the Code Book.
      
### Read output back into R

The tidy data set produced by run_analysis can be read back into R with the following command:

```{r}
tidyData <- read.table(file="tidyData.txt", header=TRUE)
```

tidyData.txt is attached to Toni Rib's course project submission.