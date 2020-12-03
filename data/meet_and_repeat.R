# Marjo Pyy-Martikainen
# 1.12.2020
# creating analysis data sets for IODS excercise 6

library(tidyverse)

# 1 Read data sets 

# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

# BPRS: check variable names, dimension, structure
colnames(BPRS)
dim(BPRS)
str(BPRS)
summary(BPRS)
# BPRS -> 40 men, divided into two treatment groups and measured at baseline (week0) and
# after treatment, at weekly intervals during 8 weeks (week1-week8). Each measurement is coded 
# into a separate variable. Measurement: Brief Psychiatric Rating Scale value.

# RATS: check variable names, dimension, structure
colnames(RATS)
dim(RATS)
str(RATS)
summary(RATS)
# RATS -> 16 rats divided into 3 groups, each having a different diet. Weights of rats
# measured weekly over a nine week period (two measurements at week 7). Each measurement is coded 
# into a separate variable. 

# 2 Convert categorical variables to factors 

# BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# create a unique id for individuals!
n <- nrow(BPRS)
BPRS$ID <- factor(c(1:n))
# RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3 Convert data sets to long form

# BPRS
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject, -ID) %>% 
mutate(week = as.integer(substr(weeks,5,5)))
# Take a glimpse 
glimpse(BPRSL)

# RATS
RATSL <- RATS %>% gather(key = WD, value = Weight, -ID, -Group) %>%
mutate(Time = as.integer(substr(WD,3,4))) 
# Take a glimpse 
glimpse(RATSL)


# 4 check variable names, dimension, structure of BPRSL and RATSL

# BPRSL
colnames(BPRSL)
dim(BPRSL)
str(BPRSL)
summary(BPRSL)
# BRRSL -> Each male has 9 rows in this data, each row corresponding to one measurement. 
# The measurements have been gathered into
# the variable bprs and the variable week indicates the week number of the measurement.
# The data set contains 360 rows (40*9) and 6 variables. 

# RATSL
colnames(RATSL)
dim(RATSL)
str(RATSL)
summary(RATS)

# RATSL -> Each rat has 11 rows in the data, each row corresponding to one measurement.
# The measurements have been gathered into the variable weight. The variable Time indicates 
# the time/order of the measurement. The data set contains 176 rows (16*11) and 5 variables.


# # save data sets in folder data
save(BPRSL, file = "./data/BPRSL.Rdata")
save(RATSL, file = "./data/RATSL.Rdata")
