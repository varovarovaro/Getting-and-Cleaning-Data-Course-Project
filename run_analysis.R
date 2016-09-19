##############################################################################
# Step 0 start - Set Working Directory and Load Required PackageS
##############################################################################
rm(list = ls())
setwd("D:\\Study\\Coursera\\Getting and Cleaning Data\\Assignments\\Project")

pckg<-c("dplyr","data.table","plyr","reshape2")

is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
} 

for(i in 1:length(pckg)) {
  if (!is.installed(pckg[i])){
    install.packages(pckg[i])
  }
}

lapply(pckg, require, character.only = TRUE)



##############################################################################
#Step 0 End - Set Working Directory and Load Required Packages
##############################################################################

##############################################################################
#Step 1 Start - Download and Extract Dataset if doesnt exist
##############################################################################

if (!file.exists("UCI HAR Dataset")) {
  # download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile="UCI_HAR_data.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile, method="curl")
  unzip(zipfile)
}

##############################################################################
#Step 1 End
##############################################################################

##############################################################################
#Step 2 Start - Reading of Input Data Bases and renaming of headers with 
#descriptive variable name
##############################################################################

s_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",sep="", header = FALSE)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt",sep="", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",sep="", header = FALSE)
all_train <- cbind(s_train,y_train,x_train)
rm(s_train,x_train,y_train)

s_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",sep="", header = FALSE)
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt",sep="", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",sep="", header = FALSE)
all_test <- cbind(s_test,y_test,x_test)
rm(s_test,x_test,y_test)

full_data <- rbind(all_train, all_test)
rm(all_train,all_test)

##############################################################################
#Step 2 End
##############################################################################

##############################################################################
#Step 3 Start - Rename headers with descriptive variable name
##############################################################################

features_names <- read.table("UCI HAR Dataset\\features.txt", header=FALSE)
colnames(full_data)[1] <- "Subject"
colnames(full_data)[2] <- "Activity_Code"

for(i in 3:length(full_data)){
  colnames(full_data)[i] <- as.character(features_names[i-2,2])
}

##############################################################################
#Step 3 End
##############################################################################

##############################################################################
# Step 4 Start - Select only columns conatining mean and standard deviation
##############################################################################

merg_mean <- full_data[grep('mean()', names(full_data),fixed=TRUE)]
merg_std <- full_data[grep('std()', names(full_data),fixed=TRUE)]

selected_data <- cbind(full_data[,1:2], merg_mean,merg_std)

rm(full_data,merg_mean,merg_std)

##############################################################################
# Step 4 End
##############################################################################

##############################################################################
# Step 5 Start - Replace Activity Code by activity names
##############################################################################

activity_names<- read.table("UCI HAR Dataset\\activity_labels.txt",header=FALSE)
colnames(activity_names)[1] <- "Activity_Code"
colnames(activity_names)[2] <- "Activity_Name"
selected_data <- merge(x = selected_data, y = activity_names, by = "Activity_Code", all.x = TRUE, sort=FALSE)
selected_data <- selected_data[c(2,69,3:68)]

##############################################################################
# Step 5 End
##############################################################################

##############################################################################
# Step 6 Start - Create a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
##############################################################################

melt_data<-melt(selected_data, id.vars=c("Activity_Name","Subject"))
cast_data<-dcast(melt_data, Activity_Name + Subject ~ variable, mean)
write.table(cast_data, file="output_data.txt")

##############################################################################
# Step 6 End
##############################################################################

##############################################################################
# Step Last - Clean all library
##############################################################################

rm(list = ls())
