#Code Book

##Getting and Cleaning Data Project

1) The file "run_analysis.R" will read and perform the 'Human Activity Recognition Using Smartphones Data Set' available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

2) It merges both training and test sets ("X_train.txt" and "X_test.txt").

3) It includes the subjects who performed the activities ("subject_train.txt and" "subject_test.txt").
4) It does NOT include the Inertial Signals.
5) It properly labels all the data.
6) It subsets the data using only subjects and measurement that are mean values or standard deviation values.
7) It does NOT use in the data subset any of the 'angle' values, although they are calculated using mean values.
8) It creates a tidy data set with the average of each of the variables on the data subset for each activity and each subject.
9) It exports the final tidy data set to a 'dataProj.csv'.
10) In the final file you will have a row for the average of each measured variable of the subset and each column represents a subject.activity.
