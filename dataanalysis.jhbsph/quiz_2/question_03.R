# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#
# https://dl.dropbox.com/u/7710864/data/csv_hid/ss06hid.csv or here
# https://spark-public.s3.amazonaws.com/dataanalysis/ss06hid.csv
#
# and load the data into R. You will use this data for the next several questions. The code book, describing the variable names is here:
#
#https://dl.dropbox.com/u/7710864/data/PUMSDataDict06.pdf or here:
#
#https://spark-public.s3.amazonaws.com/dataanalysis/PUMSDataDict06.pdf
#
#How many housing units in this survey were worth more than $1,000,000? 

# ok
#method <- "curl"
#download.file("https://dl.dropbox.com/u/7710864/data/csv_hid/ss06hid.csv", "ss06hid.csv", method)
#download.file("https://dl.dropbox.com/u/7710864/data/PUMSDataDict06.pdf", "PUMSDataDict06.pdf", method)

data <- read.csv("ss06hid.csv")

#rich <- data[data$VAL == 24,]
print(sum(data$VAL == 24, na.rm=TRUE)) #=> 53
