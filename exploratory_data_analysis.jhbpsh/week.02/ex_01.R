#
# from week 2 lectures
#

library(datasets)
library(lattice)

head(airquality)
#=>
#Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6

# convert Month to factor
aq = transform(airquality, Month = factor(Month))
head(aq) # the same?

unique(aq$Month)
#=> [1] 5 6 7 8 9

# use 5 panels, for every of 5 months
pl = xyplot(Ozone ~ Wind | Month, data = aq, layout = c(5,1)) # pl is object of clss trellis
#pl         # is autoprinted
print(pl)   #
