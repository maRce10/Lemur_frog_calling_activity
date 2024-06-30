
gg <- setwd(~/"Dropbox/Fabiola/proyecto_lemur/data/processed/")



call_dat <- read.csv("acoustic_and_climatic_data_by_hour.csv", sep = ",", dec = ".", header = T)


dir <- ~"/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/data/processed/"

dir <- as.character(dir)
class(dir)
setwd(dir)

call_dat$rain_24 <- sapply(1:nrow(call_dat), function(x) sum(call_dat$rain[strptime(call_dat$date, format="%Y-%m-%d") == (strptime(call_dat$date[x], format="%Y-%m-%d") - 60 * 60 * 24)]))

call_dat$rain_48 <- sapply(1:nrow(call_dat), function(x) sum(call_dat$rain[strptime(call_dat$date, format="%Y-%m-%d") == (strptime(call_dat$date[x], format="%Y-%m-%d") - 60 * 60 * 48)]))

head(call_dat)


######################## Metricas generales ############################ 

summary(data$prev_temp) 

# Call rate: mean = 23, max = 610, min = 0 

# Temp: min = 19.5, mean = 24.2, max = 31.8 
# HR: min = 55.2, mean = 90.1, max = 99.9 
# rain: min = 0.00, mean = 0.08, max = 10.42 
# rain_24: min = 0.00, mean = 0.87, max = 19.03 
# rain_48: min = 0.00, mean = 0.86, max = 19.03 

# sd temp 

sd.temp <- sd(data$temp)
sd.hr <- sd(data$HR)
sd.rain <- sd(data$rain)
sd.rain24 <- sd(data$rain_24)
sd.rain48 <- sd(data$rain_48)
sd.moon <- sd(data$moonlight)

# Comportamiento de la temperatura por mes y año?

library(ggplot2)

# Temperatura promedio por mes y año
temp.mean.month <- aggregate(temp ~ month + year, data = data, FUN = mean)

data$plot.date <- as.POSIXlt(strptime(as.character(data$plot.date), "%m/%d/%Y"))
data$plot.date  <- as.POSIXct(data$plot.date, origin="1960/01/01", tz = "UTC")

temp.mean.month <- aggregate(temp ~ hour + month + year, data = data, FUN = mean)

ggplot(temp.mean.month, aes(hour, temp)) + geom_point(colour = "blue") +
  geom_smooth(colour = "red",size = 1) +
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5)) +
  ggtitle ("Daily average temperature") +
  xlab("Date") +  ylab ("Average Temperature ( ºC )") 



sum(data$n_call)











remove.packages("ggplot2")
install.packages("ggplot2")
library(ggplot2)

ggplot(data,aes(x = date_hour, y = temp)) +
  geom_point(colour = "blue") +
  geom_smooth(colour = "red",size = 1) +
  scale_y_continuous(limits = c(5,30), breaks = seq(5,30,5)) +
  ggtitle ("Daily average temperature") +
  xlab("Date") +  ylab ("Average Temperature ( ºC )") 

ggplot(data, aes(x = date_hour, y = temp)) + geom_line()







































########################## rain ##########################################

install.packages("plotly")

library(ggplot2)
library(plotly)

boxplot(data$rain)

#plot the data
precPlot_hourly <- ggplot(data=data,  # the data frame
                          aes(date_hour, rain)) +   # the variables of interest
  geom_bar(stat="identity") +   # create a bar graph
  xlab("Date") + ylab("Precipitation (Inches)") +  # label the x & y axes
  ggtitle("Hourly Precipitation - Veragua Rainforest Sukia Site")  # add a title

precPlot_hourly 

# Let's try to do it plotting the precipitation per month and year 
monthly_rain <- aggregate(data2$rain ~ data2$year + data2$month, sum, data = data2) 


rain.monthly <- ggplot(data = monthly_rain,  # the data frame
                          aes(x = data2$month, y = data2$rain)) +   # the variables of interest
  geom_bar(stat="identity") +   # create a bar graph
  xlab("Date") + ylab("Precipitation (Inches)") +  # label the x & y axes
  ggtitle("Hourly Precipitation - Veragua Rainforest Sukia Site")  # add a title

rain.monthly 


ggdag_adjustment_set(dag.l, text = FALSE, exposure = c("Temperature", "HR", "night_rain", "previous_rain", "meanT",
                                                       "Moon"), outcome = "Activity", use_labels = "label", shadow = TRUE) + theme_dag() 

adjust_for(dag.l, var = "Hour") 


summary(data)


install.packages("brms")
