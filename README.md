Getting and Cleaning Data Course Project
README
=========================================

To run the procedure ("run_amalysis.R" file) call the run_analysis function.  
This function does not require any parameter and returns a data frame containing the information as described into the Code Book document (CodeBook.md file into this repo)
  
> source("./run_analysis.R")  
> data <- run_analysis()
- The run_analysis.R file must be into your working directory 
- The "dplyr" package must be installed on your evironment  
  
To load and view the run_analysis function outcome submitted within the course project use:
> data <- read.table("./mean_dataset.txt", header = TRUE) 
> View(data)  
- The mean_dataset.txt file must be into your working directory 
  
### Function explanation
Below is the explanation of the function steps used to generate the tidy data set starting from the raw data:
- X_train, Y_train and subject_train files loaded into 3 different data frames using the read.table function
- X_test, Y_test and subject_test files loaded into 3 different data frames using the read.table function

### Project point 1: 
- Previously generated data frames merged into a unique final data frame using a combination of cbind and rbind functions

### Project point 2:
- Feature file loaded into a data frame using the read.table function
- Feature data frame filtered usign the grep function and a regular expression to extract only mean and standard deviation measurememnts (This is done selecting only features description containing mean() or std() and excluding the ones referred to X, Y and Z axials)

### Project point 3:
- Activity file loaded into a data fame using the read.table function
- The Activity columns containing labels of the activity added to the data set (merging the data set with activity_label then removing the Id_activity column from the data set because a duplicate of the Activity column)

### Project point 4:
- Data set labeled with descriptive variable names

### Project point 5:  
- The data set melt classifing id (Activity and Subject) and measure variables (other data sed columns)
- Tidy data set created with the average of each variable for each activity and each subject. Done casting the data set on the id columns and calculating the mean of measurements (variable columns) 
(Wide approach as discussed on the "Tidy Data and the Assignment" thread of the Course Project forum)
