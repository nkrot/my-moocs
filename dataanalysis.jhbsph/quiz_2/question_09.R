# What are the 0% and 100% quantiles of the variable YBL?
# Is there anything wrong with these values? Hint: you may need to use the na.rm parameter.
#
# YBL - years when the structure was first built

data <- read.csv("ss06hid.csv")

years <- data$YBL
#print(years)

print(quantile(years, na.rm=T))
#  0%  25%  50%  75% 100% 
#  -1    3    5    7   25 
# and something is wrong :)

# this also shows the quantiles (Min - 1st Qu - Median - 3rd Qu - Max )
# print(summary(years))
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
# -1.000   3.000   5.000   4.922   7.000  25.000 339.000 

# unique(data$YBL)
# [1]  5  3  2 NA 25  9  7 -1  6  8  4  1
# wow: not allowed values are 25 and -1

#table(data$YBL)
#  -1    1    2    3    4    5    6    7    8    9   25 
#   1  174  729 1153  693 1317  523  530  340  696    1 
