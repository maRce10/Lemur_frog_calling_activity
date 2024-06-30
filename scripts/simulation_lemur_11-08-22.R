# read climatic data
clm_dat <- read.csv(file = "~/Dropbox/estudiantes/Fabiola/proyecto_lemur/data/processed/acoustic_and_climatic_data_by_hour.csv")
# install.packages("oce")

library(oce)
library(corrplot)

dt <- as.POSIXct(paste(clm_dat$date[1], "00:00:00"), tz="UTC")

time <- paste0(paste0(ifelse(nchar(clm_dat$hour) == 1, "0", ""), clm_dat$hour), ":00:00")

# this must be fixed
clm_dat$sun <- oce::sunAngle(as.POSIXct(paste(clm_dat$date, time), tz="UTC"), lat = 9 + 55 / 60, lon = 83 + 11 / 60)$altitude * -1

# head(clm_dat)

base_dat <-  clm_dat[, c("hour_diff", "temp", "sun", "hour")]

base_dat$temp <- scale(base_dat$temp)
base_dat$sun <- scale(base_dat$sun)

cor(base_dat$sun, base_dat$temp, use = "pairwise.complete.obs")

# temperature 24 hours before
base_dat$prev_temp <- sapply(1:nrow(base_dat), function(x){
  
  if(base_dat$hour_diff[x] < 48) 
    pt <- NA else
      pt <- mean(base_dat$temp[(base_dat$hour_diff[x] - 48):(base_dat$hour_diff[x] - 24)])
    
    return(pt)
})


# set seed
# set.seed(123)

# global variables
b1 <- 1
b_sun <- -0.3
b_rel_hum <- 2
b_temp <- 0.5
b_moon <- -1
b_clouds <- -1.3
b_nite_rain <- -0.7
b_prev_rain <- 1.7

n <- nrow(base_dat)
variance <- 4
error <- function(n, variance) rnorm(mean = 0, n = n, sd = variance^2)

# random variables
# moon
base_dat$moon <- b1 * base_dat$sun + error(n, variance)

# clouds
base_dat$clouds <- b1 * base_dat$prev_temp + error(n, variance)

# night rain
base_dat$nite_rain <- b1 * base_dat$clouds + error(n, variance)

# rain 24 hours before
base_dat$prev_rain <-  b1 * base_dat$clouds + error(n, variance)

# re write temp 
base_dat$temp <- b1 * base_dat$sun + b1 * -1 * base_dat$nite_rain + error(n, variance)

# relative humidity 
base_dat$rel_hum <- b1 * base_dat$prev_rain + b1 * base_dat$nite_rain +  b1 * base_dat$temp + error(n, variance)


# call rate
intrcpt <- 14
base_dat$call_rate <- intrcpt  + b_sun * base_dat$sun + b_temp * base_dat$temp + b_moon * base_dat$moon + b_rel_hum * base_dat$rel_hum + b_nite_rain * base_dat$nite_rain + b_prev_rain * base_dat$prev_rain + error(n, variance)

# n calls
base_dat$n_call <- round((base_dat$call_rate + abs(min(base_dat$call_rate, na.rm = TRUE))), 0) 

corrplot.mixed(cor(base_dat, use = "pairwise.complete.obs"))

base_dat_filt <- base_dat[complete.cases(base_dat), ]

base_dat_filt$rec_time  <- 60

library(brms)
# 
# 
# 
# fit <- brm(n_call | resp_rate(rec_time) ~  temp + rel_hum + moon + nite_rain + prev_rain + ar(p = 2, time = hour_diff, gr = hour), data = base_dat_filt, chains = 1, family = negbinomial(), iter = 800)
# 
# fit

fit_nrm <- brm(call_rate ~  temp + rel_hum + moon + nite_rain + prev_rain + ar(p = 2, time = hour_diff, gr = hour), data = base_dat_filt, chains = 1, family = gaussian(), iter = 800)

fit_nrm
# 
# fit2
# fit_2 <- brm(n_call | resp_rate(rec_time) ~  temp + rel_hum + moon + nite_rain + prev_rain, data = base_dat_filt, chains = 1, family = negbinomial(), iter = 1000)
# fit_2


fit_nrm_notemp <- brm(call_rate ~  rel_hum + moon + nite_rain + prev_rain + ar(p = 2, time = hour_diff, gr = hour), data = base_dat_filt, chains = 1, family = gaussian(), iter = 800)

fit_nrm2

# RH effect
fit_nrm_rh <- brm(call_rate ~ temp + rel_hum + nite_rain + prev_rain + ar(p = 2, time = hour_diff, gr = hour), data = base_dat_filt, chains = 1, family = gaussian(), iter = 800)

fit_nrm_rh

fit_nrm_rh_no_time <- brm(call_rate ~ temp + rel_hum + nite_rain + prev_rain, data = base_dat_filt, chains = 1, family = gaussian(), iter = 800)

