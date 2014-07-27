## run_analysis is defined in the following steps:
1. read in the test data    
2. read in the train data    
3. merge data sets into one (train top, test bottom)
4. subset X data by extracting only mean and std columns
5. append activity data to the first column of dataset
6. append subject data to the first column of dataset
7. split data based on subject ids
8. for every subject in list, split data by activity id and find average per activity for each column
9. write tidy data to file