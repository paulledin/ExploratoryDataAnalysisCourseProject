## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Might not have these two by default
library(tidyr)
library(ggplot2)

#Subset for Baltimore
BaltimoreCityEmissions <- NEI[NEI$fips=="24510",]

#Sum Emissions By Year and Type
totalEmissions <- as.data.frame(tapply(BaltimoreCityEmissions$Emissions, list(BaltimoreCityEmissions$year,BaltimoreCityEmissions$type), sum))
totalEmissions$Year <- c(1999,2002,2005,2008)

#Rename poorly named variables
names(totalEmissions)[1] <- "NONROAD"
names(totalEmissions)[3] <- "ONROAD"

#Build tidy data set
tidyDataSet <- gather(totalEmissions, type, PM25, NONROAD:POINT, -Year)

#Call Plot function
png(file = "plot3.png",width = 800, height = 600)
p <- ggplot(tidyDataSet, aes(x = Year, y = PM25))
p <- p + geom_point()
p <- p + geom_smooth(method = "lm", se=FALSE, color="black", formula = y ~ x)
p <- p + facet_grid(. ~ type)
p <- p + ggtitle("Total PM2.5 By Source Type For Baltimore")
print(p)
dev.off()

#Emissions fell for 3 of the 4 sources, with the exception being POINT Emissions.