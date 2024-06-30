
# path with waves
wav_path <- "/Volumes/CHIRINO/Grabaciones SM4 2019/"

# list of wave files
wavs <- list.files(path = wav_path, pattern = "\\.wav$", ignore.case = TRUE, recursive = TRUE, full.names = TRUE)

# data frame with waves and metadata
wav_df <- data.frame(path = dirname(wavs), file =  basename(wavs))
wav_df$site <- ifelse(grepl("sukia", wav_df$path, ignore.case = TRUE), "Sukia", "Chimu") 
sm_metadata <- seewave::songmeter(wav_df$file)

wav_df <- cbind(wav_df, sm_metadata)

head(wav_df)

str(wav_df)

par(mfrow = c(2, 1))
hist(wav_df$time[wav_df$site == "Sukia"], breaks = 100, col = adjustcolor("green", alpha.f = 0.4), main = "Sukia")
hist(wav_df$time[wav_df$site == "Chimu"], breaks = 100, col = adjustcolor("blue", alpha.f = 0.4), main = "Chimu")

wav_df <- wav_df[order(wav_df$time), ]

wav_df$day_count <- as.vector(round((wav_df$time - min(wav_df$time)) /(3600 * 24), 0) + 1)

wav_df$week <- cut(x = wav_df$day_count, breaks = seq(1, max(wav_df$day_count) + 7, by = 7), include.lowest = TRUE)

wav_df <- droplevels(wav_df)

wav_df$period <- 4
wav_df$period[wav_df$hour %in% 17:19] <- 1
wav_df$period[wav_df$hour %in% 20:22] <- 2
wav_df$period[wav_df$hour %in% c(23, 0, 1)] <- 3

# create name combination
wav_df$site.week.period <- paste(wav_df$site, wav_df$week, wav_df$period, sep = "-")

# remove LAguna chimu
wav_df <- wav_df[grep("LAguna Chimu", wav_df$path, invert = TRUE), ]

set.seed(1)
sample_wav_l <- lapply(unique(wav_df$site.week.period), function(x){
  
  X <- wav_df[wav_df$site.week.period == x, ]
  
  if(nrow(X) > 2)
    X <- X[sample(1:nrow(X), size = 2), ]
  
  return(X)
    
}) 

sample_wav_df <- do.call(rbind, sample_wav_l)

write.csv(sample_wav_df, file.path("/Volumes/CHIRINO/Proyecto Lemur/INV_2021/5_min_cut_lemur/", "5_min_cut_metadata.csv"), row.names = FALSE)

sample_wav_df$cut.name <- gsub(".wav",  "_5min_cut.wav", sample_wav_df$file)

library(pbapply)

out <- pblapply(1:nrow(sample_wav_df), function(x) {

  # read first 5 mins
  wv <- try(readWave(file.path(sample_wav_df$path[x], sample_wav_df$file[x]), from = 0, to = 300, units = "seconds"), silent = TRUE)
  
  if (class(wv) == "Wave")
  # save cut
  writeWave(wv, filename = file.path("/Volumes/CHIRINO/Proyecto Lemur/INV_2021/5_min_cut_lemur/", sample_wav_df$cut.name[x])) 

  if (class(wv) == "Wave")
  return(NULL) else return(x)
})
