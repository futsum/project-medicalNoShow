###################################################################
### Project - Prediction Model for Medical Appointment No-Shows ###
### Futsum Mosazghi ###
### 10/20/2017 ####################################################


### Dataset: noshow.csv
### Source: https://www.kaggle.com/joniarroba/noshowappointments/version/1

#Required libraries
library(ggplot2)
library(gridExtra)
library(e1071)
library(dummies)
library(caret)
library(nnet)
library(ROSE)

#Importing the dataset to R
noshow_data = read.table('noShow.csv', sep = ";", header = T)

#renaming the variable names
names(noshow_data) = c('Age', 'Gender', 'AppointmentRegistration',
                       'AppointmentDate','Day', 'Status', 'Diabetes',
                       'Alcoholism','Hypertension','Handicap', 
                       'Smokes', 'Scholarship', 'Tuberculosis',
                       'sms_Reminder', 'AwaitingTime')

#structure of the dataset
str(noshow_data)

#Missing values
#are there any missing values in the dataset
sum(is.na(noshow_data))

########################
### Data Preparation ###
########################

#converting the date variables from categorical type to date format
noshow_data$AppointmentRegistration = as.Date(noshow_data$AppointmentRegistration)
noshow_data$AppointmentDate = as.Date(noshow_data$AppointmentDate)

# the Awaiting time variable is showing negative days. We can either change it to a positive 
# variable using abs() function or calculate it ourselves
# noshow_data$AwaitingTime = abs(noshow_data$AwaitingTime)
# here we'll calcuate it ourselves
noshow_data$AwaitingTime = as.integer(noshow_data$AppointmentDate -
                                        noshow_data$AppointmentRegistration)

#let's find the months for the appointment dates
noshow_data$App_Month = factor(months(noshow_data$AppointmentDate))


# let's convert sms reminder to yes or no response, i.e, any number of text will be
# a 'Yes' and no text will be a 'No'
noshow_data$sms_Reminder = ifelse(noshow_data$sms_Reminder > 0, 1, 0)

#let's convert handicap to yes or no response as well
noshow_data$Handicap = ifelse(noshow_data$Handicap > 1, 1, 0)

#new data structure
str(noshow_data)  

#we don't need appointment date and registration date for our classification
#a new data without appointment date and registration date
noshow = noshow_data[,-c(3,4)]
str(noshow)

#let's see the summary of the dataset. The variable age has negative numbers
summary(noshow)

#the variable age has 4 negative numbers, which doesn't make sense
sum(noshow$Age < 0)

#we will remove the four observations; since it's a fraction of the total
#observations, it won't make a difference to our analysis
noshow = noshow[noshow$Age >= 0,]

#new structure of the dataset
str(noshow)

#new data summary
summary(noshow)

#number and proportion of no-show
table(noshow$Status)
round(prop.table(table(noshow$Status)) * 100)

##########################
### Visual Analysis ###
#########################

#plotting the no-show proportion
ggplot(noshow, aes(Status)) +
  geom_bar(aes(fill = Status)) + 
  labs(title = "Medical Appointment Status")

#the status of no-show by Age
ggplot(noshow, aes(Status, Age)) +
  geom_boxplot(aes(fill= Status)) +
  labs(title = "Medical Appointment Status by Age")

#summary of age by appointment status
summary(noshow$Age[noshow$Status == 'No-Show'])
summary(noshow$Age[noshow$Status == 'Show-Up'])

#the status of medical appointment by Gender
gender_grid1 = ggplot(noshow, aes(Gender, fill = Status)) +
  geom_bar() 

gender_grid2 = ggplot(noshow, aes(Gender, fill = Status)) +
  geom_bar(position = 'fill') 

grid.arrange(gender_grid1, gender_grid2, ncol = 2,
             top ='Medical Appointment Status by Gender')

#propertion of medical appointment status by gender
round(prop.table(table(noshow$Status[noshow$Gender == 'F'])) * 100)
round(prop.table(table(noshow$Status[noshow$Gender == 'M'])) * 100)

#medical appointment status by Scholarship
scholarship_grid1 = ggplot(noshow, aes(Scholarship, fill = Status)) +
  geom_bar(position = 'dodge')
  
scholarship_grid2 = ggplot(noshow, aes(Scholarship, fill = Status)) +
  geom_bar(position = 'fill')
grid.arrange(scholarship_grid1, scholarship_grid2, ncol = 2, 
             top = "Medical Appointment Status by Scholarship" )

#percentage of patients in scholarship
prop.table(table(noshow$Scholarship)) * 100

#propertion of status by scholarship
round(prop.table(table(noshow$Status[noshow$Scholarship == '0'])) * 100)
round(prop.table(table(noshow$Status[noshow$Scholarship == '1'])) * 100)

