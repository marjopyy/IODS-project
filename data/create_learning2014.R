# Marjo Pyy-Martikainen
# 4.11.2020
# Creating an analysis data set from file 
# http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt


library(tidyverse)
library(dplyr)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
# Data set lrn14 contains 183 observations and 60 variables
str(lrn14)
summary(lrn14)
# Variables:
# Aa-Dj (integer): answers to questions about students' attitudes towards statistics, Likert scale [1,5] 
# Age (integer): age of student
# Attitude (integer): a summary measure of 10 questions
# Points (integer): exam points
# gender (character): F/M

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# create a new variable deep by averaging over deep questions
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)
# create a new variable surf by averaging over surface questions
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)
# create a new variable stra by averaging over strategic questions
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

learn14 <- lrn14 %>% filter(Points>0) %>% select(gender,Age,Attitude,deep,stra,surf,Points)

getwd()
# C:/Users/anita/OneDrive/Tiedostot/IODS-project

# Save the data as a csv file to folder data in the working directory
write.csv(learn14,"./data/learning2014.csv",row.names=F)

test_data <- read.csv("./data/learning2014.csv")
str(test_data)
head(test_data)
