##Load Required Library, set wd and download data
library(data.table)
setwd("~/Training/R/cleaning data/week4/project")
fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists('./UCI HAR Dataset.zip')){
        download.file(fileURL,'./UCI HAR Dataset.zip', mode = 'wb')
        unzip("UCI HAR Dataset.zip")
}

#1 Merges the training and the test sets to create one data set.

#1.1 Read data
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')

data_train_set <- read.table('./UCI HAR Dataset/train/X_train.txt')
data_train_label <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data_test_set <- read.table('./UCI HAR Dataset/test/X_test.txt')
data_test_label <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data_test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')


#1.2 Massage data
features$V2 <- as.character(features[,2])

##1.3 Consolidate data into a single data frame
data_train <-  data.frame(data_train_subject, data_train_label, data_train_set)
names(data_train) <- c(c('subject', 'activity'), features$V2)

data_test <-  data.frame(data_test_subject, data_test_label, data_test_set)
names(data_test) <- c(c('subject', 'activity'), features$V2)

data <- rbind(data_train, data_test)

#2 Extracts only the measurements on the mean and standard deviation for each measurement.

#2.1 Get the columns that contain mean or std 
mean_std_cols <- grep('mean|std', features$V2)

#2.2 Subset the data set to include only those columns (adding 2 to compensate for subject and activity)
data_mean_std <- data[,c(1,2,mean_std_cols+2)]

#3 Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity_labels <- as.character(activity_labels[,2])
data_mean_std$activity <- activity_labels[data_mean_std$activity]

#4 Appropriately labels the data set with descriptive variable names.
updated_names <- names(data_mean_std)
updated_names <- gsub("^t", "Time_", updated_names)
updated_names <- gsub("^f", "Frequency_", updated_names)
updated_names <- gsub("Acc", "_Accelerometer_", updated_names)
updated_names <- gsub("Gyro", "_Gyroscope_", updated_names)
updated_names <- gsub("Mag", "_Euclidean_Magnitude", updated_names)
updated_names <- gsub("mean", "Mean", updated_names)
updated_names <- gsub("std", "Standard_Deviation", updated_names)
updated_names <- gsub("-", "_", updated_names)
updated_names <- gsub("BodyBody", "Body", updated_names)
updated_names <- gsub("MeanFreq", "Mean_Frequency", updated_names)
updated_names <- gsub("[(][)]", "", updated_names)
updated_names <- gsub("__", "_", updated_names)
names(data_mean_std) <- updated_names

#5 From the data set in step 4, creates a second, independent tidy
#  data set with the average of each variable for each activity and each subject.

new_data <- aggregate(data_mean_std[,3:81], by = list(activity = data_mean_std$activity, subject = data_mean_std$subject),FUN = mean)
write.table(new_data, row.names = FALSE, file = './new_data.txt')