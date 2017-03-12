## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Not super sure what fields determine "Coal-ness" status but I see the word coal in each of these so 
# that's my guess.
SCC <- subset(SCC, select = c(SCC, Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))
SCC$coal_fields <- paste(SCC$Short.Name, SCC$EI.Sector, SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, SCC$SCC.Level.Four)
coal <- SCC[grep("Coal", SCC$coal_fields), ]

coalEmissions <- merge(NEI, coal, by = "SCC")

#Sum Coal Emissions By Year
coalEmissions <- tapply(coalEmissions$Emissions, as.factor(coalEmissions$year), sum)

#Add a year variable for display on the X-axis
wYearCols <- cbind(c(1999,2002,2005,2008), coalEmissions)

png(file="plot4.png")
plot(wYearCols, type="l", xlab="Year", ylab="Total Coal Emissions", main="Total PM2.5 from Coal Combustion Related Sources")
dev.off()

# Emissions from coal combustion related sources rose slightly then dropped significantly.

