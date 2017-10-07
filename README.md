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

Normalizing some of the variables

The range of the values of some of the variables (Age & Awaiting Time) is wider than the rest of the variables. These two variables need to be normalized so that they don’t have unfair influence on the classifier. After normalizing these variables, the result is that all the variables are with the range of 0 and 1. 

![Normilized Variables](https://user-images.githubusercontent.com/2644463/31247557-3009c4aa-a9ce-11e7-9231-c11ca185d441.PNG)

Now, the new dataset consists the targeted, normalized, dummied and the rest of the variables.

![new data](https://user-images.githubusercontent.com/2644463/31247910-471772a4-a9cf-11e7-946a-0b1288537f8d.PNG)

Training and Test Sets

The dataset is split into training (70%) and test (30%) sets; training set is used to train the learner and a test set is used to evaluate the performance of the learner. Both sets reflect the original dataset with a record of 30% of no-shows and 70% show-ups. 


![proportion of Status](https://user-images.githubusercontent.com/2644463/31259609-3e2c95f8-aa05-11e7-9034-2a93b204d0f7.PNG)

Model Building

Artificial Neural Network (ANN) Model

In this project, the nnet package is used to build an artificial neural network (ANN) classifier. The ANN classifier was trained using the training set. With some trial and error on the parameters of the nnet function, a hidden layer of size 30, a maximum iteration of 1000, and a decay of 5e-4 seems to produce a better outcome. 

![ANN model1](https://user-images.githubusercontent.com/2644463/31260179-562d29ac-aa09-11e7-85d0-3a4889d0542f.PNG)

The model is a 31-30-1 network with 991 weights. 

![Ann Summary1](https://user-images.githubusercontent.com/2644463/31260185-5d1bfc66-aa09-11e7-9ba4-de68a7607625.PNG)

Prediction 
The ANN classifier was used to predict the status of the examples in the test set. 

![Ann prediction1](https://user-images.githubusercontent.com/2644463/31260424-14d89750-aa0b-11e7-920b-86836c1367c3.PNG)

The prediction outcome of the first 6 examples are:

![Ann Prediction Outcome1](https://user-images.githubusercontent.com/2644463/31260434-2420a004-aa0b-11e7-9eed-b72943d5c030.PNG)

Performance Evaluation

The overall accuracy of the learner is 66.92%. The sensitivity rate (true positive or no-show agreement between the predicted and the observed values) is 13.4% and the specificity rate (true negative or show-up agreement between the predicted and the observed values) is 90%. A Kappa of 4.3% indicates a poor agreement between the predicted and observed values. The interest of the project is to target potential no-show patients. At 13.4%, the model misclassified 2,334 no-show patients as show-up patients. At this sensitivity rate, the model’s performance can be considered as poor. Had the interest been on the show-up, a 90% specificity rate could have been considered a strong performance. 

![Ann Performance1](https://user-images.githubusercontent.com/2644463/31260968-c2ebc256-aa0e-11e7-9be5-59f356ca8d72.PNG)

Support Vector Machine (SVM) Model

Support Vector Machine (SVM) was used to develop a classifier and compare it with the ANN model. The e1071 package was used to develop a SVM learner. 

![SVM Model1](https://user-images.githubusercontent.com/2644463/31262726-525c5666-aa1a-11e7-8f46-048db47c41a9.PNG)

![SVM Summary1](https://user-images.githubusercontent.com/2644463/31262884-7da1c1a2-aa1b-11e7-8210-87ef006b8d83.PNG)

Different kernel types (linear, radial, and sigmoid) have been used to develop the SVM learner; they all produce the same performance. The overall accuracy rate is 69.73%, which is an improvement from the ANN model. The specificity rate is 100% but the sensitivity rate is 0%; the SVM model misclassified all the no-shows as show-ups. At 0%, the Kappa rate indicates that the agreement between the predicted values and the observed values is very poor. Since our goal is to identify the potential no-show patients, this model performed very poor. 

![SVM Performance](https://user-images.githubusercontent.com/2644463/31262735-66fd8428-aa1a-11e7-85c1-2123a9351c3d.PNG)


Feature Selection

Can we improve the model’s performance using feature selection? Feature selection method helps to identify subset of feature that are required to build a model; not all features are equally important in model building. A recursive feature elimination function from the caret package has been used to eliminate those features not necessary required to develop a model. The selected features are “Age”, “Awaiting Time”, and “Alcoholism”. 

![Selected Features](https://user-images.githubusercontent.com/2644463/31261532-0c8002da-aa12-11e7-8894-fd0b15113478.PNG)

Listing the importance of the selected features:

![Importance of Features](https://user-images.githubusercontent.com/2644463/31261533-136d6d76-aa12-11e7-979a-c63a0c4e3a44.PNG)

ANN model using the selected features

Using the selected features, another ANN classifier was built. 

![Ann Model2](https://user-images.githubusercontent.com/2644463/31261878-56ee6e9a-aa14-11e7-8d99-5183a509d43d.PNG)

This classifier has an overall accuracy rate of 69.66%, sensitivity rate of 1.8%, and a specificity rate of 99%. The selected features improves neither the accuracy rate nor the sensitivity rate. 

![Ann perfromance2](https://user-images.githubusercontent.com/2644463/31261885-5fd56400-aa14-11e7-9324-5e0299a2f052.PNG)

SVM model using the selected features

Using the selected features, another SVM classifier was built. 

![SVM Feature Model](https://user-images.githubusercontent.com/2644463/31263190-e8a05e58-aa1d-11e7-8c8e-5a71b30438a9.PNG)

This model produced the same performance outcome as the previous SVM model.

![SVM performance2](https://user-images.githubusercontent.com/2644463/31263217-089703c4-aa1e-11e7-96a4-93cac3c31099.PNG)

Balancing the dataset

The poor sensitivity rate observed in both the ANN and SVM learners is an indication of an imbalanced classification dataset; the majority status of the examples is a show-up; show-ups outnumber no-shows. The model is not getting enough information about the minority (no-show) status. Therefore, the model is biased towards show-ups, and it misclassifies the no-shows as show-ups when predicting the status of an example. 

To balance the dataset, ROSS package has been used. 

![Ross balanced](https://user-images.githubusercontent.com/2644463/31310781-6252c716-ab5b-11e7-8706-628065e7683e.PNG)

Using oversampling technique, ROSE replicated the now-show observations to balance the dataset. Now, the proportion of the dataset is 50% of each class. 

![Balanced data Proportion](https://user-images.githubusercontent.com/2644463/31310785-6cbb9b06-ab5b-11e7-8139-27ea0fc2c31a.PNG)

Using the balanced dataset, the accuracy rate of an ANN model is 60.82% and the specificity rate is 72.45%, both metrics are less than the classifiers we build so far. However, the sensitivity rate has significantly improved to 34%.  

![Ann Balanced Performance](https://user-images.githubusercontent.com/2644463/31310789-7795d00a-ab5b-11e7-9099-b65687e24371.PNG)

SVM model using the balanced dataset

An SVM classifier using the balanced dataset generated an accuracy rate of 58.99% and a specificity of 64.17%; very low comparing with the above models. However, the sensitivity rate has increased to 47%, which is quite an improvement. 

![Svm balanced model](https://user-images.githubusercontent.com/2644463/31310875-59f98b5c-ab5d-11e7-87b0-f7a64a27f44b.PNG)

Tuning the SVM model

Can tuning the SVM learner improve the performance of the model? The SVM classifier was tuned to find out the best gamma and cost parameters using the tune.svm() function. 

![svm tune](https://user-images.githubusercontent.com/2644463/31310959-571b6fac-ab5f-11e7-91b9-4da42c25c26f.PNG)

The best parameters are a 0.01 gamma and a 100 cost. 

![svm_best parameters]()







Reference

Kim, S. H., Myers, C. G., & Allen, L. (2017, August 31). Health Care Providers Can Use Design Thinking to Improve Patient Experiences. Harvard Business Review. Retrieved from https://hbr.org/2017/08/health-care-providers-can-use-design-thinking-to-improve-patient-experiences


