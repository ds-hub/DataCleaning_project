run_analysis <- function(){
    # read in the test data
    xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
    ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
    subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
    
    # read in the train data
    xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
    ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
    subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
    
    # merge data sets into one (train top, test bottom)
    xdata <- rbind(xtrain,xtest)
    ydata <- rbind(ytrain,ytest)
    subjectdata <- rbind(subjecttrain, subjecttest)
    
    # subset X data by extracting only mean and std columns
    xdata_mean_std <- xdata[,c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,227:228,240:241,253:254,266:271,345:350,424:429,503:504,516:517,529:530,542:543)]
   
    # append activity data to the first column of dataset
    tidydata <- cbind(ydata,xdata_mean_std)
    
    # append subject data to the first column of dataset
    tidydata <- cbind(subjectdata,tidydata)
    
    # rename the appended columns
    colnames(tidydata)[1:2] <- c("subject", "activity")
    
    # split data based on subject ids
    subjectsplit <- split(tidydata, tidydata$subject)
    
    # final tidydata, output
    tidydata2 <- data.frame()
        
    # for every subject in list, split data by activity id
    # and find average per activity for each column
    for(subject in 1:length(subjectsplit))
    {
        # extract data for subject
        isubject <- subjectsplit[[subject]]
        
        # split into individual activities for subject
        activitysplit <- split(isubject,isubject$activity)
        for(activity in 1:length(activitysplit))
        {
            # extract activity for subject
            iactivity <- activitysplit[[activity]]
            
            # calculate the mean for each column 
            activityMeans <- colMeans(iactivity)
            
            # add means as a new row in final tidy data frame
            tidydata2 <- rbind(tidydata2, data.frame(as.list(activityMeans)))
        }
    }
    
    # write tidy data to file
    write.table(tidydata2, "tidydata.csv", sep=",")
}