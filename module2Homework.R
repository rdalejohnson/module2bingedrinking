#R. Dale Johnson
#Module 2 Homework - binge drinking data set

bingeDrinking <- read.csv(file="Binge_Drinking.csv"), header=TRUE, sep=",")

bingeDrinking


########################
head(bingeDrinking)
print(nrow(bingeDrinking)) #gets you number of rows only
print(ncol(bingeDrinking)) #gets you number of columns only
print(dim(bingeDrinking))  #gets you rows and columns - the dimension
print(colnames(bingeDrinking))

#Column Headings
names(bingeDrinking)

###############################
# Source for using split: https://stackoverflow.com/a/19327079/3500818
###

mylist <- split(bingeDrinking, drop=FALSE , bingeDrinking$gender)

malesOnly <- mylist$'1'

femalesOnly <- mylist$'2'

malesOnly

femalesOnly

####NA counting ###########
#Source: https://stackoverflow.com/a/24027625/3500818
###

sum(is.na(malesOnly$age))

sum(is.na(femalesOnly$age))

sum(is.na(bingeDrinking$age))

########### SUBSETTING #####################################
# Source, by Wickham: http://adv-r.had.co.nz/Subsetting.html


############### Frequency distribution #################

summary(bingeDrinking$age)

summary(malesOnly$age)

summary(femalesOnly$age)