
### Direc recs annotations ###

# Load packages
library(warbleR)
library(Rraven)

# Set root directory
setwd("~/Dropbox/Fabiola/proyecto_lemur/data/Grab_direccionales/")

# List of wav files 
wavs <- list.files(path = "./data/Grab_direccionales/all_direc_recs/", pattern = "\\.wav$", ignore.case = T, recursive = T, full.names = T)

# Import annotations 
sls <- imp_raven(path = "./data/Grab_direccionales/annotations_direc_recs_30-04-22", warbler.format = T, all.data = T)
head(sls)

# Check duration 
sls$duration <- sls$end - sls$start
length(unique(sls$sound.files)) == length(unique(sls$selec.file))

# Check sels 
check_sel <- check_sels(X = sls, pb = F, path = "./data/Grab_direccionales/all_direc_recs/", fix.selec = TRUE) 
sls <- sls[check_sel$check.res == "OK", ]


# Make extended selection table
st <- selection_table(X = sls, path = "./data/Grab_direccionales/all_direc_recs/")

est <- selection_table(X = sls,  path = "./data/Grab_direccionales/all_direc_recs/", extended = TRUE)

saveRDS(est, "./data/processed/extended_selection_table_focal_recordings_lemur.RDS")

class(st)
print(st[1, ])

# Read selections 
l.1 <- read_wave(X = st, index = 1, from = 1.2, to = 2, path = "./all_direc_recs/")
l.1

# Create spectro 
spectro(l.1, wl = 150, grid = FALSE, scale = TRUE, ovlp = 70,
        flim = c(1, 4), tlim = c(0.3, 0.48), palette = cm.colors)

# Catalogs 

catalog(st, flim = c(1, 4), ovlp = 90, ncol = 10,  same.time.scale = T,
        nrow = 6, height = 15, width = 23, mar = 0.005, wl = 512, 
        gr = F, spec.mar = 0.4,  lab.mar = 0.8, rm.axes = TRUE, by.row = TRUE, box = TRUE,  fast.spec = TRUE, pal = cm.colors, parallel = 10, path = "./all_direc_recs/")


# Measure acoustic parameters 

## SNR 
snr <- sig2noise(st, mar = 0.05, path = "./all_direc_recs/")

# Spectro analysis 
spectral_parameters <- spectro_analysis(st, bp = "frange", fast = TRUE, ovlp = 70,pb = FALSE, path = "./all_direc_recs/")

# Plot 
names(spectral_parameters)

st$meanpeakf <- spectral_parameters$meanpeakf
st$duration <- spectral_parameters$duration

plot_parameters <- stack(st[, c("duration", "meanpeakf")])

library(ggplot2)
install.packages("viridis")
library(viridis)

ggplot(plot_parameters, aes(x = values)) + geom_histogram(fill = viridis(10, alpha = 0.9)[2]) +
  facet_wrap(~ind, scales = "free")

# Find the mean, range and sd of spectrographic parameters (meanpeakf, duration, bandwidth, callrate, intervalos entre llamados)

head(st)

# Statistics 
st$ID <- 1:nrow(st)

# Mean peakfreq 
mean.peakf <- mean(st$meanpeakf)

# Mean duration 
mean.dur <- mean(st$duration)

# Find the call rate 
install.packages("bioacoustics")
library(bioacoustics)

# Find the bandwith 

# Find call intervals 

