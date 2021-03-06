#
#
#

library(ggplot2)

# 
str(mpg) # miles-per-gallon
# =>
#'data.frame':  234 obs. of  11 variables:
#  $ manufacturer: Factor w/ 15 levels "audi","chevrolet",..: 1 1 1 1 1 1 1 1 1 1 ...
#$ model       : Factor w/ 38 levels "4runner 4wd",..: 2 2 2 2 2 2 2 3 3 3 ...
#$ displ       : num  1.8 1.8 2 2 2.8 2.8 3.1 1.8 1.8 2 ...
#$ year        : int  1999 1999 2008 2008 1999 1999 2008 1999 1999 2008 ...
#$ cyl         : int  4 4 4 4 6 6 6 4 4 4 ...
#$ trans       : Factor w/ 10 levels "auto(av)","auto(l3)",..: 4 9 10 1 4 9 1 9 4 10 ...
#$ drv         : Factor w/ 3 levels "4","f","r": 2 2 2 2 2 2 2 1 1 1 ...
#$ cty         : int  18 21 20 21 16 18 18 18 16 20 ...
#$ hwy         : int  29 29 31 30 26 26 27 26 25 28 ...
#$ fl          : Factor w/ 5 levels "c","d","e","p",..: 4 4 4 4 4 4 4 4 4 4 ...
#$ class       : Factor w/ 7 levels "2seater","compact",..: 2 2 2 2 2 2 2 2 2 2 ...

#qplot(displ, hwy, data = mpg) # qplot(x, y, data)

# additionally, color by drv factor (front, rear, 4-wheels)
qplot(displ, hwy, data = mpg, color = drv)
