# title: "BST 611 SAS Lab for  Regression "
# author: "BST 611"

# read your file
lab=read.csv("Binge_Drinking.csv")


# change "1/2" to "Male/Female"
lab$gender = gsub(1, "Male",lab$gender)
lab$gender = gsub(2, "Female",lab$gender)

#Six rows in our binge drinking dataset have a NA for gender
#Sort by gender and then look at the last few rows to see
#the NA values in the gender column:
print(tail(lab[order(lab$gender),], n=10))

#and six rows have a NA age value:
print(tail(lab[order(lab$age),], n=10))

#the subset operation will take the NA gender when you ask for MALES only
#for some reason
male <- lab[lab$gender=="Male", ]
print(tail(male[order(male$gender),], n=10))

#and the same goes for FEMALE:

female <- lab[lab$gender=="Female", ]
print(tail(female[order(female$gender),], n=10))

#And note that in the rows at the bottom of both sets that
#we just printed, ALL the values in the row have suddenly
#become NAs.  Just weird


# So, to subset a dataset only contains male and truly omits the NA values, use
# an extra condition
male_with_NA_excluded <- lab[lab$gender=="Male" & !is.na(lab$gender), ]
print(tail(male_with_NA_excluded[order(male_with_NA_excluded$gender),], n=10))

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
print(labs_with_no_NA_anywhere)



summary(lab$age)

summary(male$age)

summary(female$age)

summary(male_with_NA_excluded$age)

summary(female_with_NA_excluded$age)

summary(labs_with_no_NA_anywhere$age)


