#
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
#
# Here need to decide which column from SCC to used for identifying "coal combustion-related sources"

SCC = readRDS("Source_Classification_Code.rds")
#str(SCC)

# matches "comb" and "coal" in any order
# \\b around "coal" anchors match at word boundary so that charcoal is not matched
re = "(\\bcomb.*\\bcoal\\b)|(\\bcoal\\b.*\\bcomb)"

#sectors = unique(SCC$EI.Sector)
#sectors                                     #=> there are 59 sectors
#grep(re, sectors, ignore.case=T, value=T)   #=> of which three relate(?) to coal and combustion

sectors_with_comb_coal = grep(re, SCC$EI.Sector, ignore.case=T)
#sectors_with_comb_coal
scc_ids = SCC[sectors_with_comb_coal,]$SCC
#scc_ids

NEI = readRDS("summarySCC_PM25.rds")
NEI_for_comb_coal = subset(NEI, NEI$SCC %in% scc_ids) # 2848 observations

#str(NEI_for_comb_coal)

#with(NEI_for_comb_coal, plot(year, Emissions))

year_totals = aggregate(NEI_for_comb_coal$Emissions, 
                        by=list(year=NEI_for_comb_coal$year),
                        FUN=sum)
# rename the column name: x -> emissions
colnames(year_totals)[which(names(year_totals) == "x")] = "emissions"
#year_totals

title = "Yearly Emissions from Coal Combustion-Related Sources"

### DOTS WITH REGRESSION LINE

png("plot4-points.png")

plot(year_totals,
      pch = 5,
      xlab = "Year",
      ylab = "Total Emissions, tons",
      main = title)
  
# draw the line that shows the tendency
# => decreasing
model = lm(emissions ~year, year_totals)
abline(model, lwd = 1, col=3)

dev.off()

### SMOOTHED LINE

library(ggplot2)

png("plot4.png")

p2 = ggplot(year_totals, aes(x=year, y=emissions)) +
        #geom_line() + # a line that simply connects the points
        #geom_smooth(alpha=.2, size=1, method="lm") + # a straight line
        geom_smooth(alpha=.2, size=1) +
      ggtitle(title)

print(p2)

dev.off()


### COLORED BAR CHART

png("plot4-bars.png")

p3 = qplot(as.factor(year), data = year_totals,
           weight = emissions, # uses it for Y instead of counts
           #ylim = range(year_totals$emissions), TODO: with this, no bars are shown
           xlab = "Year",
           ylab = "Total emissions, tons",
           main = title) +
  geom_bar(colour="blue", fill="blue") 

print(p3)

dev.off()

