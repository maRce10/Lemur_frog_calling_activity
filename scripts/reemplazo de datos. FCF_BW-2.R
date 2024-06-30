###############
#Stratified Random Selection of recordings for manual annotation
#Adapted for SongMeter recordings
###############

## 1st STEP - Before starting ##

#Be sure,
#... you placed all your recordings within a folder (or a group of folders) where no other recordings are stored;
#... your recordings have all the same audio format (e.g. wav)
#... and their original names created by the SM (e.g. SITE1_20160101_223000);
#... your R or RStudio is updated

#Carefully read the "script" (line by line)
#and proceed following the directions indicated in each line


## 2nd STEP -  Let's get ready ##

#Clean R workspace memory
#RUN the code (as it is)
rm(list=ls())

#Load R packages
#RUN the code (as it is)
#install.packages("tcltk")
require(tcltk)
#install.packages("tibble")
require(tibble)

#Load function
#RUN the code (as it is)
resample <- function(x, ...) x[sample.int(length(x), ...)]

#Give a name to your data set (e.g. Nouragues.point1.2007)
#CHANGE the code & RUN 

###cambio fabi###
name="sukiadata"


#Selet the ROOT directory (general folder where all recordings are gathered in)
#RUN the code & CHOOSE
#setwd(tk_choose.dir()); root.dir=getwd() 

###cambio fabi 

setwd("/Volumes/CHIRINO/Grabaciones SM4 2019/Sukia");root.dir=getwd() 
#aca puedo delimitar aun mas, para ir escogiendo mes a mes al hacer la aleatorizacion



#Selet the SEL directory (where selected recordings will be stored)
#RUN the code & CHOOSE 
#setwd(tk_choose.dir()); sel.dir=getwd()

#setwd(tk_choose.dir()); sel.dir=getwd() 

setwd("/Users/fabiolachirino/Documents/datos aleatorios 3/");sel.dir=getwd() #cambio

#aca lo que hago es una carpeta destino para depositar mis archivos aleatorios


## 3rd STEP - General list of recordings ##

#Select the file audio format (e.g. ".wav", ".aiff", ".mp3")
#RUN the code & CHOOSE
#rec.format=switch(menu(c(".wav", ".aiff", ".mp3")) + 1,cat("Nothing done\n"), c(".wav"), c(".aiff"), c(".mp3")) 


#prueba fabi

rec.format=".wav" ####esta fue la via que funciono 


#Create a list with all your recordings (and related metadata)
#RUN the code (as it is)

#setwd(root.dir); rec.list=list.files(getwd(), pattern=rec.format, recursive=T)

datos<-paste0(dir(root.dir,full.names = T)) #betty tutoria 

#SEGUNDO INTENTO, en lugar de ser los nombres de subcarpetas es el nombre completo con todo el 
#directorio 

#datos<-paste0(root.dir,"/",dir(root.dir,full.names = TRUE))

datos <-dir(root.dir, full.names = TRUE)
setwd(root.dir); rec.list=list.files(datos, pattern=rec.format, recursive=T) 


#Total number of files and first files
#RUN the code (as it is)

length(rec.list)####fabi: tengo 2707 archivos 

head(rec.list)

#Extract file metadata and build a table with it
#RUN the code (as it is)
rec.table=file.info(rec.list)
rec.table=as.data.frame(file.info(rec.list))
rec.table=rownames_to_column(rec.table,"file.name")

#First rows in the table
#RUN the code (as it is)
head(rec.table)




#Save the table in the ROOT directory
#You can open this file in excel or another software
#RUN the code (as it is)

#write.table(rec.table, file=paste(name,"txt",sep="."), sep="\t", row.names=F)
getwd() 

#nuevo beti: aqui generamos nuestro archivo TXT en la carpeta de aleatorizacion

setwd(sel.dir) ; write.table(rec.table, file=paste(name,"txt",sep="."), sep="\t", row.names=F)

write.table(rec.table, file=paste(name,"txt",sep="."), sep="\t", row.names=F)

setwd(root.dir)

################################################################################################
###Beti##############################################################################
#porque yo no tengo rec.list

#BETI:
#rec.table <- read.table("~/Dropbox/Estudiantes/Fabiola_Chirino/sukiadata2.txt", header = T, sep = "\t")

#Los nombres de las grabaciones estan por todas partes. Homogenicemos

tail(rec.table)
rec.list <- as.character(rec.table$file.name)
rec.list <- gsub(".*SUKIA", "SUKIA", rec.list)

