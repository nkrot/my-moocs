# Question:
# I am interested in examining how the relationship between ozone and wind speed varies
# across each month. 
# What would be the appropriate code to visualize that using ggplot2?

library(ggplot2)
library(datasets)
data(airquality)

# option 1
#qplot(Wind, Ozone, data = airquality, geom = "smooth")
# => a plot with a (regression?) curve

# option 2 -- NOT RUNNABLE
#qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))

# option 3 -- this is the answer, as this is the pnly plot that has 5 panels
# each for a month
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

# option 4
#qplot(Wind, Ozone, data = airquality)
# => scatter plot, with dots
