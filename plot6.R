## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Might not have these two by default
library(tidyr)
library(ggplot2)

#Subset for Baltimore and Los Angeles
baltimoreCityEmissions <- NEI[NEI$fips=="24510", ]
losAngelesEmissions <- NEI[NEI$fips=="06037", ]

# Again going with seeing the word Vehicle in at least one of these fields.
SCC <- subset(SCC, select = c(SCC, Short.Name, EI.Sector, SCC.Level.One, SCC.Level.Two, SCC.Level.Three, SCC.Level.Four))
SCC$auto_fields <- paste(SCC$Short.Name, SCC$EI.Sector, SCC$SCC.Level.One, SCC$SCC.Level.Two, SCC$SCC.Level.Three, SCC$SCC.Level.Four)
autos <- SCC[grep("Vehicle", SCC$auto_fields), ]

baltimoreCityAutoEmissions <- merge(baltimoreCityEmissions, autos, by = "SCC")
losAngelesAutoEmissions <- merge(losAngelesEmissions, autos, by = "SCC")

#Sum Emissions By Year and City
totalBaltimoreCityEmissions <- as.data.frame(tapply(baltimoreCityAutoEmissions$Emissions, list(baltimoreCityAutoEmissions$year), sum))
totalBaltimoreCityEmissions$Year <- c(1999,2002,2005,2008)

totallosAngelesEmissions <- as.data.frame(tapply(losAngelesAutoEmissions$Emissions, list(losAngelesAutoEmissions$year), sum))
totallosAngelesEmissions$Year <- c(1999,2002,2005,2008)

#Rename poorly named variables
names(totalBaltimoreCityEmissions)[1] <- "PM25"
totalBaltimoreCityEmissions$city <- "Baltimore"

names(totallosAngelesEmissions)[1] <- "PM25"
totallosAngelesEmissions$city <- "Los Angeles"

bothCities <- rbind(totalBaltimoreCityEmissions, totallosAngelesEmissions)

#Call Plot function
png(file = "plot6.png",width = 800, height = 600)
p <- ggplot(bothCities, aes(x = Year, y = PM25))
p <- p + geom_point()
p <- p + geom_smooth(method = "lm", se=FALSE, color="black", formula = y ~ x)
p <- p + facet_grid(. ~ city)
p <- p + ggtitle("Total PM2.5 From Autos in Baltimore City and Los Angeles")
print(p)
dev.off()

#Los Angeles has remained overall much higher than Baltimore City.
#Los Angeles has trended upward while Balimore City has trended down.
#Los Angeles has seen much more volitility in the PM25 readings than Baltimore City has.