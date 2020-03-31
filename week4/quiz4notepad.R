## notepad for Week 4 quiz in 'Getting and Cleaning Data' course in Coursera

# load packages
library(lubridate)
library(tidyverse)
library(quantmod)

# loading in GDPdata and Edudata from week 3 since those data sets are used in this quiz
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
fileUrl2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(fileUrl1, '~/GettingAndCleaningData/week4/GDPdata', method = 'curl')
download.file(fileUrl2, '~/GettingAndCleaningData/week4/EduData', method = 'curl')
GDPdata <- read_csv('~/GettingAndCleaningData/week4/GDPdata')
EduData <- read_csv('~/GettingAndCleaningData/week4/EduData')

# QUESTION 1 -------------------------------------------------------------------------
# apply strsplit() to split all names of data frame on the characters 'wgtp'. what is the value of the 123rd element?

# load in data
fileUrl3 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl3, '~/GettingAndCleaningData/week4/Idaho_ACS.csv')
Idaho_survey <- read.csv('~/GettingAndCleaningData/week4/Idaho_ACS.csv')

#split names
splitNames <- strsplit(names(Idaho_survey), 'wgtp')
splitNames[123]


# QUESTION 2 -------------------------------------------------------------------------
# what is the average GDP in millions of dollars from the the world bank GDP data?
# already loaded in GDP data (see above)

# tidy up data
GDPheaders <- c('CountryCode', 'GDPRank', 'EconomicRegion', 'GDP_total_USD')
GDPdata_tidy <- GDPdata[5:194, c(1,2,4,5)]
colnames(GDPdata_tidy) <- GDPheaders

# remove commas from GPD_total_USD and find the average
GDP_nums <- gsub(',','',GDPdata_tidy$GDP_total_USD)
mean(as.numeric(GDP_nums))


# QUESTION 3 -------------------------------------------------------------------------
# how many countries in data set from Q2 have names that begin with "United"?
grep("^United",GDPdata_tidy$EconomicRegion)


# QUESTION 4 -------------------------------------------------------------------------
# merge GDPdata and EduData based on country shortcode - column 'CountryCode' is the only shared column
mergedData <- merge(GDPdata_tidy, EduData, by = 'CountryCode')

# after many different combinations, determined regex that reflects which countries have june as end of fiscal year
length(grep('[Ff]iscal.+[Jj]une', mergedData$`Special Notes`)) # returns 13 indexes
length(grep('[Jj]une.+[Ff]iscal', mergedData$`Special Notes`)) # returns 0 indexes

# QUESTION 5 -------------------------------------------------------------------------
# download amazon stock prices and the times the data was sampled
# how many values colelcted in 2012? how many values colelcted on mondays in 2012?

# load in data with code provided in quiz
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# format the sampleTimes vector to include weekday name and year, subset values in 2012 and further subset Mondays in 2012
formatTimes <- format(sampleTimes, '%a %Y')
subsetting <- grep('2012',formatTimes)
year_subset <- formatTimes[subsetting]
length(year_subset)
length(grep('Mon',year_subset))
