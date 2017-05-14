#Plot 5: Changes in motor vehicle admissions 
library(ggplot2)
library(plyr)

rm(PM25dat, SCC)
PM25dat <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

PM25dat$SCC <- as.character(PM25dat$SCC)
PM25dat.motor <- PM25dat[PM25dat$SCC %in% SCC.identifiers, ]

Subset24510 <- PM25dat.motor[which(PM25dat.motor$fips == "24510"), ]

Agg24510 <- with(Subset24510, aggregate(Emissions, by = list(year), sum))
colnames(Agg24510) <- c("year", "Emissions")

png("plot5.png", width=480, height=480)
plot(Agg24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Total Emissions from Motor Vehicle Sources (Baltimore City)")

