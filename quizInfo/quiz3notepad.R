# notepad for the Week 3 quiz in "Getting and Cleaning Data"

# load packages necessary for all questions in the quiz
library(tidyverse)
library(jpeg)


# QUESTION 1 --------------------------------------------------------------
# identify households on greater than 10 acres who sold more than $10,000 in agricultural products
# load in data
fileUrl1 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
download.file(fileUrl1, '~/GettingAndCleaningData/quizInfo/ACS_community-survey_Idaho')
setwd('~/GettingandCleaningData/quizInfo')
Idaho_survey <- read_csv('ACS_community-survey_Idaho')

# find households(rows) that fit quiz criteria (acreage over 10, sol over $10,000 of ag products)
homes_subset_logical <- as.logical(Idaho_survey$ACR == 3 & Idaho_survey$AGS == 6)
which(homes_subset_logical)[1:3]

# QUESTION 2 ----------------------------------------------------------------
# what are the 30th and 80th quantiles of the readJPEG results of a picture of the instructor?
fileUrl2 <- 'http://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
download.file(fileUrl2, '~/GettingAndCleaningData/quizInfo/quizPicture', method = 'curl')
pic <- readJPEG('~/GettingAndCleaningData/quizInfo/quizPicture',native = TRUE)
quantile(pic, probs = c(0.30,0.80))

# QUESTION 3-5 --------------------------------------------------------------
# 3) what is the country with the 13th highest GDP in the dataset?
# 4) What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
# 5) cutting into 5 quartile groups, make table vs income group, which countries are among 38 highest GD but lower middle income

