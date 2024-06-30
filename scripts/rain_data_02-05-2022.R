
d <- setwd("~/Dropbox/Fabiola/proyecto_lemur/")

# Get climate data 
library(readxl)

clim_dat_2020 <- read_excel("/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/data/datos_metereologicos/Estacion_met/Dat_met_estacion_2022-01-11.xlsx",sheet = "2020")

clim_dat_2019 <- read_excel("/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/data/datos_metereologicos/Estacion_met/Dat_met_estacion_2022-01-11.xlsx",sheet = "2019")

clim_dat <- rbind(clim_dat_2019, clim_dat_2020)

clim_dat <- clim_dat[, c("filename", "Año", "Mes", "Día", "Hora", "Min1", "Temp (°C)", "Humedad Relat.", "Precipitación")]

names(clim_dat) <- c("filename", "year", "month", "day", "hour", "min", "temp", "HR", "rain")

head(clim_dat)

# Create a column for SITE in climate data
site <- "SUKIA" 
clim_dat$site <- site

# Create a column named "date" in climate data 
clim_dat$year <- clim_dat$year + 2000

clim_dat$date <- paste(clim_dat$year, clim_dat$month, clim_dat$day, sep = "")

# Add a 0 to the days and months that only have one digit 
install.packages("stringi")
library(stringi)

# First the months 
clim_dat$month <- as.factor(clim_dat$month)

clim_dat$month <- stri_replace_all_regex(clim_dat$month, pattern = c('1', '2', '3', '4', '5', '6', '7', '8', '9'), replacement = c('01', '02', '03', '04', '05', '06', '07', '08', '09'), vectorize = F)

clim_dat$month <- stri_replace_all_regex(clim_dat$month, pattern = c('0102', '0101', '010'), replacement = c('12', '11', '10'), vectorize = F)

# Second days 
clim_dat$day <- as.factor(clim_dat$day)
#clim_dat$day = ifelse(grepl('^[1-9]/', clim_dat$day), paste0("0", clim_dat$day), clim_dat$day)

# Third modify the hour 
clim_dat$hour <- paste0(clim_dat$hour, "0000", sep = "")
head(clim_dat$hour)

# Create new date column with proper format
clim_dat$date2 <- as.Date(with(clim_dat, paste(year, month, day, sep = "")), "%Y%m%d")

# Create a column of site_date_hour 
clim_dat$site_date_hour2 <- paste(clim_dat$site, clim_dat$date2, sep = "_")
clim_dat$site_date_hour2 <- paste(clim_dat$site_date_hour2, clim_dat$hour, sep = "_")
head(clim_dat$site_date_hour2)

# Get acoustic data 
install.packages("readr")
library(readr)

aco_dat <- read_csv("~/Dropbox/Fabiola/proyecto_lemur/data/processed/acoustic_and_climatic_data.csv")
head(aco_dat)
names(aco_dat)

# Change date format in site_date_hour2 variable to match with site_date_hour in climate data

# Date
aco_dat$date2 <- as.Date(with(aco_dat, paste(year, month, day, sep = "-")), "%Y-%m-%d")

# Hour
aco_dat$hour2 <- paste(aco_dat$hour, "0000", sep = "")

# Site_Date_hour2
aco_dat$site_date_hour2 <- paste(aco_dat$site, aco_dat$date2, aco_dat$hour2, sep = "_")

# Change the number of decimals of rain variable in acoustic data
aco_dat$rain <- round(aco_dat$rain, digits = 2) 

# Sanity check of the format of the equivalent variables between climatic and acoustic data 
# Column site_date_hour2 
head(clim_dat$site_date_hour2)
head(aco_dat$site_date_hour2)

# Column date2
head(clim_dat$date2)
head(aco_dat$date2)

# Column hour
head(clim_dat$hour)
head(aco_dat$hour2)

# Column rain 
is.numeric(aco_dat$rain)
is.numeric(clim_dat$rain)

head(clim_dat$rain)
head(aco_dat$rain)

# Save number of rows of acoustic data
n <- nrow(aco_dat)

# un loop para cada fila
for (i in 1:n){
  # aquí averiguas el número de fila que corresponde en la base completa
  row_no <- which(clim_dat$site_date_hour2 == aco_dat$site_date_hour2[i] )
  
  # aquí sacás la sumatoria de las 24 horas previas
  aco_dat$rain_24[i] <- sum(clim_dat$rain[(row_no- 60*24) : row_no ])
  
  # las 48 horas previas
  aco_dat$rain_48[i] <- sum(clim_dat$rain[(row_no-60*48) : row_no ])
  
  # o alternativamente solo te interesa cuánto llovió en la mañana y asumamos que la mañana es de 6 am a 12 md
  m_start <- which(clim_dat$date2 == aco_dat$date2 & clim_dat$hour == 6)
  m_end <- which(clim_dat$date == aco_dat$date2 & clim_dat$hour == 12)
  aco_dat$rain_morning[i] <- sum(clim_dat$rain[m_start : m_end ])
}


