run_analysis <- function(dir){
      ## Function: run_analysis
      ## This function assumes that all files from the following URL have been downloaded
      ## to a folder with the user supplied name 'dir' which is located in the 
      ## current working directory.
      
      ## The function performs all 5 steps of the Course Project for the Coursera
      ## Getting and Cleaning Data Course. 
      
      ## run_analysis performs the following:
      ##    1. Reads in all data from the files: activity_labels, features, subject_test,
      ##       X_test, y_test, subject_train, X_train, and y_train
      ##    2. Binds the data sets together to create one large data set
      ##    3. Creates a new data fame from only the columns that are a 'mean' or 'std'
      ##    4. Sorts the data frame in order of ascending Subject and Activity
      ##    5. Renames columns with more descriptive names
      ##    6. Calculates the mean of each variable for each activity and each subject
      ##       and returns this in a new tidy data frame
      
      ## Inputs: directory location of downloaded files. Must be in working directory.
      ## Outputs: tidy data frame from step 6 above
      ## Function call where user has placed data in directory "UCI_HAR_Dataset": 
      ##    tidyData <- run_analysis("UCI_HAR_Dataset")
      
      ## Additional information can be found in the markdown files:
      ##    README.md
      ##    Codebook.md
      
      ## Note: This code uses the plyr and reshape2 packages. These must be installed
      ## by the user prior to using this function
      
      ## Original code written by Toni M Rib, March 2015.
      ## ------------------------------------------------------------------------
      
      
      ## ***** STEP ONE FROM COURSE PROJECT ASSIGNMENT ******
      ## Read in all of the necessary files from the current working directory
      ## dir MUST BE a subdirectory of the current working directory
      activity_labels <- read.table(paste(".",dir,"activity_labels.txt",sep="/"))
      
      features <- read.table(paste(".",dir,"features.txt",sep="/"), stringsAsFactors=FALSE)
      ## features data set will be used to label the x_train and x_test columns
      f <- features$V2  
      
      ## Read in the main data and ensure activity and subject sets are read as factors
      y_test <- read.table(paste(".",dir,"test","y_test.txt",sep="/"), header=FALSE, colClasses="factor",
                           col.names="Activity")
      x_test <- read.table(paste(".",dir,"test","X_test.txt",sep="/"), header=FALSE, col.names=f)
      y_train <- read.table(paste(".",dir,"train","y_train.txt",sep="/"), header=FALSE, colClasses="factor",
                            col.names="Activity")
      x_train <- read.table(paste(".",dir,"train","X_train.txt",sep="/"), header=FALSE, col.names=f)
      subject_test <- read.table(paste(".",dir,"test","subject_test.txt",sep="/"), header=FALSE, 
                                 colClasses="factor",col.names="Subject")
      subject_train <- read.table(paste(".",dir,"train","subject_train.txt",sep="/"), header=FALSE, 
                                  colClasses="factor",col.names="Subject")
      
      ## Bind the sets together, starting with test, then with train, then features
      testSet <- cbind(subject_test,y_test,x_test)
      trainSet <- cbind(subject_train,y_train,x_train)
      fullSet <- rbind(testSet,trainSet)
      
      ## ****** STEP TWO FROM COURSE PROJECT ASSIGNMENT ******
      
      ## Find column numbers that contain 'mean' or 'std' using the grep command
      ## Offset returned numbers by 2 to account for the Activity and Subject columns
      meanSet <- grep(".mean",f)
      meanSet <- meanSet + 2
      stdSet <- grep(".std",f)
      stdSet <- stdSet + 2
      ## Do not include the meanFreq columns, as those are not a mean used for this data set
      meanFreqSet <- grep("meanFreq",f)
      meanFreqSet <- meanFreqSet + 2
      meanSet <- setdiff(meanSet, meanFreqSet)
      
      ## Combine the two sets (mean and stdev) and then sort them based on ascending numbers
      bothSet <- c(1,2,meanSet,stdSet)
      sortedSet <- sort(bothSet,decreasing=FALSE)
      
      ## Using the columns numbers calculated above, create a new data frame that contains
      ## only the mean and stadard deviation calculations
      MeanStdData <- fullSet[,sortedSet]
      
      ## Refactor the levels of Subject so they are in the correct order
      MeanStdData$Subject <- factor(MeanStdData$Subject, levels = 1:30)
      
      ## ***** STEP THREE FROM COURSE PROJECT ASSIGNMENT *****
      
      ## Load the plyr package and remap the factor levels for the Activity column
      library(plyr)
      
      ## Sort the data set by Subject then Activity
      MeanStdData <- arrange(MeanStdData, Subject, Activity)
      
      ## Remap the factor levels for activity to be the description names
      MeanStdData$Activity <- mapvalues(MeanStdData$Activity,from=c(1,2,3,4,5,6), 
                                        to = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS",
                                               "SITTING","STANDING","LAYING"))
      
      ## ***** STEP FOUR FROM COURSE PROJECT ASSIGNMENT *****
      ## Rename the column variables to be more descriptive for the user
      ## See CodeBook.md for additional explanation of column names
      
      colnames(MeanStdData) <- c("Subject_Number","Activity_Name",
                                 "Mean_BodyAcceleration_onXaxis_TimeDomain",
                                 "Mean_BodyAcceleration_onYaxis_TimeDomain",
                                 "Mean_BodyAcceleration_onZaxis_TimeDomain",
                                 "StandardDeviation_BodyAcceleration_onXaxis_TimeDomain",
                                 "StandardDeviation_BodyAcceleration_onYaxis_TimeDomain",
                                 "StandardDeviation_BodyAcceleration_onZaxis_TimeDomain",
                                 "Mean_GravityAcceleration_onXaxis_TimeDomain",
                                 "Mean_GravityAcceleration_onYaxis_TimeDomain",
                                 "Mean_GravityAcceleration_onZaxis_TimeDomain",
                                 "StandardDeviation_GravityAcceleration_onXaxis_TimeDomain",
                                 "StandardDeviation_GravityAcceleration_onYaxis_TimeDomain",
                                 "StandardDeviation_GravityAcceleration_onZaxis_TimeDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onXaxis_TimeDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onYaxis_TimeDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onZaxis_TimeDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onXaxis_TimeDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onYaxis_TimeDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onZaxis_TimeDomain",
                                 "Mean_BodyGyro_onXaxis_TimeDomain",
                                 "Mean_BodyGyro_onYaxis_TimeDomain",
                                 "Mean_BodyGyro_onZaxis_TimeDomain",
                                 "StandardDeviation_BodyGyro_onXaxis_TimeDomain",
                                 "StandardDeviation_BodyGyro_onYaxis_TimeDomain",
                                 "StandardDeviation_BodyGyro_onZaxis_TimeDomain",
                                 "Mean_BodyAngularVelocity(Jerk)_onXaxis_TimeDomain",
                                 "Mean_BodyAngularVelocity(Jerk)_onYaxis_TimeDomain",
                                 "Mean_BodyAngularVelocity(Jerk)_onZaxis_TimeDomain",
                                 "StandardDeviation_BodyAngularVelocity(Jerk)_onXaxis_TimeDomain",
                                 "StandardDeviation_BodyAngularVelocity(Jerk)_onYaxis_TimeDomain",
                                 "StandardDeviation_BodyAngularVelocity(Jerk)_onZaxis_TimeDomain",
                                 "Mean_BodyAcceleration_Magnitude_TimeDomain",
                                 "StandardDeviation_BodyAcceleration_Magnitude_TimeDomain",
                                 "Mean_GravityAcceleration_Magnitude_TimeDomain",
                                 "StandardDeviation_GravityAcceleration_Magnitude_TimeDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_Magnitude_TimeDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_Magnitude_TimeDomain",
                                 "Mean_BodyGyro_Magnitude_TimeDomain",
                                 "StandardDeviation_BodyGyro_Magnitude_TimeDomain",
                                 "Mean_BodyAngularVelocity(Jerk)_Magnitude_TimeDomain",
                                 "StandardDeviation_BodyAngularVelocity(Jerk)_Magnitude_TimeDomain",
                                 "Mean_BodyAcceleration_onXaxis_FreqDomain",
                                 "Mean_BodyAcceleration_onYaxis_FreqDomain",
                                 "Mean_BodyAcceleration_onZaxis_FreqDomain",
                                 "StandardDeviation_BodyAcceleration_onXaxis_FreqDomain",
                                 "StandardDeviation_BodyAcceleration_onYaxis_FreqDomain",
                                 "StandardDeviation_BodyAcceleration_onZaxis_FreqDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onXaxis_FreqDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onYaxis_FreqDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_onZaxis_FreqDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onXaxis_FreqDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onYaxis_FreqDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_onZaxis_FreqDomain",
                                 "Mean_BodyGyro_onXaxis_FreqDomain",
                                 "Mean_BodyGyro_onYaxis_FreqDomain",
                                 "Mean_BodyGyro_onZaxis_FreqDomain",
                                 "StandardDeviation_BodyGyro_onXaxis_FreqDomain",
                                 "StandardDeviation_BodyGyro_onYaxis_FreqDomain",
                                 "StandardDeviation_BodyGyro_onZaxis_FreqDomain",
                                 "Mean_BodyAcceleration_Magnitude_FreqDomain",
                                 "StandardDeviation_BodyAcceleration_Magnitude_FreqDomain",
                                 "Mean_BodyLinearAcceleration(Jerk)_Magnitude_FreqDomain",
                                 "StandardDeviation_BodyLinearAcceleration(Jerk)_Magnitude_FreqDomain",
                                 "Mean_BodyGyro_Magnitude_FreqDomain",
                                 "StandardDeviation_BodyGyro_Magnitude_FreqDomain",
                                 "Mean_BodyAngularVelocity(Jerk)_Magnitude_FreqDomain",
                                 "StandardDeviation_BodyAngularVelocity(Jerk)_Magnitude_FreqDomain")
      
      ## ***** STEP FIVE FROM COURSE PROJECT ASSIGNMENT ******
      
      ## Load the reshape2 library to use the melt and dcast functions
      library(reshape2)
      
      ## Melt the data frame by Subject_Number and Activity_Name
      dMelt <- melt(MeanStdData,id=c("Subject_Number","Activity_Name"),
                    measure.vars=names(MeanStdData)[3:68])
      
      ## Recast the data frame into a new data frame taking the mean of each variable
      ## for each Subjct and each Activity
      actData <- dcast(dMelt, Subject_Number + Activity_Name ~ variable,mean)
      
      ## Return the new tidy data frame to the user
      actData
      
      ## End of function
}