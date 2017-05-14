#Plot 1: Aggregate Emissions Nationwide (United States)

rm(PM25dat, SCC)
PM25dat <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
PM25agg <- with(PM25dat, aggregate(Emissions, by = list(year), sum))
colnames(PM25agg) <- c("year", "Emissions")

##png("plot1.png", width=480, height=480)
plot(PM25agg, type = "o", col="blue", lwd=3, ylab = expression("Total Emissions, PM"[2.5]), 
	xlab = "Year", main = "Total Emissions in the United States")
fit1<-lm(Emissions~year, data=PM25agg)
abline(fit1, lty="dashed", col="purple")
##dev.off()
##rm(PM25dat, SCC, PM25agg)




