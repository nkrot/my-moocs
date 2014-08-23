#
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
#

SCC = readRDS("Source_Classification_Code.rds")
#str(SCC)

vehicles = grep("vehicle", SCC$EI.Sector, ignore.case=T)
vehicles_scc = SCC[vehicles,]$SCC
#vehicles_scc #=> 1138

NEI = readRDS("summarySCC_PM25.rds")
NEI_vehicles = subset(NEI, fips == "24510" & (NEI$SCC %in% vehicles_scc)) # 1119 observations
#str(NEI_vehicles)

#unique(NEI_vehicles$type) #=> ON-ROAD only

year_totals = aggregate(NEI_vehicles$Emissions, 
                        by=list(year=NEI_vehicles$year),
                        FUN=sum)
# rename the column name: x -> emissions
colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"
#year_totals

png("plot5.png")

plot(year_totals,
     pch = 5,
     xlab = "Year",
     ylab = "Total Emissions, tons",
     main = "Emissions from Motor Vehicle Sources in Baltimore")

# draw the line that shows the tendency
# => decreasing
model = lm(emissions ~year, year_totals)
abline(model, lwd = 1, col=3)

dev.off()
