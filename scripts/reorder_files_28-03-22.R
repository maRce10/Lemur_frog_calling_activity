library(Rraven)

# copy files to a single folder
x <- imp_raven(files = "double_checking_detections.txt", path = "~/Dropbox/Fabiola/proyecto_lemur/data/processed/selection_tables/detection_double-check/")

wavs <- unique(x$`Begin File`)

all_wavs <- list.files(path = "/Volumes/CHIRINO/Grabaciones SM4 2019/Sukia/", recursive = TRUE, full.names = TRUE, pattern = ".wav$")

all_wavs_df <- data.frame(all_wavs, wav_name = basename(all_wavs))
all_wavs_df <- all_wavs_df[all_wavs_df$wav_name %in% wavs, ]

fc <- file.copy(from = all_wavs_df$all_wavs, to = file.path("/Volumes/CHIRINO/Grabaciones SM4 2019/doublechecking_sukia_files/", all_wavs_df$wav_name))

all(fc)

# fix path of raven selection table
setwd("~/Dropbox/Fabiola/proyecto_lemur/data/processed/selection_tables/detection_double-check/")

fix_path(new.begin.path = "/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/data/raw/sound_files/10_kHz_5_min_cuts/", sound.file.col = "Begin File")

fix_path(new.begin.path = "/Volumes/CHIRINO/Grabaciones SM4 2019/doublechecking_sukia_files", sound.file.col = "Begin File")
