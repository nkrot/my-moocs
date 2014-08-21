#
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make
# a plot answer this question.
#

library(ggplot2)

NEI = subset(readRDS("summarySCC_PM25.rds"), fips == "24510")
#str(NEI)

year_totals = aggregate(NEI$Emissions, by=list(type=NEI$type, year=NEI$year), FUN=sum)
# rename the column name: x -> emissions
colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"
#str(year_totals)

#print(year_totals)
#=>
#type year  emissions
#1  NONPOINT 1999 2107.62500
#2  NON-ROAD 1999  522.94000
#3   ON-ROAD 1999  346.82000
#4     POINT 1999  296.79500
#5  NONPOINT 2002 1509.50000
#6  NON-ROAD 2002  240.84692
#7   ON-ROAD 2002  134.30882
#8     POINT 2002  569.26000
#9  NONPOINT 2005 1509.50000
#10 NON-ROAD 2005  248.93369
#11  ON-ROAD 2005  130.43038
#12    POINT 2005 1202.49000
#13 NONPOINT 2008 1373.20731
#14 NON-ROAD 2008   55.82356
#15  ON-ROAD 2008   88.27546
#16    POINT 2008  344.97518

png("plot3.png")

# 4 facets
#qplot(year, emissions,
#      data = year_totals,
#      facets = type ~ .,
#      geom = c("point", "smooth"))

# TODO
# 1. is that true using smooth makes sense if we use the original data rather than totals
# 2. add a regression line? isnt it "smooth"?

# found here: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_%28ggplot2%29/
p = ggplot(year_totals, aes(x=year, y=emissions, colour=type)) +
    #geom_line() +
    geom_smooth(alpha=.2, size=1) + # TODO: does it make sense?
    ggtitle("Emissions by types of sources")

print(p)

####
# manually recompute total emissions per year
# => the same figures as aggregate computed
#for (y in unique(NEI$year)) {
#  for (t in unique(NEI$type)) {
#    data = subset(NEI, year == y & type == t)$Emissions
#    total = sum(data, na.rm = TRUE)
#    print(y)
#    print(t)
#    print(total)
#  }
#}

dev.off()
