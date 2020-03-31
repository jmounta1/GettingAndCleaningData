# notepad for the Week 3 quiz in "Getting and Cleaning Data"

# load packages necessary for all questions in the quiz
library(tidyverse)
library(jpeg)


# QUESTION 1 --------------------------------------------------------------
# identify households on greater than 10 acres who sold more than $10,000 in agricultural products
# load in data
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl1, '~/GettingAndCleaningData/quizInfo_week3/ACS_community-survey_Idaho')
Idaho_survey <- read_csv('~/GettingandCleaningData/quizInfo_week3/ACS_community-survey_Idaho')

# find households(rows) that fit quiz criteria (acreage over 10, sol over $10,000 of ag products)
homes_subset_logical <- as.logical(Idaho_survey$ACR == 3 & Idaho_survey$AGS == 6)
which(homes_subset_logical)[1:3]

# QUESTION 2 ----------------------------------------------------------------
# what are the 30th and 80th quantiles of the readJPEG results of a picture of the instructor?
# load in data
fileUrl2 <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(fileUrl2, '~/GettingAndCleaningData/quizInfo_week3/quizPicture', method = 'curl')
pic <- readJPEG('~/GettingAndCleaningData/quizInfo_week3/quizPicture',native = TRUE)
quantile(pic, probs = c(0.30,0.80))

# QUESTION 3-5 --------------------------------------------------------------
# 3) what is the country with the 13th lowest GDP rank in the dataset?
# 4) What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# 5) cutting into 5 quartile groups, make table vs income group, which countries are among 38 highest GD but lower middle income
# load in data
fileUrl3 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
fileUrl4 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
download.file(fileUrl3, '~/GettingAndCleaningData/quizInfo_week3/GDPdata', method = 'curl')
download.file(fileUrl4, '~/GettingAndCleaningData/quizInfo_week3/EduData', method = 'curl')
GDPdata <- read_csv('~/GettingAndCleaningData/quizInfo_week3/GDPdata')
EduData <- read_csv('~/GettingAndCleaningData/quizInfo_week3/EduData')

# Tidy data (EduData already tidy)
GDPheaders <- c('CountryCode', 'GDPRank', 'EconomicRegion', 'GDP_total_USD')
GDPdata_tidy <- GDPdata[5:dim(GDPdata)[1], c(1,2,4,5)]
colnames(GDPdata_tidy) <- GDPheaders

# Merge data sets, tidy
mergedData <- merge(GDPdata_tidy, EduData)
countryInfo <- select(mergedData,c('CountryCode', 'Long Name', 'GDPRank', 'Income Group', 'GDP_total_USD'))
countryInfo <- countryInfo[!is.na(countryInfo$GDPRank),]
countryInfo$GDPRank <- as.integer(countryInfo$GDPRank)

# Order data set by GDP rank (decreasing, so USA is last), determine # of matches between the merged data sets and display 13th row in data set
countryInfo_ordered <- countryInfo[order(countryInfo$GDPRank, decreasing = T), ]
print(paste(dim(countryInfo)[1],'matches'))   #even though there are GDP ranks to 190, there are only 189 matches after the merge
# this is because GDPdata included Sudan (GDP Rank #73) and South Sudan (GDP Rank #131), but EduData only had Sudan - South Sudan is skipped
countryInfo_ordered[13,]

# Find average GDP rank for countries in high income OECD and high income non OECD groups
highIncome_OECD <- countryInfo[countryInfo$`Income Group`=='High income: OECD', ]
mean(highIncome_OECD$GDPRank)
highIncome_nonOECD <- countryInfo[countryInfo$`Income Group`=='High income: nonOECD', ]
mean(highIncome_nonOECD$GDPRank)

# Cut GDP ranking into 5 quantile groups, make table versus Income Group, how many countries are lower middle income but top 38 nations in GDP?
country_by_GDP <- countryInfo[order(countryInfo$GDPRank), ]
GDPgroups <- floor(quantile(country_by_GDP$GDPRank, probs = seq(0,1,0.2)))
highGDP <- country_by_GDP[GDPgroups[1]:GDPgroups[2], ]
sum(str_count(highGDP$`Income Group`, 'Lower middle income'))
