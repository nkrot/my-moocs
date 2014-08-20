#
# facets in histogram
#

library(ggplot2)

# 3 histograms, one over another
qplot(hwy, data = mpg, facets = drv ~., bandwidth=2)

# 3 histograms, side by side
# are easier to compare, the y axis shows counts is common
#qplot(hwy, data = mpg, facets = .~ drv, bandwidth=2)
