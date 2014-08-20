#
# adding a geom (statistic)
#
# a smoother (loess) is kind of summary of data showing the overall trend
# see: http://en.wikipedia.org/wiki/Local_regression
#
# instead of loess can use liner regression, with method = "lm"


library(ggplot2)
str(mpg) # miles-per-gallon

# "point" to show the points themselves
# "smooth" to show the regression line
qplot(displ, hwy, data = mpg, geom = c("point", "smooth"))
