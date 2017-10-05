Prediction of Medical Appointment No-Shows

According to an article in Harvard Business Review (HBR), approximately 3.6 million people miss medical appointments each year. Missed appointments not only create an obstacle in providing medical care to the patients, it also cost billions of dollars to the healthcare provider. Addressing the issue can improve patient experience and lower healthcare cost (Kim, Myers, & Allen, 2017). 

This project will attempt to develop a model that can predict those patients that are prone to miss medical appointments. Using historical medical dataset, a model can predict the behavior of patients regarding medical appointments. By predicting patients inclined to miss appointments, healthcare providers can design creative ways to solve the problem and encourage or help patients to keep their appointments.

R programming will be used for this project. Since the project is trying to predict no-show patients, a classification method will be used. A learner will be trained using a supervised learning method. The first part of the project will focus on exploratory data analysis; in the second part, machine learning model will be built to predict no-show patients. Both visual and non-visual analytical methods will be used to demonstrate the project. 

Data Collection

A dataset -Medical Appointment No-Shows, from Kaggle will be used for this project. The dataset is collected by healthcare providers in Brazil. This dataset is a medium-sized dataset with about 300,000 observations and 15 variables, and it is readily available in CSV format. 

Exploratory Data Analysis


The dataset has 15 variables and 300,000 observations. Our target variable is Status; we are interested in the variable Status as we are trying to predict those patients who are inclined to miss medical appointments. There are no missing values in our dataset. The explanatory variables are: 

•	Age of patients

•	Gender

•	The date appointment was registered

•	The appointment data

•	Day of the appointment week

•	Diabetes

•	Alcoholism

•	Hypertension

•	Handicap

•	Smoking habit

•	Tuberculosis

•	Sms Reminder - whether a patient is reminded using sms message

•	Awaiting time – the number of days a patient has to wait to see a doctor

We added another variable that shows the month on which the appointment date fall (Appointment Month). After initial data preparation, the structure of the dataset looks like: -

![data structure](https://user-images.githubusercontent.com/2644463/30719962-ef3d7d9a-9ee2-11e7-9fbc-167650c2529e.PNG)

Since the variables appointment registration data and appointment date are not useful for our classification, we will remove them from our dataset; we used both variables to create the variables awaiting time and appointment month, which we will use for the classification. Upon examining the summary of the dataset, the variable age has four negative values; this doesn’t make any sense. We will remove these four observations from the dataset; since the four observations are a fraction of the total 300,000 observations, removing them won’t affect our analysis. Now, our dataset has 14 variables and 299996 observations. 

The median age of the patients is 38 and there are more than twice women patients than men. The average waiting period is 13 days. July record the highest number of appointments; regarding day of the week, Wednesday set the highest number of appointments. 

![summary](https://user-images.githubusercontent.com/2644463/30721186-0396cbac-9ee8-11e7-89bb-957b99636470.PNG)

When we look at the appointment status, about 30% of patients failed to show up for their appointments; more patients (70%) kept their appointments.  

![status](https://user-images.githubusercontent.com/2644463/30722033-16dc1222-9eec-11e7-810d-bc4cee0e651c.PNG)

The median age of those patients who failed to show up for their appointment is 33; in contrast, the median age for those who showed up is 40. It seems that on average younger patients failed to show up more than the older patients. 

![status by Age](https://user-images.githubusercontent.com/2644463/30722411-50343430-9eee-11e7-9af7-b226e8f94a59.PNG)

Among female patients, 30% failed to show up; 31% male patients failed to show up. 

![Status by Gender](https://user-images.githubusercontent.com/2644463/30722604-640c8a88-9eef-11e7-98f2-c5aa0a729fab.PNG)

Ten percent of the patients are in scholarship. Among those in scholarship, 36% failed to show up for their medical appoints; in contrast only 30% among those without scholarship. 

![Status by Scholarship](https://user-images.githubusercontent.com/2644463/30723058-e6b8488a-9ef1-11e7-8435-6312e08854fd.PNG)

About 57% of patients received an sms message reminders. The data shows that there was no difference on the percentage of no-show (30%) between those who received sms message reminders and those who didn’t. Text message reminders doesn’t seem to help patients to keep their medical appointments. 

![Status By SMS Reminder](https://user-images.githubusercontent.com/2644463/30723418-80ee0f00-9ef4-11e7-940a-d09c91a272db.PNG)

The median waiting period for no-show is 11 days comparing to 7 days for show-up. 

![Status by waiting period](https://user-images.githubusercontent.com/2644463/30723758-934dc134-9ef6-11e7-9523-4d124a545a9d.PNG)

The highest number of appointments was recorded on Wednesdays followed by Tuesdays; only 4 appointments on Sundays. At 1338 number of observations (0.45% overall observations), Saturday seems to record relatively the highest proportion of no-shows followed by Monday (21.26% overall observations). 

![Status by Day](https://user-images.githubusercontent.com/2644463/30724695-ef5cfac0-9efc-11e7-9f73-5c8e7ddea308.PNG)

![Status by DayII](https://user-images.githubusercontent.com/2644463/30724705-faf85762-9efc-11e7-9191-36555af09e7e.PNG)

July saw the highest appointment record followed by October. Among the months, December seems to record relatively the highest proportion of no-show followed by July. 

![Status by Month](https://user-images.githubusercontent.com/2644463/30725190-00d9b196-9f00-11e7-92a6-055bec1541bc.PNG)

![Status by MonthII](https://user-images.githubusercontent.com/2644463/30725193-09eaed9a-9f00-11e7-9600-27f53c9f24a3.PNG)


Preparing the data for model building

Because the observations (299,996) in the dataset is fairly large, only 10% (29,831) of the observations is used for this project. The observations are randomly selected from the original data; that is, the composition of the new subset data is the same as the original data with 30% no-shows. This will significantly reduce the computing time of the analysis.

Converting the factor variables into integer using dummies

The categorical variables (Gender, Day, & Appointment Month) are converted into integer variables by coding them using dummies. The target variable (Status) is left as a categorical variable since the goal is to predict the class of a categorical variable. 

![Dummy variables](https://user-images.githubusercontent.com/2644463/31247054-af2aa36e-a9cc-11e7-8819-94101929572e.PNG)




Reference

Kim, S. H., Myers, C. G., & Allen, L. (2017, August 31). Health Care Providers Can Use Design Thinking to Improve Patient Experiences. Harvard Business Review. Retrieved from https://hbr.org/2017/08/health-care-providers-can-use-design-thinking-to-improve-patient-experiences


