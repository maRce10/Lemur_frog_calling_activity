#### Prueba fabi #### 

library(Rraven)
library(warbleR)

sl_tbs <- list.files("/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/selection_tables/all_selec_tables_lemur/")

sl_tbs <- sl_tbs[sl_tbs != "LAGCHIMU_20200919_201500.Table.2.selections.txt"]

sls <- imp_raven(path = "/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/selection_tables/all_selec_tables_lemur/", warbler.format = TRUE, all.data = TRUE, files = sl_tbs)

wav_path <- "/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/files/converted_sound_files/"

sls$selec <- 1:nrow(sls)

cs <- check_sels(X = sls, path = wav_path)

sls <- sls[cs$check.res == "OK", ]

sls <- overlapping_sels(sls, indx.row = TRUE)

sls <- sls[!duplicated(sls$indx.row, incomparables = NA), ]

exp_raven(sls, path = "/Users/fabiolachirino/Dropbox/Fabiola/proyecto_lemur/selection_tables/", sound.file.path = wav_path, file.name = "temporary_doublechecking_all_selections")

library(viridis)

catalog(X = sls, flim = c(1, 3.5), nrow = 12, ncol = 15, ovlp = 70,
        height = 15, width = 23, same.time.scale = TRUE, mar = 0.005, wl = 512, gr = FALSE, 
        spec.mar = 0.4, lab.mar = 0.8, rm.axes = TRUE, by.row = TRUE, 
        box = TRUE, path = wav_path, labels = "selec", fast.spec = TRUE, pal = viridis)

catalog(X = sls[1:180, ], flim = c(1, 3.5), nrow = 12, ncol = 15, ovlp = 95,
        height = 15, width = 23, same.time.scale = TRUE, mar = 0.001, wl = 512, gr = TRUE, 
        spec.mar = 0.3, lab.mar = 0.8, rm.axes = FALSE, by.row = TRUE, img.prefix = "gridded",
        box = TRUE, path = wav_path, labels = "selec", fast.spec = TRUE, pal = viridis)

move_imgs(from = wav_path, to = ".", overwrite = TRUE)

sp <- spectro_analysis(sls, bp = c(2.25, 3.75), fast = TRUE, ovlp = 70, path = wav_path)

sapply(sp[, sapply(sp, is.numeric)], mean)


sp2 <- spectro_analysis(sls, bp = "frange", fast = TRUE, ovlp = 70, path = wav_path)

sapply(sp2[, sapply(sp2, is.numeric)], mean, na.rm = TRUE)

qntls <- summary(sp$meanpeakf)

qnt1_indx <- which.min(sp$meanpeakf - qntls[2])
mn_indx <- which.min(sp$meanpeakf - qntls[4])
qnt3_indx <- which.min(sp$meanpeakf - qntls[5])


comp.mat <- cbind(unique(sls$sound.files), paste(sls$sound.files[qnt1_indx], sls$selec[qnt3_indx], sep = "-"))


cc <- cross_correlation(X = sls, compare.matrix = comp.mat, path = wav_path, parallel = 3, output = "list")

saveRDS(cc, "cross_correlation_vectors_manually_selected_5min_segments.RDS")



