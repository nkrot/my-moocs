# In addition to the data from Question 3, the American Community Survey also collects data about populations.
# Using download.file(), download the population record data from:
#   https://dl.dropbox.com/u/7710864/data/csv_hid/ss06pid.csv
# or here
#   https://spark-public.s3.amazonaws.com/dataanalysis/ss06pid.csv
#
# Load the data into R.
# Assign the housing data from Question 3 to a data frame housingData and the population data from above to a data frame populationData.
# Use the merge command to merge these data sets based only on the common identifier "SERIALNO".
# What is the dimension of the resulting data set?
#
# [OPTIONAL] For fun, you might look at the data and see what happened when they merged. 

#download.file("https://dl.dropbox.com/u/7710864/data/csv_hid/ss06pid.csv", "ss06pid.csv", "curl")

housing_data <- read.csv("ss06hid.csv")
population_data <- read.csv("ss06pid.csv")

merged <- merge(housing_data, population_data, by="SERIALNO", all=T)
print(dim(merged))
#=>15451   426

# without all=TRUE, the merge is incomplete - only common rows are merged
#=>14931 426


