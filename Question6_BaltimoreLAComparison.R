#Plot6: Comaprison of vehicle emissions between Baltimore City and LA County

library(plyr)
library(ggplot2)

rm(PM25dat, SCC)

PM25dat <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

PM25dat$SCC <- as.character(PM25dat$SCC)
PM25dat.motor <- PM25dat[PM25dat$SCC %in% SCC.identifiers, ]

Subset24510 <- PM25dat.motor[which(PM25dat.motor$fips == "24510"), ]
Agg24510 <- with(Subset24510, aggregate(Emissions, by = list(year), 
    sum))

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)


PM25dat$SCC <- as.character(PM25dat$SCC)
PM25dat.motor <- PM25dat[PM25dat$SCC %in% SCC.identifiers, ]

Subset24510 <- PM25dat.motor[which(PM25dat.motor$fips == "24510"), ]
Subset06037 <- PM25dat.motor[which(PM25dat.motor$fips == "06037"), ]

Agg24510 <- with(Subset24510, aggregate(Emissions, by = list(year), 
    sum))
Agg24510$group <- rep("Baltimore City", length(Agg24510[, 
    1]))


Agg06037 <- with(Subset06037, aggregate(Emissions, by = list(year), 
    sum))
Agg06037$group <- rep("Los Angeles County", length(Agg06037[, 
    1]))

AggZips <- rbind(Agg06037, Agg24510)
AggZips$group <- as.factor(AggZips$group)

colnames(AggZips) <- c("Year", "Emissions", "Group")

png("plot6.png", width=480, height=480)
qplot(Year, Emissions, data = AggZips, group = Group, color = Group, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Vehicle Emissions Comparison")

dev.off()