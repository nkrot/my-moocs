#
# facets (almost the same as panels)
#

library(ggplot2)

qplot(displ, hwy, data = mpg, facets = . ~ drv)
