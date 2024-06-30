# directory with recordings
#rec_fp <- ("~/Dropbox/Estudiantes/Fabiola_Chirino/grabaciones_prueba/")

rec_fp <- ("~/Dropbox/Fabiola/proyecto_lemur/data/prueba_beti/")

# read names of all files
rec <- list.files(path = rec_fp, pattern = "SUKIA")

# how many recordings
n <- length(rec)

# create a data frame
rec_info <- data.frame(date = numeric(n), year = numeric(n), month = numeric(n), day = numeric(n), start_hour = numeric(n), start_minute = numeric(n), duration = numeric(n), end_hour = numeric(n), end_minute = numeric(n))

# populate from file name (assuming all file names have the same pattern, but could be from different sites)

library(dplyr)

rec_info$date <-
  sub(pattern = "[A-Z]+_",
      replacement = "",
      x = rec) %>%
  sub(pattern = "_.*", replacement = "")

rec_info$year <-
  sub(pattern = "[A-Z]+_",
      replacement = "",
      x = rec) %>%
  sub(pattern = "[0-9]{4}_.*", replacement = "")

rec_info$month <-
  sub(pattern = "[A-Z]+_[0-9]{4}",
      replacement = "",
      x = rec) %>%
  sub(pattern = "[0-9]{2}_.*", replacement = "")

rec_info$day <-
  sub(pattern = "[A-Z]+_[0-9]{6}",
      replacement = "",
      x = rec) %>%
  sub(pattern = "_.*", replacement = "")

rec_info$start_hour <-as.numeric(
  sub(
    pattern = "[A-Z]+_[0-9]{8}_",
    replacement = "",
    x = rec
  ) %>%
    sub(pattern = "[0-9]{4}_.*", replacement = "")
)

rec_info$start_minute <- as.numeric(
  sub(
    pattern = "[A-Z]+_[0-9]{8}_[0-9]{2}",
    replacement = "",
    x = rec
  ) %>%
    sub(pattern = "[0-9]{2}_.*", replacement = "")
)

# let's say all recordings from 2020-02-01 to 2021-03-31 are 20 min long and all recordings after 2021-03-31 are 5 min long. You can change this to match your data.

# make all values = 20 mim
rec_info$duration <- 20

# change the values after 2021-03-31 to 5 min
rec_info$duration[which(rec_info$date > 20210331)] <- 5

rec_info$end_minute <- rec_info$start_minute + rec_info$duration

# sanity check, end minute should always be < 60
rec_info$end_minute[rec_info$end_minute > 59]

# if numeric(0) then this works
rec_info$end_hour <- rec_info$start_hour

# check the data
head(rec_info)

# Get climate data 
library(readxl)

dat.met <- read_excel("/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/data/datos_metereologicos/Estacion_met/Dat_met_estacion_2022-01-11.xlsx",sheet = "prueba")

str(dat.met)
head(dat.met) #quitar columna min 2 

# First, rename variables 

colnames(dat.met)[which(names(dat.met) == "Temp (°C)")] <- "temp"
colnames(dat.met)[which(names(dat.met) == "Humedad Relat.")] <- "RH"
colnames(dat.met)[which(names(dat.met) == "Precipitación")] <- "rain"

names(dat.met)

boxplot(data$temp ~ data$month, cex.lab = 1.4)

# Set numeric variables
dat.met$temp <- as.numeric(dat.met$temp)
dat.met$HR <- as.numeric(dat.met$HR)
dat.met$rain <- as.numeric(dat.met$rain)
dat.met$Año <- dat.met$Año + 2000

# Create new data frame for mean temp, RH and rain

x <- seq(from = 0, to = 60, by = 5)
n <- nrow(dat.met)
n.mean <- n/5-1 # omit first row (5-1) 

dat.met.5 <- data.frame(year = numeric(length(n.mean)), month = numeric(length = (n.mean)),
                        day = numeric(length = (n.mean)), hour = numeric(length = (n.mean)),
                        minn = numeric(length = (n.mean)), temp = numeric(length = (n.mean)), 
            RH = numeric(length = (n.mean)), rain = numeric(length = (n.mean)))

# Make a loop to calculate the mean values for met data 
k = 1

for(i in 2:n){ 
  if(dat.met$Min1[i] %in% x) {
   dat.met.5$temp[k] <- mean(dat.met$temp[(i - 4):i])
   dat.met.5$RH[k] <- mean(dat.met$HR[(i - 4):i])
   dat.met.5$rain[k] <- sum(dat.met$rain[(i - 4):i])
   dat.met.5$year[k] <- dat.met$Año[i]
   dat.met.5$month[k] <- dat.met$Mes[i]
   dat.met.5$day[k] <- dat.met$Día[i]
   dat.met.5$hour[k] <- dat.met$Hora[i]
   dat.met.5$minn[k] <- dat.met$Min1[i]
   
   k = k + 1 
   
  }

}

# Set date format 
dat.met.5$date <- as.Date(paste(dat.met.5$year, dat.met.5$month, dat.met.5$day, sep = "-"))
rec_info$date <- as.Date(paste(rec_info$year, rec_info$month, rec_info$day, sep = "-"))


# Merge acoustic data with met data 
head(dat.met.5)
head(rec_info)

# Forma 1
x <- merge(x = rec_info, y = dat.met.5, by = "date", all.x = T)
dim(x)


dd <- 1:6

n <- 40000
mt <- sample(dd, n, replace = TRUE)

sum(mt == 6) / n


iris


md <- lm(Petal.Length ~ Species, iris)
table(iris$Species)

summary(md)

# Forma 2 
library(dplyr)
x1 <- left_join(rec_info, dat.met.5, by = as.numeric("month"))

#metadata <- data.frame(x$year, x$month.x, x$day.x, x$minn, x$date.x,
                          #x$temp, x$RH, x$rain, x$start_hour, x$start_minute, x$duration,
                          #x$end_hour, x$end_minute)
















