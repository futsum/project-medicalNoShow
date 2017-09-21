### Project - Predicting Medical Appointment No-Shows
### Futsum Mosazghi

# Dataset: noshow.csv
# Source: https://www.kaggle.com/joniarroba/noshowappointments/version/1

#Required libraries
library(ggplot2)

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

#converting the dates to date format
noshow_data$AppointmentRegistration = as.Date(noshow_data$AppointmentRegistration)
noshow_data$AppointmentDate = as.Date(noshow_data$AppointmentDate)

#calculating the number of waiting time
noshow_data$AwaitingTime = as.integer(noshow_data$AppointmentDate -
                                        noshow_data$AppointmentRegistration)
noshow_data$App_Month = factor(months(noshow_data$AppointmentDate))

noshow_data[5:13]= lapply(noshow_data[5:13], factor)

noshow$Day = factor(noshow$Day, levels = c('Monday', 'Tuesday', 'Wednesday',
                                           'Thursday', 'Friday', 'Saturday','Sunday'),
                    ordered = T)
str(noshow_data)  

#a new data without appointment date and registration date
noshow = noshow_data[,-c(3,4)]
str(noshow)

summary(noshow)
sum(noshow$Age < 0)
noshow = noshow[noshow$Age >= 0,]
#the number and proportion of no-show status in the dataset
table(noshow$Status)
round(prop.table(table(noshow$Status)) * 100)

#plotting the no-show proportion
ggplot(noshow, aes(Status)) +
  geom_bar(aes(fill = Status)) + 
  labs(title = "Medical Appointment Status")

#the status of no-show by Age
ggplot(noshow, aes(Status, Age)) +
  geom_boxplot(aes(fill= Status)) +
  labs(title = "Medical Appointment Status by Age")
summary(noshow$Age[noshow$Status == 'No-Show'])
summary(noshow$Age[noshow$Status == 'Show-Up'])

#the status of medical appointment by Gender
gender_grid1 = ggplot(noshow, aes(Gender, fill = Status)) +
  geom_bar() 

gender_grid2 = ggplot(noshow, aes(Gender, fill = Status)) +
  geom_bar(position = 'fill') 

grid.arrange(gender_grid1, gender_grid2, ncol = 2,
             top ='Medical Appointment Status by Gender')
  
round(prop.table(table(noshow$Status[noshow$Gender == 'F'])) * 100)
round(prop.table(table(noshow$Status[noshow$Gender == 'M'])) * 100)

#medical appointment status by Scholarship
scholarship_grid1 = ggplot(noshow, aes(Scholarship, fill = Status)) +
  geom_bar(position = 'dodge')
  #labs(title = "Medical Appointment Status by Scholarship")
scholarship_grid2 = ggplot(noshow, aes(Scholarship, fill = Status)) +
  geom_bar(position = 'fill')
grid.arrange(scholarship_grid1, scholarship_grid2, ncol = 2, 
             top = "Medical Appointment Status by Scholarship" )
    
round(prop.table(table(noshow$Status[noshow$Scholarship == '0'])) * 100)
round(prop.table(table(noshow$Status[noshow$Scholarship == '1'])) * 100)

#Medical appointment Status by sms reminder
sms_grid1 = ggplot(noshow, aes(factor(sms_Reminder), fill = Status)) +
  geom_bar()

sms_grid2 = ggplot(noshow, aes(factor(sms_Reminder), fill = Status)) +
  geom_bar(position = 'fill')

grid.arrange(sms_grid1, sms_grid2, ncol = 2, 
             top = "Medical Appointment Status by sms Reminder" )
round(prop.table(table(noshow$sms_Reminder)) * 100,2)

#Medical appointment status by waiting time
ggplot(noshow, aes(Status, AwaitingTime)) +
  geom_boxplot(aes(fill = Status)) +
  labs(title = 'Medical Appointment Status by the duration of waiting days')
summary(noshow$AwaitingTime[noshow$Status == 'No-Show'])
summary(noshow$AwaitingTime[noshow$Status == 'Show-Up'])

#Medical appointment status by the day of the week
ggplot(noshow, aes(Day, fill = Status)) +
  geom_bar() 
ggplot(noshow, aes(Day, fill = Status)) +
  geom_bar(position = 'fill') 

#Medical appointment status by the appointment month
ggplot(noshow, aes(App_Month, fill = Status)) +
  geom_bar() 
ggplot(noshow, aes(App_Month, fill = Status)) +
  geom_bar(position = 'fill') 

