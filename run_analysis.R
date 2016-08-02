setwd("~/Dropbox/Coursera/UCI HAR Dataset")

variablesNames<-read.table("features.txt") #read in the variable names
vecNames<-as.vector(variablesNames[,2]) 
actLab<-read.table("activity_labels.txt") #read in activity names
actNames<-as.vector(actLab[,2])


setwd("~/Dropbox/Coursera/UCI HAR Dataset/test")

testData<-read.table("X_test.txt") # read in test data
testAct<-read.table("y_test.txt") #read in activities for test data
testLab<-read.table("subject_test.txt") # read in subjects for test data
testActName<-c() #empty vector to convert number activities to factors

setwd("~/Dropbox/Coursera/UCI HAR Dataset/train")

trainData<-read.table("X_train.txt") #read in train data
trainAct<-read.table("y_train.txt") #read in train activities
trainLab<-read.table("subject_train.txt") #read in subjects for test data
trainActName<-c() #empty vector to convert number activities to factors

for(i in 1:561){names(trainData)[i]<-vecNames[i]} #changing the variable names
for(i in 1:561){names(testData)[i]<-vecNames[i]}
for(i in 1:length(testAct[,1])){for(j in 1:6){if(testAct[i,1]==j){testActName[i]=vec[j]}}}
#converting numbers to activities
for(i in 1:length(trainAct[,1])){for(j in 1:6){if(trainAct[i,1]==j){trainActName[i]=vec[j]}}}
#converting numbers to activities


testTot<-data.frame(testLab,testActName,testData) #concatinating activity subject and data
trainTot<-data.frame(trainLab,trainActName,trainData)
names(testTot)[1]<-"Volunteer_Number" #renaming variables
names(trainTot)[1]<-"Volunteer_Number"
names(testTot)[2]<-"Activity"
names(trainTot)[2]<-"Activity"
allTot<-rbind(testTot,trainTot) #combining test and train data
colSel<- grep("Volunteer|Activity|*[Mm]ean*|*std*", names(allTot)) #colection mean and std
subTot<-allTot[,colSel]
library(dplyr)
subByAct<-group_by(subTot,Activity,Volunteer_Number) #grouping by activity and subject
final<-summarise_each(subByAct,funs(mean)) #finding mean of other variables
setwd("~/Dropbox/Coursera/UCI HAR Dataset")
write.table(final,file="GetandCleanproj.txt", row.name=FALSE) #writing final