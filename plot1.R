
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have Total PM2.5 Emissions decreased in the United States from 1999 to 2008?
#Open file device
png(file="plot1.png")

#Sum Emissions By Year
totalEmissions <- tapply(NEI$Emissions, as.factor(NEI$year), sum)

#Add a year variable for display on the X-axis
wYearCols <- cbind(c(1999,2002,2005,2008), totalEmissions)

#Call Plot function
plot(wYearCols, type="l", xlab="Year", ylab="Total Emissions", main="Total PM2.5 from All Sources")

#Close file device
dev.off()

#Yes it looks like PM2.5 Emissions have in fact decreased over that time period.







