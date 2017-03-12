## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

BaltimoreCityEmissions <- NEI[NEI$fips=="24510",]

# Again going with seeing the word Vehicle in at least one of these fields.
SCC <- subset(SCC, select = c(SCC, Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))
SCC$auto_fields <- paste(SCC$Short.Name, SCC$EI.Sector, SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, SCC$SCC.Level.Four)
autos <- SCC[grep("Vehicle", SCC$auto_fields), ]

baltimoreAutoEmissions <- merge(BaltimoreCityEmissions, autos, by = "SCC")

#Sum Coal Emissions By Year
baltimoreAutoEmissions <- tapply(baltimoreAutoEmissions$Emissions, as.factor(baltimoreAutoEmissions$year), sum)

#Add a year variable for display on the X-axis
wYearCols <- cbind(c(1999,2002,2005,2008), baltimoreAutoEmissions)

png(file="plot5.png")
plot(wYearCols, type="l", xlab="Year", ylab="Total Motor Vehicle Emissions", main="Total PM2.5 from Motor Vehicle Sources in Baltimore City")
dev.off()

# Emissions from motor vehicle related sources has dropped significantly.

