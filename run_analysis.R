#Reads the files to be processed
features <- read.table("~/Desktop/DataTrack/CleanData/HAR/features.txt", quote="\"")

subject_test <- read.table("~/Desktop/DataTrack/CleanData/HAR/test/subject_test.txt", quote="\"")
X_test <- read.table("~/Desktop/DataTrack/CleanData/HAR/test/X_test.txt", quote="\"")
y_test <- read.table("~/Desktop/DataTrack/CleanData/HAR/test/y_test.txt", quote="\"")


subject_train <- read.table("~/Desktop/DataTrack/CleanData/HAR/train/subject_train.txt", quote="\"")
X_train <- read.table("~/Desktop/DataTrack/CleanData/HAR/train/X_train.txt", quote="\"")
y_train <- read.table("~/Desktop/DataTrack/CleanData/HAR/train/y_train.txt", quote="\"")


#Binds both the test data and train data into one data frame.
df<-rbind(X_test,X_train)

#Binds the subject numbers from the test and the training data sets.
subject<-rbind(subject_test,subject_train)

#Binds the activity for both the test and the training data sets.
activity<-rbind(y_test,y_train)

#Creates a vector which will serve as the column names of the data frame.
variables<-as.character(features[,2])

#Names the columns of the data frame that contains all the data from both 
#the training and the test data.
colnames(df)<-variables

#Constructs an empty matrix that we will dump the mean and standard deviations 
#for each variable.
dfans<-c()  

#Empty vector which will store the variable names of the 
#mean and standard deviation.
names<-c()


#Extracts all the mean values of the variables and stores them into a matrix.
for(i in 1:561)
  {if(grepl("-mean()",variables[i],fixed=TRUE)==TRUE){
   dfans<-cbind(dfans,df[,variables[i]])
   names<-cbind(names,variables[i])}
  }

#Extracts all the standard deviation of the variables and stores them into a matrix.
for(i in 1:561)
{if(grepl("-std()",variables[i],fixed=TRUE)==TRUE){
  dfans<-cbind(dfans,df[,variables[i]])
  names<-cbind(names,variables[i]) }
}

#Deletes all the "-" characters from the header names for ease of reading.
names<-gsub("-","",names)

#Replaces "mean()" with "MEAN" from the header names for ease of reading.
names<-gsub("mean()","MEAN",names,fixed=T)

#Replaces "std()" with "STD" from the header names for ease of reading
names<-gsub("std()","STD",names,fixed=T)

#Creates a character vector that will serve as the header of the data frame.
names<-c("Subject","Activity",names)

#Converts the matrix into a data frame.
data<-data.frame(dfans)

#Adds the subject number and activity number to the data set
dataName<-cbind(subject,activity,data)

#Adds the header which contains the names of all the variables.
#The first column is the subject number, second column is the 
#activity number, etc. The other columns are listed in the 
#codebook.
colnames(dataName)<-names

#Sorts the data by subject number and then activity number. This is 
#a data frame that contains 66 (mean and standard deviation) + 2 (subject and activity)
#variables with 10,299 observations.
SortData<-dataName[order(dataName$Subject,dataName$Activity),] #This will be the data frame for Problem 4.





########################################################
#This now begins part 5 of the project.
########################################################


#Creates an empty data frame that will store the means of each of the variables. 
#It has size 180 rows and 68 columns. This is because there are 6 x 30=180 different
#combinations of subjects and activities then 66+2 different variables.
MeanData<-data.frame(matrix(NA,nrow=180,ncol=68))

#We start a counter 1 so that we can fill the data frame.
counter<-1

#Runs two for loops. One for each subject and then one for each activity that the 
#subject does.
for(i in 1:30){
  for(j in 1:6){
    
#Fills the rows of the empty data frame with the mean of the columns for each activity 
#and each subject.
    MeanData[counter,]<-(colMeans(subset(SortData, Subject==i&Activity==j)))
    counter<-counter+1
  }
}

#Creates the header for the MeanData data frame. The header is exactly the same 
#as the SortData data frame. 
colnames(MeanData)<-names

#Substitute the activity name instead of the activity number in both data frames SortData and MeanData.
SortData$Activity<-gsub(1,"WALKING",SortData$Activity)
SortData$Activity<-gsub(2,"WALKING_UPSTAIRS",SortData$Activity)
SortData$Activity<-gsub(3,"WALKING_DOWNSTAIRS",SortData$Activity)
SortData$Activity<-gsub(4,"SITTING",SortData$Activity)
SortData$Activity<-gsub(5,"STANDING",SortData$Activity)
SortData$Activity<-gsub(6,"LAYING",SortData$Activity)

MeanData$Activity<-gsub(1,"WALKING",MeanData$Activity)
MeanData$Activity<-gsub(2,"WALKING_UPSTAIRS",MeanData$Activity)
MeanData$Activity<-gsub(3,"WALKING_DOWNSTAIRS",MeanData$Activity)
MeanData$Activity<-gsub(4,"SITTING",MeanData$Activity)
MeanData$Activity<-gsub(5,"STANDING",MeanData$Activity)
MeanData$Activity<-gsub(6,"LAYING",MeanData$Activity)

#Writes the MeanData data frame, which contains 180 observations of 66+2 different variables,
#to a .txt file to a local folder on my computer. The file is a tab delimited text file
#so that it can be easily imported into Excel or back into R if needed. We have also 
#deleted the row names, which are just the row numbers in this case.

write.table(SortData, "~/Desktop/DataTrack/CleanData/SortData.txt", sep="\t",row.names=F)
write.table(MeanData, "~/Desktop/DataTrack/CleanData/MeanData.txt", sep="\t",row.names=F)