#Medical appointment Status by sms reminder
sms_grid1 = ggplot(noshow, aes(sms_Reminder, fill = Status)) +
  geom_bar()

sms_grid2 = ggplot(noshow, aes(sms_Reminder, fill = Status)) +
  geom_bar(position = 'fill')

grid.arrange(sms_grid1, sms_grid2, ncol = 2, 
             top = "Medical Appointment Status by SMS Reminder" )

#proportion of medical appointment status by sms reminder
round(prop.table(table(noshow$sms_Reminder)) * 100)
round(prop.table(table(noshow$Status[noshow$sms_Reminder == '0'])) * 100)
round(prop.table(table(noshow$Status[noshow$sms_Reminder == '1'])) * 100)

#Medical appointment status by waiting time
ggplot(noshow, aes(Status, AwaitingTime)) +
  geom_boxplot(aes(fill = Status)) +
  labs(title = 'Medical Appointment Status by the duration of waiting days')

#summary of medical appointment status by the length of waiting period
summary(noshow$AwaitingTime[noshow$Status == 'No-Show'])
summary(noshow$AwaitingTime[noshow$Status == 'Show-Up'])

#Medical appointment status by the day of the week
#let's first order the day of the week from Monday to Sunday
ordered_Day = factor(noshow$Day, levels = c('Monday', 'Tuesday', 'Wednesday',
                                                 'Thursday', 'Friday', 'Saturday','Sunday'),
                     ordered = T)
ggplot(noshow, aes(ordered_Day, fill = Status)) +
  geom_bar() +
  labs(title = 'Medical Appointment Status by the Day of the Week') +
  labs(x = "Day")

ggplot(noshow, aes(ordered_Day, fill = Status)) +
  geom_bar(position = 'fill') +
  labs(title = 'Medical Appointment Status by the Day of the Week') +
  labs(x = 'Day')

#proportion of appointment status by the day of the week
table(noshow$Day)
round(prop.table(table(noshow$Day)) * 100,2)
round(prop.table(table(noshow$Day[noshow$Status == 'No-Show'])) * 100, 2)

#Medical appointment status by the appointment month
#first let's order the months from January to December
ordered_App_Month = factor(months(noshow_data$AppointmentDate[noshow_data$Age >= 0]), 
                           levels = c('January','February','March','April','May',
                                      'June','July','August','September',
                                      'October','November','December'),
                           ordered = T)
ggplot(noshow, aes(ordered_App_Month, fill = Status)) +
  geom_bar() +
  labs(title = 'Medical Appointment Status by the Month of the year') +
  labs(x = 'Month')

ggplot(noshow, aes(ordered_App_Month, fill = Status)) +
  geom_bar(position = 'fill') +
  labs(title = 'Medical Appointment Status by the Month of the year') +
  labs(x = 'Month')

#proportion of appointment status by month of the year
table(noshow$App_Month)
round(prop.table(table(noshow$App_Month)) * 100,2)
round(prop.table(table(noshow$App_Month[noshow$Status == 'No-Show'])) * 100, 2)


#Relationship between Age and Awaiting time
ggplot(noshow, aes(Age, AwaitingTime)) +
  geom_point(aes(color = Status)) +
  labs(title = 'Relationship between Age, Awaiting Time & Appointment Status') 

################################################
### Appointment Status Classification ##########
################################################

#to speed up the computing time, let's reduce the size of the dataset
#select random observations - 10% of the original data
set(123)
i = sample(2, nrow(noshow), replace = T, prob = c(0.1,0.9))
resized_noshow = noshow[i ==1, ]
dim(resized_noshow)

#the composition of the new dataset is the same as the original dataset
# 30% noshows & 70% show-ups
round(prop.table(table(resized_noshow$Status)) * 100)


### coding using dummies
#convert the factor variables into dummies
noshow_dummies = dummy.data.frame(resized_noshow[c(2,3,14)])
str(noshow_dummies)


###normilizing the data
#creating a normaliing function
normalize = function(x) return ((x - min(x)) / (max(x) - min(x)))

#normilizing the variable Age and AwaitingTime
noshow_nor = as.data.frame(lapply(resized_noshow[c('Age','AwaitingTime')], 
                                  normalize))
summary(noshow_nor)

#combine the dummied variables and the normalized variables with the rest of the variables
new_noshow = data.frame(Status = resized_noshow$Status, resized_noshow[5:12],
                        noshow_nor,noshow_dummies)
str(new_noshow)


### Splitting the dataset into training (70%) and test (30%) sets using random sampling

set.seed(123)      #set.seed() will help to reproduce the outcome
random_samples = sample(2, nrow(new_noshow), replace = T, prob = c(0.7,0.3))
train_set = new_noshow[random_samples==1,]
test_set = new_noshow[random_samples==2,]

