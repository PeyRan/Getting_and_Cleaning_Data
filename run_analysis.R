########################################################################
##
## run_analysis.R
##
########################################################################
# You should create one R script called run_analysis.R that does the following. 
#
# 1.  Merges the training and the test sets to create one data set.
# 2.  Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3.  Uses descriptive activity names to name the activities in the data set
# 4.  Appropriately labels the data set with descriptive variable names. 
# 5.  From the data set in step 4, creates a second, independent tidy data set with the average of 
#     each variable for each activity and each subject.
########################################################################
# Read Source Data
########################################################################
features <- read.table("UCI HAR Dataset/features.txt")
dim(features)
#[1] 561   2

testX <- read.table("UCI HAR Dataset/test/X_test.txt")
dim(testX)
#[1] 2947  561

testY <- read.table("UCI HAR Dataset/test/y_test.txt")
dim(testY)
#[1] 2947    1

testSB <- read.table("UCI HAR Dataset/test/subject_test.txt")
dim(testSB)
#[1] 2947    1

trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
dim(trainX)
#[1] 7352  561

trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
dim(trainY)
#[1] 7352    1

trainSB <- read.table("UCI HAR Dataset/train/subject_train.txt")
dim(trainSB)
#[1] 7352    1


########################################################################
# 1.  Merges the training and the test sets to create one data set.
########################################################################
#####################################################
# 1-1 Convert feature 561x2 to 1x561 + 2 columns
#####################################################
i <- 1
f <- matrix(nrow=1, ncol=563)
for (st in features[,2]) {
	f[1, i] <- st
	i <- i +1
	}
f[1,562] <- "Subject"
f[1,563] <- "Activity"


#####################################################
# 1-2 Cbind X_train, subject_train, & y_train
#####################################################
train_all <- cbind(trainSB, trainY)
names(train_all) <- c("V562","V563")
dim(train_all)
#[1] 7352    2

head(train_all)
#  V562 V563
#1    1    5
#2    1    5
#3    1    5

train_all <- cbind(trainX, train_all)
dim(train_all)
#[1] 7352  563

head(train_all, 2)


#####################################################
# 1-3 Cbind X_test, subject_test, & y_test
#####################################################
test_all <- cbind(testSB, testY)
names(test_all) <- c("V562","V563")
dim(test_all)
#[1] 2947    2

head(test_all, 2)
#  V562 V563
#1    2    5
#2    2    5

test_all <- cbind(testX, test_all)
dim(test_all)
#[1] 2947  563

head(test_all, 2)


#####################################################
# 1-4 rbind 1-1, 1-2, & 1-3
#####################################################
data1 <- rbind(train_all, test_all)
dim(data1)
#[1] 10299   563

class(f)
#[1] "matrix"
class(data1)
#[1] "data.frame"


#####################################################
# 1-5 Load Variable Name
#####################################################
for (i in 1:563) {
         colnames(data1)[i] <- as.character(f[1,i])
    }
head(data1,1)



########################################################################
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
########################################################################
data2 <- data1[,c("Subject", "Activity")]
dim(data2)
#[1] 10299     2


data3 <- cbind(data1[names(data1[grep("mean()", names(data1), fixed = TRUE)])], data1[names(data1[grep("std()", names(data1), fixed = TRUE)])])
dim(data3)
#[1] 10299    66

data4 <- cbind(data2, data3)
dim(data4)
#[1] 10299    68


########################################################################
# 3.  Uses descriptive activity names to name the activities in the 
#     data set
########################################################################
# replace code with: 
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

table(data4$Activity)
#   1    2    3    4    5    6 
#1722 1544 1406 1777 1906 1944 


data4$Activity <- factor(data4$Activity, levels=c(1,2,3,4,5,6)
                           , labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
data4$Activity



########################################################################
# 4.  Appropriately labels the data set with descriptive variable names. 
########################################################################
names(data4) <- c("Subject","Activity","tBodyAcc_mean_X","tBodyAcc_mean_Y","tBodyAcc_mean_Z",
 "tGravityAcc_mean_X","tGravityAcc_mean_Y","tGravityAcc_mean_Z","tBodyAccJerk_mean_X","tBodyAccJerk_mean_Y",
 "tBodyAccJerk_mean_Z","tBodyGyro_mean_X","tBodyGyro_mean_Y","tBodyGyro_mean_Z","tBodyGyroJerk_mean_X",
 "tBodyGyroJerk_mean_Y","tBodyGyroJerk_mean_Z","tBodyAccMag_mean","tGravityAccMag_mean","tBodyAccJerkMag_mean",
 "tBodyGyroMag_mean","tBodyGyroJerkMag_mean","fBodyAcc_mean_X","fBodyAcc_mean_Y","fBodyAcc_mean_Z","fBodyAccJerk_mean_X",
 "fBodyAccJerk_mean_Y","fBodyAccJerk_mean_Z","fBodyGyro_mean_X","fBodyGyro_mean_Y","fBodyGyro_mean_Z","fBodyAccMag_mean",
 "fBodyBodyAccJerkMag_mean","fBodyBodyGyroMag_mean","fBodyBodyGyroJerkMag_mean","tBodyAcc_std_X","tBodyAcc_std_Y","tBodyAcc_std_Z",
 "tGravityAcc_std_X","tGravityAcc_std_Y","tGravityAcc_std_Z","tBodyAccJerk_std_X","tBodyAccJerk_std_Y","tBodyAccJerk_std_Z",
 "tBodyGyro_std_X","tBodyGyro_std_Y","tBodyGyro_std_Z","tBodyGyroJerk_std_X","tBodyGyroJerk_std_Y","tBodyGyroJerk_std_Z",
 "tBodyAccMag_std","tGravityAccMag_std","tBodyAccJerkMag_std","tBodyGyroMag_std","tBodyGyroJerkMag_std","fBodyAcc_std_X",
 "fBodyAcc_std_Y","fBodyAcc_std_Z","fBodyAccJerk_std_X","fBodyAccJerk_std_Y","fBodyAccJerk_std_Z",
 "fBodyGyro_std_X","fBodyGyro_std_Y","fBodyGyro_std_Z","fBodyAccMag_std","fBodyBodyAccJerkMag_std",
 "fBodyBodyGyroMag_std","fBodyBodyGyroJerkMag_std")
head(data4,1)


########################################################################
# 5.  From the data set in step 4, creates a tidy data set with 
#     the average of each variable for each activity and each subject.
########################################################################
library(dplyr)

UCIHAR_tidydata <- data4 %>% group_by(Activity, Subject) %>% summarise_each(funs(mean))
dim(ss)
#[1] 180  68

write.table(UCIHAR_tidydata, file="UCIHAR_tidydata.txt"  , row.name=FALSE)


########################################################################
# THE END
########################################################################
