run_analysis <- function(){

# Loads needed library
library(dplyr)

# Loads X_train, Y_train and subject_train files into 3 data frames
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Id_Activity")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

# Loads X_test, Y_test and subject_test files into 3 data frames
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Id_Activity")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

# Project point 1: 
# Merges previously generated data frames into a unique final data frame
merged_dataset <- rbind(cbind(X_train, Y_train, subject_train),
                        cbind(X_test, Y_test, subject_test))

# Project point 2: 
# Selects only data set measurements on the mean and standard deviation. 
# This is done selecting only features description containing mean() or std() and excluding the ones
# referred to X, Y and Z axials
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("Id", "Feature"))
mean_std_features <- grep("Mag-mean[[:punct:]]{2}|Mag-std[[:punct:]]{2}", features$Feature)
merged_dataset <- select(merged_dataset, num_range("V", mean_std_features), Id_Activity, Subject)

# Project point 3:
# Adds the Activity columns containing the name of the activity (merging the data set with activity_label)
activity_label <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("Id_Activity", "Activity"))
merged_dataset <- merge(merged_dataset, activity_label, by = "Id_Activity")

# Removes the Id_activity column from the data set because a duplicate of the Activity column
merged_dataset <- select(merged_dataset, -Id_Activity)

# Project point 4:
# Labels data set with descriptive variable names
desc_measures <- c("tBodyAccelerometricMagnitudeMean", "tBodyAccelerometricMagnitudeStd", 
                  "tGravityAccelerometricMagnitudeMean", "tGravityAccelerometricMagnitudeStd", 
                  "tBodyAccelerometricJerkMagnitudeMean", "tBodyAccelerometricJerkMagnitudeStd",
                  "tBodyGyroscopicMagnitudeMean", "tBodyGyroscopicMagnitudeStd", 
                  "tBodyGyroscopicJerkMagnitudeMean", "tBodyGyroscopicJerkMagnitudeStd", 
                  "fBodyAccelerometricMagnitudeMean", "fBodyAccelerometricMagnitudeStd", 
                  "fBodyAccelerometricJerkMagnitudeMean", "fBodyAccelerometricJerkMagnitudeStd", 
                  "fBodyGyroscopicMagnitudeMean", "fBodyGyroscopicMagnitudeStd", 
                  "fBodyGyroscopicJerkMagnitudeMean", "fBodyGyroscopicJerkMagnitudeStd")

names(merged_dataset) <- append(desc_measures, c("Subject", "Activity"))

# Project point 5:
# Creates a tidy data set with the average of each variable for each activity and each subject.
# First, melts the data set classifing id and measure variables
# Second, casts the data set calculating the mean of measurement
# (Wide approach as discussed on the "Tidy Data and the Assignment" thread of the Course Project forum)
melt_dataset <- melt(merged_dataset, id.vars = c("Subject", "Activity"), measure.vars = desc_measures)

mean_dataset <- dcast(melt_dataset, Activity + Subject ~ variable, mean)
}
