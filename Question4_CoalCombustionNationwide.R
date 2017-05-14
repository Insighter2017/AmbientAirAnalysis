#Plot 4: How emissions from coal combustion-related sources changed from 1999-2008
library(lattice)
library(plyr)

rm(PM25dat, SCC)
PM25dat<- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

PM25dat$SCC <- as.character(PM25dat$SCC)
PM25dat.coal <- PM25dat[PM25dat$SCC %in% SCC.identifiers, ]

AggCoal <- with(PM25dat.coal, aggregate(Emissions, by = list(year), sum))
colnames(AggCoal) <- c("year", "Emissions")

png("plot4.png", width=480, height=480)
plot(AggCoal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
    xlim = c(1999, 2008))

dev.off()