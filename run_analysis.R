# Getting and Cleaning Data Course Project

# Script - run_analysis.R
# This script is used to perform the following functions - 
# 1. Merge training and test datasets in the raw format into one data set
# 2. Extract only the measurement on the mean and standard deviation for each measurement
# 3. Replace activity codes with descriptive names in the data set
# 4. Label the data set with descriptive names
# 5. Create an independent tidy data set, with the average of each variable for each activity and each subject 


#####################################################################################################################################
################################# Part 1 - Merge Training and Test datasets into one dataset ########################################
#####################################################################################################################################

# Read test data - test readings, test subjects and test activities
tbl_testData<-read.table("./test/X_test.txt")
tbl_testSubjects<-read.table("./test/subject_test.txt")
tbl_testActivities<-read.table("./test/y_test.txt")

# Read training data set i.e. training readings, training subjects and training activities 
tbl_trainData<-read.table("./train/X_train.txt")
tbl_trainSubjects<-read.table("./train/subject_train.txt")
tbl_trainActivities<-read.table("./train/y_train.txt")

# Read features data set
tbl_features<-read.table("features.txt")

# Read the activities data
tbl_activities<-read.table("activity_labels.txt")

# Add appropriate labels to the various readings obtained in test and training data set using the labels described in features table
names(tbl_testData)<-tbl_features[,2]
names(tbl_trainData)<-tbl_features[,2]

# Add appropriate labels to identify subjects
names(tbl_testSubjects)<-"VolunteerID"
names(tbl_trainSubjects)<-"VolunteerID"

# Add appropriate labels to identify activities
names(tbl_testActivities)<-"ActivityID"
names(tbl_trainActivities)<-"ActivityID"

# Add appropriate labels to activities table
names(tbl_activities)<-c("ActivityID","ActivityName")

# Combine all variables of the test data into one single table
tbl_test_Sub_Actvt<-cbind(tbl_testSubjects,tbl_testActivities)
tbl_test_All<-cbind(tbl_test_Sub_Actvt,tbl_testData)

# Combine all variables of the training data into one single table
tbl_train_Sub_Actvt<-cbind(tbl_trainSubjects,tbl_trainActivities)
tbl_train_All<-cbind(tbl_train_Sub_Actvt,tbl_trainData)

# At this point we have the complete test and training dataset. Both these sets can be combined into one single table by concatenation
tbl_completeExperimentData<-rbind(tbl_test_All,tbl_train_All)


######################################################################################################################################
############################# Part 2 - Extract only the measurement on mean and standard deviation ###################################
######################################################################################################################################


library(gdata)
m<-matchcols(tbl_completeExperimentData,with=c("Volunteer","Activity","mean","std"),method="or")
tbl_mean_std_ExpData<-tbl_completeExperimentData[,c(m[[1]],m[[2]],m[[3]],m[[4]])]


######################################################################################################################################
####################################### Part 3 - Provide descriptive names for activities ############################################
######################################################################################################################################

tbl_activities$ActivityName = tolower(as.character(tbl_activities$ActivityName))      

#Replace Activity ID with Activity Name
tbl_mean_std_ExpData[,2] <- tbl_activities[tbl_mean_std_ExpData[,2],2]


######################################################################################################################################
###################################### Part 4 - Label dataset with descriptive variables #############################################
######################################################################################################################################

names(tbl_mean_std_ExpData) = gsub("Acc","Acceleration",names(tbl_mean_std_ExpData))
names(tbl_mean_std_ExpData) = gsub("Gyro","AngularVelocity",names(tbl_mean_std_ExpData))
names(tbl_mean_std_ExpData) = gsub("Mag","Magnitude",names(tbl_mean_std_ExpData))
names(tbl_mean_std_ExpData) = gsub("mean","Mean",names(tbl_mean_std_ExpData))
names(tbl_mean_std_ExpData) = gsub("std","Std",names(tbl_mean_std_ExpData))
names(tbl_mean_std_ExpData) = gsub("Freq","Frequency",names(tbl_mean_std_ExpData))
#Remove parenthesis, hyphens and commas
names(tbl_mean_std_ExpData) = gsub("\\(|\\)|-|,","", names(tbl_mean_std_ExpData))

######################################################################################################################################
############## Part 5 - Create a tidy data set with the average of each variable for each activity and each subject ##################
######################################################################################################################################
 

library(plyr)
tbl_avgExperimentData<-ddply(tbl_mean_std_ExpData,.(VolunteerID,ActivityID),numcolwise(mean))

#Output the data to a file
write.table(tbl_avgExperimentData,"CourseProject_Output_tidyData.txt",row.names=FALSE)

