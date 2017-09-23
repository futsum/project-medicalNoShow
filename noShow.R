### Project - Predicting Medical Appointment No-Shows
### Futsum Mosazghi

# Dataset: noshow.csv
# Source: https://www.kaggle.com/joniarroba/noshowappointments/version/1

#Required libraries
library(ggplot2)
library(gridExtra)

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

#are there any missing values in the dataset
sum(is.na(noshow_data))

### Data Preparation
#converting the date variables from categorical type to date format
noshow_data$AppointmentRegistration = as.Date(noshow_data$AppointmentRegistration)
noshow_data$AppointmentDate = as.Date(noshow_data$AppointmentDate)

# the Awaiting time variable is showing negative days. We can either change it to a positive 
# variable using abs() function or calculate it ourselves
# noshow_data$AwaitingTime = abs(noshow_data$AwaitingTime)
# here we'll calcuate it ourselves
noshow_data$AwaitingTime = as.integer(noshow_data$AppointmentDate -
                                        noshow_data$AppointmentRegistration)

#let's find the months for the appointment dates and change it to categorical variable
noshow_data$App_Month = factor(months(noshow_data$AppointmentDate), 
                               levels = c('January','February','March','April','May',
                                          'June','July','August','September',
                                          'October','November','December'),
                               ordered = T)

# let's convert sms reminder to yes or no response, i.e, any number of text will be
# a 'Yes' and no text will be a 'No'
noshow_data$sms_Reminder = ifelse(noshow_data$sms_Reminder > 0, 1, 0)

#let's change the categorical variables from integer to factor
noshow_data[5:14]= lapply(noshow_data[5:14], factor)

#let's order the day of the week from Monday to Sunday
noshow_data$Day = factor(noshow_data$Day, levels = c('Monday', 'Tuesday', 'Wednesday',
                                           'Thursday', 'Friday', 'Saturday','Sunday'),
                    ordered = T)


str(noshow_data)  

#we don't need appointment date and registration date for our classification
#a new data without appointment date and registration date
noshow = noshow_data[,-c(3,4)]
str(noshow)

#lets see the summary of the dataset. The variable age has negative numbers
summary(noshow)

#the variable age has 4 negative numbers, which doesn't make sense
sum(noshow$Age < 0)

#we will remove the four observations; since it's a fraction of the total
#observations, it won't make a difference to our analysis
noshow = noshow[noshow$Age >= 0,]
#the number and proportion of no-show status in the dataset

#new structure of the dataset
str(noshow)

#new summary
summary(noshow)

#number and proportion of no-show
table(noshow$Status)
round(prop.table(table(noshow$Status)) * 100)

###visual description

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
ggplot(noshow, aes(Day, fill = Status)) +
  geom_bar() +
  labs(title = 'Medical Appointment Status by the Day of the Week')

ggplot(noshow, aes(Day, fill = Status)) +
  geom_bar(position = 'fill') +
  labs(title = 'Medical Appointment Status by the Day of the Week')

#proportion of appointment status by the day of the week
table(noshow$Day)
round(prop.table(table(noshow$Day)) * 100,2)
round(prop.table(table(noshow$Day[noshow$Status == 'No-Show'])) * 100, 2)

#Medical appointment status by the appointment month
ggplot(noshow, aes(App_Month, fill = Status)) +
  geom_bar() 

ggplot(noshow, aes(App_Month, fill = Status)) +
  geom_bar(position = 'fill') 

#proportion of appointment status by the day of the week
table(noshow$App_Month)
round(prop.table(table(noshow$App_Month)) * 100,2)
round(prop.table(table(noshow$App_Month[noshow$Status == 'No-Show'])) * 100, 2)

