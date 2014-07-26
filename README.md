Raw Data:

The original data set is taken from the UCI Machine Learning Repository entitled Human Activity Recognition Using Smartphones Data set, http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The experiments were performed on a group of 30 volunteers aged 19-48. Each subject performed 6 activities while wearing a smartphone in this case a Samsung Galaxy SII on their waist. Using the smartphone's accelerometer and gyroscope the team captured the X,Y, and Z coordinates of the linear velocity and angular velocity. The 30 subjects were then randomly partitioned into two different sets, 70% were selected for the training data and the remaining 30% were the test data.

The data was then pre-processed by applying noise filters. The following quantities where then calculated for each test subject: 

        tBodyAcc-XYZ (Body acceleration in the X,Y, and Z direction in the time domain)

        tGravityAcc-XYZ (Gravity acceleration in the X,Y, and Z direction in the time domain)

        tBodyAccJerk-XYZ (Jerk signal in the X,Y, and Z direction in the time domain)

        tBodyGyro-XYZ (Gyroscope signal in the X,Y, and Z direction in the time domain)

        tBodyGyroJerk-XYZ (Gyroscope Jerk signal in the X,Y, and Z direction in the time domain)

The magnitudes of each of these measurements was then calculated using the usual Euclidean distance:

        tBodyAccMag

        tGravityAccMag

        tBodyAccJerkMag

        tBodyGyroMag

        tBodyGyroJerkMag

From here a Fast Fourier Transform was applied to some of the readings in the frequency domain:

        fBodyAcc-XYZ (Body acceleration in the X,Y, and Z direction in the frequency domain)

        fBodyAccJerk-XYZ (Jerk signal in the X,Y, and Z direction in the frequency domain)

        fBodyGyro-XYZ (Gyroscope signal in the X,Y, and Z direction in the frequency domain)

The magnitudes of each of these measurements was then calculated using the usual Euclidean distance:

        fBodyAccMag

        fBodyAccJerkMag

        fBodyGyroMag

        fBodyGyroJerkMag

Various quantities were estimated for each variable such as mean, standard deviation, max, min.

All the values were also normalized so that there values lie between -1 and 1.

Processed Data:

The goal of this project was to extract all the measurements which contained the mean and standard deviation for each measurement. We have chosen to exclude the weighted average of the frequency components to obtain a mean frequency, which is denoted by the suffix meanFreq() in the raw data set. The processing we did is the following, a line by line description is commented in the code and also contained below. We first read all the data sets into R. The training and test data sets were then combined into a single data frame. A search was performed using the R function “grepl” to find all occurrences of “-mean()” and “-std()” and then we extracted those rows into a new data frame called SortData. For ease of reading we replaced “-mean()” and “-std()”
in the variable names with “MEAN” and “STD”. The SortData data frame was then sorted by subject number and then activity number. We then calculated the mean of each variable contained in the SortData data frame by subject number and activity number. This was stored in the data frame MeanData. A substitution of the activity number for the activity name was then made. Finally, the 2 data frames, SortData and MeanData, were then written to 2 tab delimited .txt files to a local folder on my computer. This format can easily be read into Excel.

How to use the script:

The Rscript can be run in R without loading any additional packages. You will need to change the working directories in the R script on lines 2-11 and 135-136. The data loaded is in contained in the following files in the folder HAR:

        features.txt
        
        subject_test.txt
        
        X_test.txt
        
        y_test.txt
        
        subject_train.txt
        
        X_train.txt
        
        y_train.txt
        
        


Description of the R Script by line:

2-11: Reads all the files to separate data frames that are going to be processed from a local folder. A description of each file 
is contained in the CodeBook.

15: Combines the X_test and X_train data frames by row into one data frame.

18: Combines the Subject numbers from both the test and training subjects into one data frame

21: Binds the activity number for both the test and the training data sets

28: Names the columns of the data frame that contains all the data from both the training and the test data.

32: Constructs an empty matrix that we will dump the mean and standard deviations for each variable.

36: Empty vector which will store the variable names of the mean and standard deviation.

40-44: Extracts all the mean values of the variables and stores them into a matrix. Uses the grepl function to find all occurrences of “-mean()”.
Stores the name of extracted variable in the “names” vector.

46-51: Extracts all the standard deviation of the variables and stores them into a matrix. Uses the grepl function to find all occurrences of “-std()”.
Stores the name of extracted variable in the “names” vector.

54: Deletes all the "-" characters from the header names for ease of reading using “gsub”.

57: Replaces "mean()" with "MEAN" from the header names for ease of reading using “gsub”.

60: Replaces "std()" with "STD" from the header names for ease of reading using “gsub”.

63: Creates a character vector that will serve as the header of the data frame.

66: Converts the matrix into a data frame.

69: Adds the subject number and activity number to the data set

75: Adds the header which contains the names of all the variables. The first column is the subject number, second column is the activity number, etc. The other columns are listed in the codebook.

80: Sorts the data by subject number and then activity number. This is a data frame that contains 66 (mean and standard deviation) + 2 (subject and activity) variables with 10,299 observations.

94: Creates an empty data frame that will store the means of each of the variables. It has size 180 rows and 68 columns. This is because there are 6 x 30=180 different combinations of subjects and activities then 66+2 different variables.

97: We start a counter at 1 so that we can fill the data frame.

101-102: Runs two for loops. One for each subject and then one for each activity that the subject does.

106-107: Fills the rows of the empty data frame with the mean of the columns for each activity and each subject.

113: Creates the header for the MeanData data frame. The header is exactly the same as the SortData data frame. 

116-128: Substitute the activity name instead of the activity number in both data frames SortData and MeanData.

135-136: Writes the MeanData data frame, which contains 180 observations of 66+2 different variables, to a .txt file to a local folder on my computer. The file is a tab delimited text file so that it can be easily imported into Excel or back into R if needed. We have also  deleted the row names, which are just the row numbers in this case. Also writes the SortData data frame to a local folder on my computer as tab delimited .txt file.
