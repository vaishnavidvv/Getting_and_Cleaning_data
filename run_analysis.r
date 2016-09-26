library(reshape2)


src_file <- "source_data.zip"

## Download and unzip the dataset:
if (!file.exists(src_file)){
  src_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(src_URL, src_file, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(src_file) 
}

# Load activity labels + features
actvty_lbl <- read.table("UCI HAR Dataset/activity_labels.txt")
actvty_lbl[,2] <- as.character(actvty_lbl[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract only the data on mean and standard deviation
RequiredFeatures <- grep(".*mean.*|.*std.*", features[,2])
RequiredFeatures.names <- features[RequiredFeatures,2]
RequiredFeatures.names = gsub('-mean', 'Mean', RequiredFeatures.names)
RequiredFeatures.names = gsub('-std', 'Std', RequiredFeatures.names)
RequiredFeatures.names <- gsub('[-()]', '', RequiredFeatures.names)


# Load the datasets
training_data <- read.table("UCI HAR Dataset/train/X_train.txt")[RequiredFeatures]
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
training_data <- cbind(trainSubjects, trainActivities, training_data)

test_data <- read.table("UCI HAR Dataset/test/X_test.txt")[RequiredFeatures]
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test_data <- cbind(testSubjects, testActivities, test_data)

# merge datasets and add labels
Data <- rbind(training_data, test_data)
colnames(Data) <- c("subject", "activity", RequiredFeatures.names)

# turn activities & subjects into factors
Data$activity <- factor(Data$activity, levels = actvty_lbl[,1], labels = actvty_lbl[,2])
Data$subject <- as.factor(Data$subject)

Data.melted <- melt(Data, id = c("subject", "activity"))
Data.mean <- dcast(Data.melted, subject + activity ~ variable, mean)

write.table(Data.mean, "tidy_output.txt", row.names = FALSE, quote=FALSE)