#MES#
# como todos los nombres tienen el mismo formato el mes es siempre lo que sigue a Data/SUKIA_YYYY
month = gsub(pattern = "SUKIA_20[0-9]{2}", x = rec.list, replacement = "\\1")
month = gsub(pattern = "[0-9]{2}_[0-9]{6}.wav", x = month, replacement = "\\1")
rec.table=cbind(rec.table, "month"=month)

#SEMANA#
# digamos que los dias 1 -7 son semana 1, 8-14 son semana 2, 15 -21 son semana 3 y 22-31 son semana 4
day = gsub(pattern = "SUKIA_20[0-9]{4}", x = rec.list, replacement = "\\1")
day = gsub(pattern = "_[0-9]{6}.wav", x = day, replacement = "\\1")
day = as.numeric(day)

week = vector(length = length(day))
  
#print(week)

for (i in 1:length(day)){
  if(day[i] < 8){week[i] <- 1}else{
    if(day[i] < 15){week[i] <- 2} else{
      if(day[i] < 22){week[i] <- 3} else{
        week[i] <- 4
      }
    } 
  }
}
rec.table=cbind(rec.table, "week"=week)


#HORAS#
# intervalos de 4 h seria de 17 -20, 21-00, 01-04, modifiquemos un poco
hours=gsub("^.*_","",rec.list)
hours=sub("[0-9]{4}\\..*", "", hours)
hours=as.numeric(hours)
range(hours)
hist(hours, breaks=24)
rec.table=cbind(rec.table, "hour"=hours)

#FECHAS#
# puede ser que tener la fecha completa sea util en el futuro
date = gsub(pattern = "SUKIA_", x = rec.list, replacement = "\\1")
date = gsub(pattern = "_[0-9]{6}.wav", x = date, replacement = "\\1")
date = as.numeric(date)
rec.table=cbind(rec.table, "date"=date)

# si queres quitar los que son NA
rec.table = rec.table[,c('file.name','date','month', 'week','hour')]

#sanity check
head(rec.table, 20)
tail(rec.table, 20) 

####Para hacer reemplazo de datos####

# esta línea es solo si el muestreo aleatorio es para un subconjunto de  los datos, sino comentar
#rec.table<-rec.table[which(rec.table$hour > 1 & rec.table$hour < 17 ),]

## 5th STEP - Set the groups of recordings (temporal levels or strata) within randomly selecting files ##

#Option (a)
#Set the strata manually 

#Remember first to take a look at your recording period
#RUN the code (as it is)
range(date)

#Define strata for dates (e.g., every 3 months) by setting the first day of each stratum
#CHANGE the code & RUN
d.strata=c(20190801,20190901,20191001,20191101,20191201,20200101,20200201, 20200301, 20200401, 20200501) 



#aqui seleccione mes a mes
len.d.strata=length(d.strata)

#BETI estrato por semana
w.strata=sort(unique(week))
#aqui seleccione semana a semana
len.w.strata=length(w.strata)


#Define strata for hours (e.g., every 3h) by setting the first hour of each stratum
#intervalos de 4 h seria de 17 -20, 21-00, 01-04, modifiquemos un poco
h.strata=c(17,21,01)
len.h.strata=length(h.strata)

#Define the number of recordings for each combination of strata
#CHANGE the code & RUN
#n.recs=13 

#Create vector with dates of data extraction


card <- c(20190826, 20191008, 20191025, 20191112, 20191126, 20191213, 20191218, 20200104,
          20200116, 20200202)

#prueba fabi: aqui entonces serian 2 horas aleatorias por cada estrato (estrato=periodo cada 3h, cada semana cada mes)
n.recs=2 


#Create a table to save the list of selected recordings
#RUN the code (as it is)
sel.table=matrix(data=0,nrow=0,ncol=7, dimnames=list(c(),c("stratum", "file.name","onset.date", "end.date", "week","onset.hour", "end.hour")))

####ACA DELIMITAMOS LOS DATOS DE MI ESTRATO FALTANTE 

rec.table<-rec.table[which(rec.table$hour<17 & rec.table$date<20200301),]

## 6th STEP - Run the automated sampling process ##

#This loop will perform the stratified random sampling of recordings
#A folder for each stratum will be automatically created in the "selection directory" and there you will find all selected recordings

#Select the whole code and run it all at once (from the onset to the end) 
#RUN the code (as it is) 


