#Plot 2: Aggregate Emissions (Baltimore City, Maryland)

rm(PMdat25, SCC)
PM25dat <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

fips24510 <- PM25dat[which(PM25dat$fips == "24510"), ]
fips24510agg <- with(fips24510, aggregate(Emissions, by = list(year), sum))
colnames(fips24510agg) <- c("year", "Emissions")

png("plot2.png", width=480, height=480)
plot(fips24510agg, type = "o", col="purple", lwd=3, ylab = expression("Total Emissions, PM"[2.5]), xlab = "Year", main = "Total Emissions for Baltimore County", xlim = c(1999, 2008), ylim=c(1000,3500))

fit2 <- lm(Emissions~year, data=fips24510agg)
abline(fit2, lty="dashed", col="red")

dev.off()



