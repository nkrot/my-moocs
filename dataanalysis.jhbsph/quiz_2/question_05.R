#
# Use the data you loaded from Question 3.
# How many households have 3 bedrooms and 4 total rooms?
# How many households have 2 bedrooms and 5 total rooms?
# How many households have 2 bedrooms and 7 total rooms?
#
#
# BDS - number of bedrooms, qualitative, classes needed: 3 and 2
# RMS - number of rooms, qualitative, classes needed: 4,5,7 

data <- read.csv("ss06hid.csv")

print("How many households have 3 bedrooms and 4 total rooms?")
print(sum(data$BDS == 3 & data$RMS == 4, na.rm=T))
# => 148

print("How many households have 2 bedrooms and 5 total rooms?")
print(sum(data$BDS == 2 & data$RMS == 5, na.rm=T))
# => 386

print("How many households have 2 bedrooms and 7 total rooms?")
print(sum(data$BDS == 2 & data$RMS == 7, na.rm=T))
# => 49