for(i in 1:len.d.strata){
  for (k in 1:len.w.strata){
    for(z in 1:len.h.strata){
      
      #This will define the group of files for each stratum
      if(i<len.d.strata){
        if(z==1){
          group=which(rec.table$date>=d.strata[i] &
                        rec.table$date<d.strata[i+1] &
                        rec.table$week==w.strata[k] &
                        rec.table$hour>=h.strata[z] &
                        rec.table$hour<h.strata[z+1])
        }
        else{
          if(z==2){
            group=which(rec.table$date>=d.strata[i] & 
                          rec.table$date<d.strata[i+1] &
                          rec.table$week==w.strata[k] &
                          rec.table$hour>=h.strata[z])
          }
          else{
            group=which(rec.table$date>=d.strata[i] &
                          rec.table$date<d.strata[i+1] &
                          rec.table$week==w.strata[k] &
                          rec.table$hour>=h.strata[z] &
                          rec.table$hour<17)
          }
        }
      }
      else{
        if(z==1){
          group=which(rec.table$date>=d.strata[i] &
                      rec.table$week==w.strata[k] &
                      rec.table$hour>=h.strata[z]&
                      rec.table$hour<h.strata[z+1])
        }
        else{
          if(z==2){
            group=which(rec.table$date>=d.strata[i] & 
                        rec.table$week==w.strata[k] &
                        rec.table$hour>=h.strata[z])
          }
          else{
            group=which(rec.table$date>=d.strata[i] &
                        rec.table$week==w.strata[k] &
                        rec.table$hour>=h.strata[z] &
                        rec.table$hour<17)
          }
        }
      }
      #This will randomly select recordings within each group or stratum
      if(length(group)>=n.recs){
        sel.rec=resample(group, n.recs, replace=F)
      }
      else{sel.rec=resample(group, length(group), replace=F)
      }
    
      #This will create a folder for each stratum and copy the files there
     if(length(sel.rec)>0){
      new.folder=paste(sel.dir,paste(i,k,z,sep="."), sep="/")
      dir.create(new.folder)
        
        #This will find the date of data extraction for each recording and copy files from there
      for (m in 1:length(sel.rec)){
        card.date <- max(card[which(rec.table$date[sel.rec[m]]>= card)])
          file.copy(paste(paste0(root.dir,"/SUKIA_", card.date),
                         rec.table$file.name[sel.rec[m]], sep="/"),
                   new.folder)   
        }
     }
      
      #Complete the data in the table of selected recordings
      if(i<len.d.strata){
        if(z<len.h.strata){
          t=matrix(c(rep(paste(i,k,z,sep="."),length(sel.rec)),
                     paste0(rec.table$file.name[sel.rec]),
                     rep(d.strata[i],length(sel.rec)),
                     rep(d.strata[i+1],length(sel.rec)),
                     rep(w.strata[k],length(sel.rec)),
                     rep(h.strata[z],length(sel.rec)),
                     rep(h.strata[z+1],length(sel.rec))),
                   nrow=length(sel.rec), ncol=7, byrow=F)
        }
        else{
          t=matrix(c(rep(paste(i,k,z,sep="."),length(sel.rec)),
                     paste0(rec.table$file.name[sel.rec]), 
                     rep(d.strata[i],length(sel.rec)),
                     rep(d.strata[i+1],length(sel.rec)),
                     rep(w.strata[k],length(sel.rec)),
                     rep(h.strata[z],length(sel.rec)),
                     rep("later",length(sel.rec))),
                   nrow=length(sel.rec), ncol=7, byrow=F)
        }
      }
      else{
        if(z<len.h.strata){
          t=matrix(c(rep(paste(i,k,z,sep="."),length(sel.rec)),
                     paste0(rec.table$file.name[sel.rec]),
                     rep(d.strata[i],length(sel.rec)),
                     rep("later",length(sel.rec)),
                     rep(w.strata[k],length(sel.rec)),
                     rep(h.strata[z],length(sel.rec)),
                     rep(h.strata[z+1],length(sel.rec))),
                   nrow=length(sel.rec), ncol=7, byrow=F)
        }
        else{
          t=matrix(c(rep(paste(i,k,z,sep="."),length(sel.rec)),
                     paste0(rec.table$file.name[sel.rec]),
                     rep(d.strata[i],length(sel.rec)),
                     rep("later",length(sel.rec)),
                     rep(w.strata[k],length(sel.rec)),
                     rep(h.strata[z],length(sel.rec)),
                     rep("later",length(sel.rec))),
                   nrow=length(sel.rec), ncol=7, byrow=F)
        }
      } 
      sel.table=rbind(sel.table,t)
    }
  }
}

sel.table

print(sel.table)

#Save the table of selected recordings in the SEL directory
#You can open this file in excel or another software
#RUN the code (as it is)
setwd(sel.dir);write.table(sel.table, file=paste(name,"selection","txt",sep="."), sep="\t", row.names=F, quote=F)

#The selection process is done
#You can proceed to check the new folders and the selected recordings

#######