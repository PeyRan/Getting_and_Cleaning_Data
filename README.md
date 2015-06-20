# Getting_and_Cleaning_Data Class Project
README.md for run_analysis.R


Read Source Data - Read the following Data from 
"features.txt"
"X_test.txt"
"y_test.txt"
"subject_test.txt"
"X_train.txt"
"y_train.txt"
"subject_train.txt".


1.  Merges the training and the test sets to create one data set.
    1-1 Convert feature 561x2 to 1x561 + 2 columns
    1-2 Use Cbind to combine data frames: X_train, subject_train, & y_train
    1-3 Use Cbind to combine data frames: X_test, subject_test, & y_test
    1-4 Use rbind to combine  data frames: in 1-1, 1-2, & 1-3 into one data frame
    1-5 Load Variable Names for each variable


2. Extracts only the measurements on the mean and standard deviation for each measurement. 


3.  Uses descriptive activity names to name the activities in the data set

4.  Appropriately labels the data set with descriptive variable names. 
    Use names() function to get new descriptive variable names

5.  From the data set in step 4, creates a tidy data set with the average of each variable for each activity and each subject.
    Use group_by(Activity, Subject), summarise_each(funs(mean)) in dplyr package to get the tidy dataset.
    Use write.table() yo generate the out put file.
