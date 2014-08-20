#
# week 2 quiz, question 2
#
# Q: What is produced by the following code?
#    1) A set of 3 panels showing the relationship between weight and time for each diet. -- 
#    2) A set of 16 panels showing the relationship between weight and time for each rat.
#    3) A set of 3 panels showing the relationship between weight and time for each rat.
#    4) A set of 11 panels showing the relationship between weight and diet for each time. 

library(nlme)
library(lattice)

xyplot(weight ~ Time | Diet, BodyWeight)

#### my

head(BodyWeight)
#Grouped Data: weight ~ Time | Rat
#weight Time Rat Diet
#1    240    1   1    1
#2    250    8   1    1
#3    255   15   1    1
#4    260   22   1    1
#5    262   29   1    1
#6    258   36   1    1

unique(BodyWeight$Diet)
#=>
#[1] 1 2 3
#Levels: 1 2 3
