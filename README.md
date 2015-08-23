Getting and Cleaning Data Course Project
README
=========================================

To run the procedure into the "run_amalysis.R" file call the run_analysis function. 
This function does not require any parameter and return a data frame containing the information as described into the Code Book document ()

Loads X_train, Y_train and subject_train files into 3 data frames

Loads X_test, Y_test and subject_test files into 3 data frames

Project point 1: 
Merges previously generated data frames into a unique final data frame

Project point 2: 
Selects only data set measurements on the mean and standard deviation. 
This is done selecting only features description containing mean() or std() and excluding the ones
referred to X, Y and Z axials

Project point 3:
Adds the Activity columns containing the name of the activity (merging the data set with activity_label)

Removes the Id_activity column from the data set because a duplicate of the Activity column

Project point 4:
Labels data set with descriptive variable names

Project point 5:
Creates a tidy data set with the average of each variable for each activity and each subject.
First, melts the data set classifing id and measure variables
Second, casts the data set calculating the mean of measurement
(Wide approach as discussed on the "Tidy Data and the Assignment" thread of the Course Project forum)
