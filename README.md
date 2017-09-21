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

![summary] (https://user-images.githubusercontent.com/2644463/30721186-0396cbac-9ee8-11e7-89bb-957b99636470.PNG)

Reference
Kim, S. H., Myers, C. G., & Allen, L. (2017, August 31). Health Care Providers Can Use Design Thinking to Improve Patient Experiences. Harvard Business Review. Retrieved from https://hbr.org/2017/08/health-care-providers-can-use-design-thinking-to-improve-patient-experiences


