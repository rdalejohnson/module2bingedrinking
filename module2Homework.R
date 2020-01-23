#R. Dale Johnson
#Module 2 Homework - binge drinking data set

bingeDrinking <- read.csv(file="Binge_Drinking.csv", header=TRUE, sep=",")

bingeDrinking


########################
head(bingeDrinking)
print(nrow(bingeDrinking)) #gets you number of rows only
print(ncol(bingeDrinking)) #gets you number of rows only
print(dim(bingeDrinking))  #gets you rows and columns - the dimension
print(colnames(bingeDrinking))

#Column Headings
names(bingeDrinking)

###############################
# Source: https://stackoverflow.com/a/19327079/3500818

mylist <- split(bingeDrinking, bingeDrinking$gender)

malesOnly <- mylist$'1'

femalesOnly <- mylist$'2'

malesOnly

femalesOnly

