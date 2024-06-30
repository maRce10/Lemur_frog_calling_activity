
install.packages("knitr")
library(knitr)
library(Rraven)

spec_par <- readRDS("~/Dropbox/Fabiola/proyecto_lemur/data/processed/acoustic_parameters_and_selections.RDS") 



sl_tbs <- list.files("~/Dropbox/Fabiola/proyecto_lemur/data/processed/selection_tables/all_selec_tables_lemur/")

sl_tbs <- sl_tbs[sl_tbs != "LAGCHIMU_20200919_201500.Table.2.selections.txt"]

sls <- imp_raven(path = "~/Dropbox/Fabiola/proyecto_lemur/data/processed/selection_tables/all_selec_tables_lemur/",
                 warbler.format = TRUE, all.data = TRUE, files = sl_tbs)

length(spec_par)

str(spec_par)




mean_sd <- function(x) data.frame(mean = round(mean(x, na.rm = TRUE), 2), sd = round(sd(x, na.rm = TRUE), 2), min = round(min(x, na.rm = TRUE), 2), max = round(max(x, na.rm = TRUE), 2))


freq_variation <- lapply(spec_par[,c("duration", "meanfreq", "freq.median","freq.Q25", "freq.Q75", "freq.IQR", "time.median", "time.Q25", "time.Q75" , "time.IQR","skew", "kurt", "sp.ent" ,"time.ent", "entropy", "sfm",  "meandom" ,"mindom", "maxdom", "dfrange",  "modindx", "startdom","enddom" ,"dfslope","meanpeakf")], mean_sd)

freq_variation <- do.call(rbind, freq_variation)

freq_variation$features <- rownames(freq_variation)

freq_variation <- freq_variation[, c(5, 1:4)]

rownames(freq_variation) <- 1:nrow(freq_variation)

saveRDS(freq_variation, "~/Dropbox/Fabiola/proyecto_lemur/data/processed/mean_spectral_parameters.RDS") 

write.csv(freq_variation, file.path("~/Dropbox/Fabiola/proyecto_lemur/data/processed/mean_spectral_parameters.csv"), row.names = F) 



