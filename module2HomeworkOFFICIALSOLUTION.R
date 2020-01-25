# title: "BST 611 SAS Lab for  Regression "
# author: "BST 611"

#SOURCES:
#NAs in the index column discusssion: https://stackoverflow.com/questions/14261619/subsetting-r-data-frame-results-in-mysterious-na-rows
#Using split to subset: https://stackoverflow.com/a/19327079/3500818
#NA counting: https://stackoverflow.com/a/24027625/3500818
#Remove any row containing an NA: http://uc-r.github.io/missing_values
#Using isNA: https://stackoverflow.com/questions/48658832/how-to-remove-row-if-it-has-a-na-value-in-one-certain-column
#NAs, subsetting, and the other values in the rows becomgin NAs:https://www.r-bloggers.com/subsetting-in-the-presence-of-nas/
#General discussion on subsetting: http://adv-r.had.co.nz/Subsetting.html


# read your file
lab=read.csv("Binge_Drinking.csv")

# change "1/2" to "Male/Female"
lab$gender = gsub(1, "Male",lab$gender)
lab$gender = gsub(2, "Female",lab$gender)


#
###########################################################
#Six rows in our bingedrinking dataset have a NA for gender
#Sort by gender and then look at the last few rows (the tail) to see
#the NA values in the gender column:
###########################################################
#

print(tail(lab[order(lab$gender),], n=10))

#and six rows have a NA age value:
print(tail(lab[order(lab$age),], n=10))

#the subset operation will take the MALE rows
#and the NA rows when you ask for MALES only
#for some reason
male <- lab[lab$gender=="Male", ]
print(tail(male[order(male$gender),], n=10))

#and the same goes for FEMALE:

female <- lab[lab$gender=="Female", ]
print(tail(female[order(female$gender),], n=10))

#And note that in the rows at the bottom of both sets that
#we just printed, ALL the values in the row have suddenly
#become NAs.  Just weird!

#And since both subsets "claim" the NA rows, the total number of rows in 
#the two subsets exceeds the number of rows in the original data set:

#gets you the total number of rows, which is 1400
#
print(nrow(lab))  

#gets you the number of female rows:
print(nrow(female)) 

#gets you the number of male rows:
print(nrow(male))

#Number of rows in both is 6 rows too large
print(nrow(male) + nrow(female))


# So, to subset a dataset and get ONLY the rows with gender= male 
# and to truly omit the NAs, 
# add an extra condition: !is.na(lab$gender)
# which means 'and the gender value in the row is NOT NA'

#Sorting after that you can see the NA rows are gone from the tail
#
male_with_NA_excluded <- lab[lab$gender=="Male" & !is.na(lab$gender), ]
print(tail(male_with_NA_excluded[order(male_with_NA_excluded$gender),], n=10))
#

female_with_NA_excluded <- lab[lab$gender=="Female" & !is.na(lab$gender),]
print(tail(female_with_NA_excluded[order(female_with_NA_excluded$gender),], n=10))


#you can use this set of commands to count the NAs in a column:

sum(is.na(male$gender))
sum(is.na(female$gender))

sum(is.na(male_with_NA_excluded$gender))
sum(is.na(female_with_NA_excluded$gender))


#And you can remove entire rows that have any NAs in them with this:
labs_with_no_NA_anywhere <- na.omit(lab)
sum(is.na(labs_with_no_NA_anywhere$gender))


#comparing the frequency distributions on age of all these approaches:

##########
## using a traditional subset
##########
#
summary(male$age)
summary(female$age)

##########
## using the extra explicit NA exclusions
##########
#
summary(male_with_NA_excluded$age)
summary(female_with_NA_excluded$age)



#
##################################################
#SPLIT can also be used to carve up the set by gender:
# Source for using split: https://stackoverflow.com/a/19327079/3500818
#and it automatically ignores the NAs without extra effort

mylist <- split(lab,  lab$gender)

malesOnlyusingSplit <- mylist$Male
femalesOnlyusingSplit <- mylist$Female


summary(male$age)
summary(male_with_NA_excluded$age)
summary(malesOnlyusingSplit$age)


summary(female$age)
summary(female_with_NA_excluded$age)
summary(femalesOnlyusingSplit$age)




#######################################
#######################################
#######################################
#######################################
#######################################
#######################################

library(ggplot2)


summary(malesOnlyusingSplit$age)
hist(malesOnlyusingSplit$age)


summary(femalesOnlyusingSplit$age)
hist(femalesOnlyusingSplit$age)


#sources for using CUT: 
#   https://www.r-bloggers.com/from-continuous-to-categorical/
#   https://www.r-bloggers.com/r-function-of-the-day-cut-2/
#   https://youtu.be/EWs1Ordh8nI
#   https://stackoverflow.com/questions/12245149/cut-include-lowest-values
#   https://stackoverflow.com/questions/40380112/categorize-continuous-variable-with-dplyr#40380312
#intervals will be closed on the RIGHT and open on the LEFT by default
#to switch the default closed interval to be the left one, add parameter “right=FALSE”
#to the cut invocation.
#Can use +Inf and -Inf in breaks list

#
lab$agecategories<-cut(lab$age, 
                       breaks=c(-Inf,20,26,+Inf), 
                       labels=c("Less than 20 Years Old", "20 to 25 Years Old", "Over 25 Years Old"), right=FALSE) 

summary(lab$agecategories)
#
#




############## PLOTTING ################3

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

plot(ggplot(figure.delete, aes(x=drinks5,y=age,color=gender,group=gender)) + 
       geom_smooth(method="loess",se=F) +
       labs(x="# Binge Drinking Episodes",y="Age (years)",title="Age and Binge Drinking by Gender"))
