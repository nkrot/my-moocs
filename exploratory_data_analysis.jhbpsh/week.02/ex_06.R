#
# colored histogram
# for each time of drive (front, rear, 4-weel)

library(ggplot2)

qplot(hwy, data = mpg, fill = drv)
