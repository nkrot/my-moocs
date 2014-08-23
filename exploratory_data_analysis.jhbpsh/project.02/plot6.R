#
# Compare emissions from motor vehicle sources in Baltimore City with emissions
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
#

library(ggplot2)

SCC = readRDS("Source_Classification_Code.rds")
vehicles = grep("vehicle", SCC$EI.Sector, ignore.case=T)
vehicles_scc = SCC[vehicles,]$SCC

NEI = readRDS("summarySCC_PM25.rds")
NEI_vehicles  = subset(NEI, NEI$SCC %in% vehicles_scc) # 1119 observations

year_totals_by_fips = function(req_fips, fips_location_name) {
  df = subset(NEI_vehicles, fips == req_fips)

  year_totals = aggregate(df$Emissions, by=list(year=df$year), FUN=sum)
  
  # rename the column name: x -> emissions
  colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"

  # Add a column filled with fips_location_name
  year_totals[, "Location"] = rep(fips_location_name, nrow(year_totals))
#  print(year_totals)

  return(year_totals)  
}

# join two tables (one below another)
year_totals = rbind(year_totals_by_fips("24510", "Baltimore City"),
                    year_totals_by_fips("06037", "LA County"))

#year_totals
#=>
#year  emissions       Location
#1 1999  346.82000 Baltimore City
#2 2002  134.30882 Baltimore City
#3 2005  130.43038 Baltimore City
#4 2008   88.27546 Baltimore City
#5 1999 3931.12000      LA County
#6 2002 4274.03020      LA County
#7 2005 4601.41493      LA County
#8 2008 4101.32100      LA County

### COLORED BAR CHART

png("plot6-bars.png")

p1 = qplot(as.factor(year), data = year_totals,
            weight = emissions, # uses it for Y instead of counts
            geom = "bar", #"path", "histogram"
            fill = Location,
            xlab = "Year",
            ylab = "Emissions, tons",
            main = "Emissions by Year+Location") 

print(p1)

dev.off()

### CURVES

png("plot6-lines.png")
  
p2 = ggplot(year_totals, aes(x=year, y=emissions, colour=Location)) +
    #geom_line() +
    geom_smooth(alpha=.2, size=1) + # does it make sense?
    ggtitle("Emissions by Year+Location")

print(p2)
  
dev.off()


