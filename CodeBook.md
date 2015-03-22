---
title: "Code Book for run_analysis.R"
author: "Toni Rib"
date: "Sunday, March 22, 2015"
output: html_document
---

### Introduction

This code book is provided for the output of the run_analysis.R function which was written for the Coursera Getting and Cleaning Data course project.

The run_analysis function produces a tidy data set based on the data collected from a Samsung Galaxy S smartphone used by 30 subjects performing 6 different activities. The data was collect from the following url: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The following information is provided from the original README.txt file included at the URL above:

=======================================

Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

=======================================

The rest of the code book describes the data contained in the tidyData.txt file, which is the output of the run_analysis function once written to a text file.

### Subject and Activities

The data contains information on 30 subjects, numbered 1-30 in the data set. Each subject performed the following 6 activites while wearing a Samsung Galaxy S II smartphone on their waist:

1. WALKING

2. WALKING_UPSTAIRS

3. WALKING_DOWNSTAIRS

4. SITTING

5. STANDING

6. LAYING

The first column of the data set is 'Subject_Number' which identifies which of the 30 subjects the measurement is for. This column is a factor with 30 levels.

The second column of the data set is 'Activity_Name' which identifies which of the 6 activities the measurement is for. This column is a factor with 6 levels.

### Measurements & Column Names

The tidy data set contains the average of measurements for the mean and standard deviation for the following categories: 

- Body Acceleration for each axis (X,Y,Z) in the time domain

- Gravity Acceleration for each axis (X,Y,Z) in the time domain

- Body Linear Acceleration (jerk) for each axis (X,Y,Z) in the time domain

- Body Gyro for each axis (X,Y,Z) in the time domain

- Body Angular Velcity (jerk) for each axis (X,Y,Z) in the time domain

- Magnitude of Body Acceleration, in the time domain

- Magnitude of Gravity Acceleration, in the time domain

- Magnitude of Linear Acceleration (jerk), in the time domain

- Magnitude of Body Gyro, in the time domain

- Magnitude of Angular Velocity (jerk), in the time domain

- Body Acceleration for each axis (X,Y,Z) in the frequency domain

- Body Linear Acceleration (jerk) for each axis (X,Y,Z) in the frequency domain

- Body Gyro for each axis (X,Y,Z) in the frequency domain

- Magnitude of Body Acceleration, in the frequency domain

- Magnitude of Linear Acceleration (jerk), in the frequency domain

- Magnitude of Body Gyro, in the frequency domain

- Magnitude of Angular Velocity (jerk), in the frequency domain

Per the original data set, frequency domain measurements were calculated using a Fast Fourier Transform (FFT). Magnitudes were calculated using the Euclidean norm.

This data was taken from the original set by only selecting the columns with mean() or std(), then taking the average of each column by subject & activity. Thus, each subject has 6 observation rows, one for each activity, and an average value of the measurement for each column associated with that activity.

The columns are labeled in the following manner:

1. 'Mean' or 'StandardDeviation' followed by an _

2. Measurement Type followed by an _

3. Other Qualifier (axis or magnitude) followed by an _

4. 'TimeDomain' or 'FreqDomain'

Columns 3 - 68 are numerical vectors.

### Additional Information

Additional information on how the data was cleaned can be found in the README.md file.