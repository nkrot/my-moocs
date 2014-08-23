# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the *base* plotting system, make a plot showing the total PM2.5 emission from all sources
# for each of the years 1999, 2002, 2005, and 2008.
#

NEI = readRDS("summarySCC_PM25.rds")

year_totals = aggregate(NEI$Emissions, by=list(year=NEI$year), FUN=sum)
# rename the column name: x -> emissions
colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"

#print(year_totals)
#=>
#year emissions
#1 1999   7332967
#2 2002   5635780
#3 2005   5454703
#4 2008   3464206

####
# manually recompute total emissions per year
# => the same figures as aggregate computed
#for (y in unique(NEI$year)) {
#  data = subset(NEI, year == y)$Emissions
#  total = sum(data, na.rm = TRUE)
#  print(y)
#  print(total)
#}

### VERTICAL LINES

png("plot1-vert.png")

plot(year_totals,
     #pch = 5,
     type = "h", # vertical lines, a-la histogram
     lwd = 7,
     col = "blue",
     xlab = "Year",
     ylab = "Emissions, tons",
     main = "Total Amount of Emissions Per Year")

# draw the line that shows the tendency
# => decreasing
model = lm(emissions ~year, year_totals)
abline(model, lwd = 1, col=3)

dev.off()

### BAR CHART

png("plot1-bars.png")

barplot(year_totals$emissions, 
        names.arg = as.character(year_totals$year),
        ylim = range(year_totals$emissions),
        col = "blue",
        xpd = FALSE,
        xlab = "Year",
        ylab = "Emissions, tons",
        main = "Total Amount of Emissions Per Year")

dev.off()
