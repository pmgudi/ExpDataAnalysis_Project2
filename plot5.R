# Exploratory Data Analysis - Assignment 2 - Q. #5
# Prabhakar M Oct 25, 2015

# Load ggplot2 library
require(ggplot2)

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("~/DS/EDA/summarySCC_PM25.rds")
SCC <- readRDS("~/DS/EDA/Source_Classification_Code.rds")

# Get data for Year 1999, 2002, 2005, 2008
NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Baltimore City, Maryland == fips
MD.onroad <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Aggregate
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

# Generate the graph in the same directory as the source code
png('~/DS/EDA/plot5.png')

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year)) + guides(fill=F) + 
    ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
    ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
    geom_bar(aes(label=round(Emissions,0), stat="identity", size=1, hjust=0.5, vjust=2))

dev.off()