# number of observations for the training and test sets
nrow(train_set)
nrow(test_set)

#propertion of the training and test sets
round(prop.table(table(train_set$Status)) * 100)
round(prop.table(table(test_set$Status)) * 100)

##################################
### Building a model #############
##################################

###An Artificial Neural Network (ANN) Model###
# parameters are chosen using trial and error
noshow_ann = nnet(Status ~ ., data = train_set, decay = 5e-4,
                  size = 30, maxit = 1000, trace = F, set.seed(123))
summary(noshow_ann)

#prediction using the ANN model
noshow_ann_pred = predict(noshow_ann, test_set, type = 'class')

head(noshow_ann_pred)

#evaluating model performance
confusionMatrix(noshow_ann_pred, test_set$Status)


###Support Vector Machine (SVM) Model###
# parameters are chosen using trial and error

noshow_svm_classifier = svm(Status ~ ., data = train_set, 
                            kernel = 'radial', cost = 1, scale = F)

summary(noshow_svm_classifier)

#prediction using the svm model
noshow_svm_pred = predict(noshow_svm_classifier, test_set)
head(noshow_svm_pred)

#evaluating the performance of the svm classifier
confusionMatrix(noshow_svm_pred, test_set$Status)

###feature selection
#can we improve the model's performance using selected features
set.seed(123)
control <- rfeControl(functions=rfFuncs, method="cv", number=10)
results <- rfe(resized_noshow[,-4], resized_noshow[,4], 
               sizes=c(1:14), rfeControl=control)
print(results)

#the selected features are
predictors(results)

#plotting the importance of the the features
plot(results, type = c('g','o'))

#listing the importance of the features
varImp(results)

#building an ANN model using the selected features
noshow_ann2 = nnet(Status ~ Age + AwaitingTime + Alcoholism + Scholarship, 
                   data = train_set,
                   decay = 5e-4, size = 30, maxit = 1000,
                   trace = F, set.seed(123))

#prediction
noshow_ann2_pred = predict(noshow_ann2, 
                           test_set, type = 'class')

#model evaluation
confusionMatrix(noshow_ann2_pred, test_set$Status)


#building a SVM model using the selected features

noshow_svm_features = svm(Status ~ Age + AwaitingTime + Alcoholism + Scholarship, 
                          data = train_set, 
                          kernel = 'radial', cost = 1, scale = F)

summary(noshow_svm_features)

#prediction
svm_feature_pred = predict(noshow_svm_features, test_set)
head(svm_feature_pred)

#evaluating the performance
confusionMatrix(svm_feature_pred, test_set$Status)


###balancing the dataset
noshow_balanced = ROSE(Status ~ ., data = train_set, seed = 1)$data

#proportion of the balanced dataset
table(noshow_balanced$Status)
round(prop.table(table(noshow_balanced$Status))*100)

###build a model using the balanced dataset

noshow_ann3 = nnet(Status ~ ., data = noshow_balanced ,
                   decay = 5e-4, size = 30, maxit = 1000,
                   trace = F, set.seed(123))

#prediction
noshow_ann3_pred = predict(noshow_ann3, 
                           test_set, type = 'class')

#performance evaluation
confusionMatrix(noshow_ann3_pred, test_set$Status)


###building a model using the selected features & balanced data
noshow_ann4 = nnet(Status ~ Age + AwaitingTime + Alcoholism + Scholarship, 
                   data = noshow_balanced,
                   decay = 5e-4, size = 30, maxit = 1000,
                   trace = F, set.seed(123))

#prediction
noshow_ann2_pred = predict(noshow_ann2, 
                           test_set, type = 'class')

#evaluation
confusionMatrix(noshow_ann2_pred, test_set$Status)

###Support Vector Machine (SVM) Model using the balanced dataset

noshow_svm3 = svm(Status ~ ., data = noshow_balanced, 
                            kernel = 'radial', cost = 1, scale = F)


#prediction
noshow_svm3_pred = predict(noshow_svm3, test_set)


#evaluating the performance
confusionMatrix(noshow_svm3_pred, test_set$Status)

###tuning svm model - selecting the best parameters
svm_tuned = tune.svm(Status ~., data = noshow_balanced, gamma = 10^(-6:-1),
                     cost = 10^(1:2))
summary(svm_tuned)

#svm model using the selected parameters
tuned_model = svm(Status ~., data = noshow_balanced, 
                  gamma = svm_tuned$best.parameters$gamma,
                  cost = svm_tuned$best.parameters$cost)

#prediction
tuned_model_pred = predict(tuned_model)

#evaluation
confusionMatrix(tuned_model_pred, test_set$Status)


################### The End ##########################################



