# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
# from 1999 to 2008?
# Use the base plotting system to make a plot answering this question.

NEI = subset(readRDS("summarySCC_PM25.rds"), fips == "24510")
#str(NEI)

year_totals = aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)
# rename the column name: x -> emissions
colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"

#print(year_totals)
#=>
#year emissions
#1 1999  3274.180
#2 2002  2453.916
#3 2005  3091.354
#4 2008  1862.282

png("plot2.png")

plot(year_totals,
     pch = 4, lwd = 2,
     xlab = "Year",
     ylab = "Emissions",
     main = "Total Emissions Per Year in Baltimore")

# draw the line that shows the tendency
# => decreasing
model = lm(emissions ~year, year_totals)
abline(model, lwd = 1, col=3)

####
# manually recompute total emissions per year
# => the same figures as aggregate computed
#for (y in unique(NEI$year)) {
#  data = subset(NEI, year == y)$Emissions
#  total = sum(data, na.rm = TRUE)
#  print(y)
#  print(total)
#}

dev.off()
