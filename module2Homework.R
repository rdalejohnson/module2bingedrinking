#R. Dale Johnson
#Module 2 Homework - binge drinking data set

##### NAs in the index column discusssion: 
#Source: https://stackoverflow.com/questions/14261619/subsetting-r-data-frame-results-in-mysterious-na-rows

bingeDrinking <- read.csv(file="Binge_Drinking.csv", header=TRUE, sep=",")

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

mylist <- split(bingeDrinking,  bingeDrinking$gender)

malesOnly <- mylist$'1'

femalesOnly <- mylist$'2'

####NA counting ###########
#Source: https://stackoverflow.com/a/24027625/3500818
###

sum(is.na(malesOnly$age))

sum(is.na(femalesOnly$age))

sum(is.na(bingeDrinking$age))

sum(is.na(bingeDrinking$gender))

#######################################
# NAs, subsetting, and the other values in the rows becomgin NAs:
# source: https://www.r-bloggers.com/subsetting-in-the-presence-of-nas/






########### SUBSETTING #####################################
# Source, by Wickham: http://adv-r.had.co.nz/Subsetting.html


############### Frequency distribution #################

summary(bingeDrinking$age)

summary(malesOnly$age)

summary(femalesOnly$age)