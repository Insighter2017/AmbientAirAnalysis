library(ggplot2)
library(plyr)

rm(PMdat25, SCC)
PM25dat <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset summarySCC_PM25 data for Baltimore
fips24510 <- PM25dat[which(PM25dat$fips == "24510"), ]

#aggregate the subset by year and sum, assign column names
Agg24510 <- with(fips24510, aggregate(Emissions, by = list(year), sum))
colnames(Agg24510) <- c("year", "Emissions")

#Use ddply to categorize and summarize Emissions by type and year
fips24510.type <- ddply(fips24510, .(type, year), summarize, Emissions = sum(Emissions))

#Create additional column that can be used as Legend Label
fips24510.type$Pollutant_Type <- fips24510.type$type

png("plot3.png", width=480, height=480)
qplot(year, Emissions, data = fips24510.type, group = Pollutant_Type, color = Pollutant_Type, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in Baltimore City by Type of Pollutant")

dev.off()