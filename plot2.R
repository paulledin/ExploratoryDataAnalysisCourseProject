## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Have Total PM2.5 Emissions decreased in the Baltimore City from 1999 to 2008?
#Open file device
png(file="plot2.png")

#Subset for Baltimore
BaltimoreCityEmissions <- NEI[NEI$fips=="24510",]

#Sum Emissions By Year
totalEmissions <- tapply(BaltimoreCityEmissions$Emissions, as.factor(BaltimoreCityEmissions$year), sum)

#Add a year variable for display on the X-axis
wYearCols <- cbind(c(1999,2002,2005,2008), totalEmissions)

#Call Plot function
plot(wYearCols, type="l", xlab="Year", ylab="Total Emissions", main="Total PM2.5 from All Sources in Baltimore City")

#Close file device
dev.off()

#Despite an spike in the middle PM2.5 did decline over the period.