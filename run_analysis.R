library(plyr)

#Set Dataset Path relative to the working directory
dataPath <- 'UCI HAR Dataset'

#Set FilePaths
featuresFile <- file.path(dataPath, 'features.txt')
labelFile <- file.path(dataPath, 'activity_labels.txt')

#test directory
test_yTest <- file.path(dataPath, 'test/y_test.txt')
test_xTest <- file.path(dataPath, 'test/x_test.txt')
test_subject_test <- file.path(dataPath, 'test/subject_test.txt')

#train directory
train_yTest <- file.path(dataPath, 'train/y_train.txt')
train_xTest <- file.path(dataPath, 'train/x_train.txt')
train_subject_test <- file.path(dataPath, 'train/subject_train.txt')

#Read Labels and Features and add 'labels' and 'subject' on top of Features
features <- read.table(featuresFile)
features <- features[2]
colnames(features) <-'features'
features <- rbind(data.frame(features=c('labels','subject')),features)
labels <- read.table(labelFile)

#Create test dataframe
df_test<-cbind(read.table(test_yTest),read.table(test_subject_test),read.table(test_xTest))

#Create train dataframe
df_train<-cbind(read.table(train_yTest),read.table(train_subject_test),read.table(train_xTest))

#Create df_complete dataframe
df_complete<-join(df_train,df_test)

#Name the columns of df_complete
names(df_complete)<-features[1:563,]

#Factor df_complete
df_complete$labels <- factor(df_complete$labels, levels=labels[,1], labels=labels[,2])

#Check if df_complete contain 'mean' or 'std'
useCol<-c(1,2)
for (i in 3:length(df_complete)){
    if(length(grep('mean',names(df_complete)[i]))==1){
        useCol<-append(useCol,i)
    }else if(length(grep('std',names(df_complete)[i]))==1){
        useCol<-append(useCol,i)
    }
}

#Subset of df_complete
subsetData<-df_complete[,useCol]

#split subsetData
splitData<-split(subsetData,list(subsetData$subject,subsetData$labels))

#Generate final dataProj with the mean of every variable of splitData
dataProj<-sapply(splitData, function(x) colMeans(x[3:length(names(subsetData))]))

#write dataProj as a csv file
write.csv(dataProj, file="./dataProj.csv")
