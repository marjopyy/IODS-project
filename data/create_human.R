# Marjo Pyy-Martikainen
# 21.11.2020
# creating analysis data set for IODS excercise 5

# Brief description of data
# The original data was created by United Nations and it contains several indicators for most countries of the
# world. The indicators are related to wealth, health, education and gender equality. 
# The orinal data was retrieved from
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv
# http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv

library(tidyverse)

# read data sets into R
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")


dim(hd)
# hd: 195 observations and 8 variables
dim(gii)
# gii: 195 observations and 10 variables

# rename variables
# create two new variables
hd  <- setNames(hd, c('hdi_rank','country','hdi','leb','educ_exp','educ_mean','gni','gni_hdi_rank'))
gii <- setNames(gii,c('gii_rank','country','gii','mm_ratio','abr','rpar','edu2_f','edu2_m','lf_f',
                      'lf_m')) %>%
  mutate(edu2_fm=edu2_f/edu2_m,lf_fmr=lf_f/lf_m)

# join datasets by country, only observations appearing in both datasets retained
human <- inner_join(hd,gii,by='country')
# save data in folder data
save(human, file = "./data/human.Rdata")


################### Start of data wrangling for Exercise 5 #################################

load(file = "./data/human.Rdata")

dim(human) # 195 observations, 19 variables
str(human)

# Variables in human data
# Wealth and health: gni, gni_hdi_rank, leb, mm_ratio, abr
# Education: educ_exp, educ_mean
# Gender equality: gii, gii_rank, rpar, edu2_f, edu2_m, edu2_fm, lf_f, lf_m, lf_fmr

# transform variable gni to numeric
human <- human %>% mutate(gni=as.numeric(str_replace(gni,pattern=",",replace=""))) 
# keep only variables needed
human <- human %>% select(country,edu2_fm,lf_fmr,educ_exp,leb,gni,mm_ratio,abr,rpar)  

# remove observations with missing values
human_cc <- human[complete.cases(human),]

# remove rows related to regions instead of countries
tail(human_cc,n=10) # last 7 rows relate to regions
lastc=nrow(human_cc)-7
human_f <- human_cc[1:lastc,]


# add country as rownames
rownames(human_f) <- human_f$country

# remove country from variables
human_f_ <- human_f %>% dplyr::select(-country)
#human_ <- select(human, -Country)

# save data in folder data
save(human_f_, file = "./data/human_f_.Rdata")

# check that everything is ok
load(file = "./data/human_f_.Rdata")
