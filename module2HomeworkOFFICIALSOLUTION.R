# title: "BST 611 SAS Lab for  Regression "
# author: "BST 611"

# set working directory 
#setwd("D:/FuchenchuWang/UAB/BST 611/conversion")

# read your file
lab=read.csv("Binge_Drinking.csv")

# Split the dataset by Gender 
# 1 = Male
# 2 = Female""

# change "1/2" to "Male/Female"
lab$gender = gsub(1, "Male",lab$gender)
lab$gender = gsub(2, "Female",lab$gender)

# subset a dataset only contains male
male_with_NA_excluded <- lab[lab$gender=="Male" & !is.na(lab$gender), ]
male <- lab[lab$gender=="Male", ]

female <- lab[lab$gender=="Female" , ]
female_with_NA_excluded <- lab[lab$gender=="Female" & !is.na(lab$gender),]

sum(is.na(male$age))

sum(is.na(female$age))

sum(is.na(lab$age))

sum(is.na(lab$gender))


summary(lab$age)

summary(male$age)
hist(male$age)

summary(female$age)
hist(female$age)

summary(male_with_NA_excluded$age)
hist(male_with_NA_excluded$age)

summary(female_with_NA_excluded$age)
hist(female_with_NA_excluded$age)

# Recode the continuous variable, Age, into three groups:  < 20 years; 20-25 years; and >25 years
age_in_year= ifelse(lab$age<=19,1,
                    ifelse(lab$age>19 & lab$age<=25, "2","3"
                    ))
lab_new=cbind(lab,age_in_year)
table(lab_new$age_in_year)


# Figure
lab$drinks5 = gsub(1, "None",lab$drinks5)
lab$drinks5 = gsub(2, "Once",lab$drinks5)
lab$drinks5 = gsub(3, "Twice",lab$drinks5)
lab$drinks5 = gsub(4, "three to five",lab$drinks5)
lab$drinks5 = gsub(5, "six to nine",lab$drinks5)
lab$drinks5 = gsub(6, "more than ten",lab$drinks5)

# give x label a order, otherwise it will show in alphabet
x.order=c("None","Once", "Twice","three to five","six to nine","more than ten")
lab$drinks5 = factor(lab$drinks5, levels=unique(x.order))

figure=cbind(lab[,c(1,2,6)])
figure.delete=na.omit(figure)

library(ggplot2)
plot(ggplot(figure.delete, aes(x=drinks5,y=age,color=gender,group=gender)) + geom_smooth(method="loess",se=F)+labs(x="Binge Drinking",y="Age (years)",title="Age and Binge Drinking by Gender"))
