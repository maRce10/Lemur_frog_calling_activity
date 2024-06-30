
library(monitoR)
setwd("~/Documents/Proyecto Lemur/reconocedor acustico/") 

###Template 1: Data/SUKIA_20190831_23000.wav (23:15 noche seca, parecen 2 individuos en la grabacion)  

# rec1<-readWave("templatefiles/grabaciones/SUKIA_20190831_230000.wav")
# rec1<-cutWave(rec1,from= 980, to=982)
# writeWave(rec1,"templatefiles/templates/rec_20190831_23:15pm.wav")

# setWavPlayer("play")
# play(rec1) 

temp.1<-makeCorTemplate(clip="templatefiles/templates/rec_20190831_23:15pm.wav", name="T1",t.lim=c(0.6 ,1.4),frq.lim = c(2,3.2))

###Template 2: Data/SUKIA_20190831_23000.wav (23:05 noche seca, parecen 2 cantos seguidos)  (utilicé la misma grabación por este canto)

# rec2<-readWave("templatefiles/grabaciones/SUKIA_20190831_230000.wav")
# rec2<-cutWave(rec2,from= 135, to=136)
# writeWave(rec2,"templatefiles/templates/rec_20190831_23:05pm.2.wav")

temp.2<-makeCorTemplate(clip="templatefiles/templates/rec_20190831_23:05pm.2.wav", name="T2",t.lim=c(0 ,0.6),frq.lim = c(2,3))

###Template 3: Data/SUKIA_20190906_21000.wav (21:05 2 cantos en 1 mismo segundo)

# rec3<-readWave("templatefiles/grabaciones/SUKIA_20190906_210000.wav")
# rec3<-cutWave(rec3,from=180, to=181)
# writeWave(rec3,"templatefiles/templates/rec_20190906_21:05pm.wav")
temp.3<-makeCorTemplate(clip="templatefiles/templates/rec_20190906_21:05pm.wav", name="T3",t.lim=c(0,0.35),frq.lim = c(2.2,3.1))
                      

###Template 4: Data/SUKIA_20191011_20000.wav (20:15, Lluvia y actividad Lemur)

# rec4<-readWave("templatefiles/grabaciones/SUKIA_20191011_200000.wav")
# rec4<-cutWave(rec4,from=916, to=917)
# writeWave(rec4,"templatefiles/templates/rec_20191011_20:15pm.wav")

temp.4<-makeCorTemplate(clip="templatefiles/templates/rec_20191011_20:15pm.wav", name="T4",t.lim=c(0.1 ,0.3),frq.lim = c(1.9,2.8))

#Template 5: Data/SUKIA_20191011_21000.wav (21:05, lluvia y actividad lemur)

# rec5<-readWave("templatefiles/grabaciones/SUKIA_20191011_210000.wav")
# rec5<-cutWave(rec5,from=7, to=8)
# writeWave(rec5,"templatefiles/templates/rec_20191011_21:05pm.wav")

temp.5<-makeCorTemplate(clip="templatefiles/templates/rec_20191011_21:05pm.wav", name="T5",t.lim=c(0 ,0.3),frq.lim = c(1.9,2.7))


#Template 6: Data/SUKIA_20191012_020000.wav (02:15 Mucha actividad Lemur) 

# rec6<-readWave("templatefiles/grabaciones/SUKIA_20191012_020000.wav")
# rec6<-cutWave(rec6,from=1092, to=1093)
# writeWave(rec6,"templatefiles/templates/rec_20191012_02:15pm.wav")

temp.6<-makeCorTemplate(clip="templatefiles/templates/rec_20191012_02:15pm.wav", name="T6",t.lim=c(0,0.3),frq.lim = c(2.1,2.8)) 

#Suena bajito, no estoy segura si estara bien 


#Template 7: Data/SUKIA_20191015_010000.wav (01:05 Actividad de 1 individuo)

# rec7<-readWave("templatefiles/grabaciones/SUKIA_20191015_010000.wav")
# rec7<-cutWave(rec7,from=107, to=108)
# writeWave(rec7,"templatefiles/templates/rec_20191015_01:05pm.wav")

temp.7<-makeCorTemplate(clip="templatefiles/templates/rec_20191015_01:05pm.wav", name="T7",t.lim=c(0 ,0.15),frq.lim = c(2.1,2.7))

#Este canto es importante porque en el espectro tenemos otras se;ales de otras especies, probablemente diastemas! Visualmente parece
#que la señal de lemur se enmascara, no estoy 100% segura que esta región sea la señal de la grabación que ando buscando o si bien está
#más abajito.


#Template8: Data/SUKIA_20191102_22000.wav (22:05, poca actividad)

# rec8<-readWave("templatefiles/grabaciones/SUKIA_20191102_220000.wav")
# rec8<-cutWave(rec8,from=27, to=28)
# writeWave(rec8,"templatefiles/templates/rec_20191102_22:05pm.wav")

temp.8<-makeCorTemplate(clip="templatefiles/templates/rec_20191102_22:05pm.wav", name="T8", t.lim=c(0.35 ,0.7),frq.lim = c(2.2,2.8))


#Template 9: Data/SUKIA_20191101_18000.wav (18:05, poca actividad)

# rec9<-readWave("templatefiles/grabaciones/SUKIA_20191101_180000.wav")
# rec9<-cutWave(rec9,from=134, to=135)
# writeWave(rec9,"templatefiles/templates/rec_20191101_18:05pm.wav")

temp.9<-makeCorTemplate(clip="templatefiles/templates/rec_20191102_22:05pm.wav", name="T9",t.lim=c(0.35 ,0.7),frq.lim = c(2.3,2.9))


#Template 10: Data/SUKIA_20191204_010000.wav (01:05, actividad de Cruziohyla y Lemur) 

# rec10<-readWave("templatefiles/grabaciones/SUKIA_20191204_010000.wav")
# rec10<-cutWave(rec10,from=83, to=84)
# writeWave(rec10,"templatefiles/templates/rec_20191204_01:05pm.wav")

temp.10<-makeCorTemplate(clip="templatefiles/templates/rec_20191204_01:05pm.wav", name="T10", t.lim=c(0.1 ,0.4),frq.lim = c(2.1,2.8))

#Template 11: Data/SUKIA_20191219_22000.wav (22:05, mucha actividad Lemur)

# rec11<-readWave("templatefiles/grabaciones/SUKIA_20191219_220000.wav")
# rec11<-cutWave(rec11,from=10, to=11)
# writeWave(rec11,"templatefiles/templates/rec_20191219_22:05pm.wav")

temp.11<-makeCorTemplate(clip="templatefiles/templates/rec_20191219_22:05pm.wav", name="T11", t.lim=c(0.5 ,0.9),frq.lim = c(1.8,3))


#Template 12: Data/SUKIA_20191215_040000.wav (04:15, muy poca actividad)

# rec12<-readWave("templatefiles/grabaciones/SUKIA_20191215_040000.wav")
# rec12<-cutWave(rec12,from=987, to=988)
# writeWave(rec12,"templatefiles/templates/rec_20191215_04:15pm.wav")

temp.12<-makeCorTemplate(clip="templatefiles/templates/rec_20191215_04:15pm.wav", name="T12", t.lim=c(0.7 , 1),frq.lim = c(2,3) )


#Template 13: Data/SUKIA_20191224_17000.wav (17:05, muucha actividad de otras sp)

# rec13<-readWave("templatefiles/grabaciones/SUKIA_20191224_170000.wav")
# rec13<-cutWave(rec13,from=20, to=25)
# writeWave(rec13,"templatefiles/templates/rec_220191224_17:05pm.wav")

temp.13<-makeCorTemplate(clip="templatefiles/templates/rec_220191224_17:05pm.wav", name="T13",t.lim=c(0.8 ,1.5),frq.lim = c(1.8,2))

#Esta es una buena grabacion porque tiene a callydrias de fondo y parece ser un canto de lemur, nada mas hay que corroborar
#que si sea lemur 

###se ve rarilla### 

#Template 14: Data/SUKIA_20200105_040000.wav (4:15, mucha lluvia y actividad lemur)

# rec14<-readWave("templatefiles/grabaciones/SUKIA_20200105_040000.wav")
# rec14<-cutWave(rec14,from=1018, to=1019)
# writeWave(rec14,"templatefiles/templates/rec_20200105_04:15pm.wav")

#temp.14<-makeCorTemplate(clip="templatefiles/templates/rec_220191224_17:05pm.wav", name="T14",t.lim=c(0.9 ,2),frq.lim = c(1.8,2.3))

#Corroborar seleccione un canto que suena a dos señales pero fue dificil determinarla en el espectro. 


#Template 15:Data/SUKIA_20200114_030000.wav (03:05,  mucha lluvia un poquito mas de actividad )

# rec15<-readWave("templatefiles/grabaciones/SUKIA_20200105_040000.wav")
# rec15<-cutWave(rec15,from=133, to=134)
# writeWave(rec15,"templatefiles/templates/rec_20200114_03:15pm.wav")

#temp.15<-makeCorTemplate(clip="templatefiles/templates/rec_20200114_03:15pm.wav", name="T15",select="rect")

#****Corroborar lluvia hace dificil determinar el canto, al cortar la grabacion y escucharlo aislado casi no se aprecia


#Template 16: Data/SUKIA_20191126_22000.wav (22:15, actividad #2)

# rec16<-readWave("templatefiles/grabaciones/SUKIA_20191202_200000.wav")
# rec16<-cutWave(rec16,from=902, to=903)
# writeWave(rec16,"templatefiles/templates/rec_20191202_20:00pm.wav")

temp.16<-makeCorTemplate(clip="templatefiles/templates/rec_20191202_20:00pm.wav", name="T16",t.lim=c(0.15 ,0.6),frq.lim = c(2.2,2.9))

#Template 17: Data/SUKIA_20200102_23000.wav (23:15 mucha mucha actividad)

# rec17<-readWave("templatefiles/grabaciones/SUKIA_20200102_230000.wav")
# rec17<-cutWave(rec17,from=911, to=912)
# writeWave(rec17,"templatefiles/templates/rec_20200102_23:15pm.wav")

temp.17<-makeCorTemplate(clip="templatefiles/templates/rec_20200102_23:15pm.wav", name="T17",,t.lim=c(0.54 ,1),frq.lim = c(2,2.8))

#Template 18: Data/SUKIA_20191126_22000.wav (22:15) 

# rec18<-readWave("templatefiles/grabaciones/SUKIA_20191126_220000.wav")
# rec18<-cutWave(rec18,from=907, to=908)
# writeWave(rec18,"templatefiles/templates/rec_20191126_22:15pm.wav")

temp.18<-makeCorTemplate(clip="templatefiles/templates/rec_20191126_22:15pm.wav", name="T18",t.lim=c(0.65 ,0.83),frq.lim = c(2.3,3))

#Template 19: Data/SUKIA_20200131_030000.wav (03:15)

# rec19<-readWave("templatefiles/grabaciones/SUKIA_20200131_030000.wav")
# rec19<-cutWave(rec19,from=977, to=978)
# writeWave(rec19,"templatefiles/templates/rec_20200131_03:15pm.wav")

temp.19<-makeCorTemplate(clip="templatefiles/templates/rec_20200131_03:15pm.wav", name="T19",t.lim=c(0.32,0.8),frq.lim = c(2,3))

#Template 20: Data/SUKIA_20200201_22000.wav (22:05)

# rec20<-readWave("templatefiles/grabaciones/SUKIA_20200201_220000.wav")
# rec20<-cutWave(rec20,from=53, to=54)
# writeWave(rec20,"templatefiles/templates/rec_202002011_22:05pm.wav")

temp.20<-makeCorTemplate(clip="templatefiles/templates/rec_20191126_22:15pm.wav", name="T20",t.lim=c(0.67 ,0.87),frq.lim = c(2.3,2.8))

#Template 21: Data/SUKIA_20200204_040000.wav (04:05)

# rec21<-readWave("templatefiles/grabaciones/SUKIA_20200204_040000.wav")
# rec21<-cutWave(rec21,from=185, to=186)
# writeWave(rec21,"templatefiles/templates/rec_20200204_04:05pm.wav")

temp.21<-makeCorTemplate(clip="templatefiles/templates/rec_20200204_04:05pm.wav", name="T21",t.lim=c(0.38 ,0.65),frq.lim = c(1.8,3))

#Template 22: Data/SUKIA_20191030_010000.wav (01:05)

# rec22<-readWave("templatefiles/grabaciones/SUKIA_20191030_010000.wav")
# rec22<-cutWave(rec22,from=203, to=204)
# writeWave(rec22,"templatefiles/templates/rec_20191030_01:05pm.wav")

temp.22<-makeCorTemplate(clip="templatefiles/templates/rec_20191030_01:05pm.wav", name="T22",t.lim=c(0.48 ,0.8),frq.lim = c(2,3))

#Template 23:Data/SUKIA_20191119_20000.wav

# rec23<-readWave("templatefiles/grabaciones/SUKIA_20191119_200000.wav")
# rec23<-cutWave(rec23,from=35, to=36)
# writeWave(rec23,"templatefiles/templates/rec_220191119_20:05pm.wav")

temp.23<-makeCorTemplate(clip="templatefiles/templates/rec_220191119_20:05pm.wav", name="T23",t.lim=c(0.66 ,1),frq.lim = c(2.2,3))

#Template 24: Data/SUKIA_20191020_22000.wav (22:15)

# rec24<-readWave("templatefiles/grabaciones/SUKIA_20191020_220000.wav")
# rec24<-cutWave(rec24,from=915, to=916)
# writeWave(rec24,"templatefiles/templates/rec_20191020_22:15pm.wav")

temp.24<-makeCorTemplate(clip="templatefiles/templates/rec_20191020_22:15pm.wav", name="T24",t.lim=c(0.1,0.5),frq.lim = c(2,3))

#Template 25: Data/SUKIA_20191113_21000.wav (21:05)

# rec25<-readWave("templatefiles/grabaciones/SUKIA_20191113_210000.wav")
# rec25<-cutWave(rec25,from=948, to=949)
# writeWave(rec25,"templatefiles/templates/rec_20191113_21:05pm.wav")

temp.25<-makeCorTemplate(clip="templatefiles/templates/rec_20191113_21:05pm.wav", name="T25",t.lim=c(0,0.5),frq.lim = c(2.2,2.8))

#Template 26: Data/SUKIA_20191220_18000.wav (18:15)

# rec26<-readWave("templatefiles/grabaciones/SUKIA_20191220_180000.wav")
# rec26<-cutWave(rec26,from=912, to=913)
# writeWave(rec26,"templatefiles/templates/rec_20191220_18:15pm.wav")

temp.26<-makeCorTemplate(clip="templatefiles/templates/rec_20191220_18:15pm.wav", name="T26",t.lim=c(0.4,0.8),frq.lim = c(2.1,2.8))


#####NUEVO##### 

#Crear una lista de templates 

#lemur.temp<-combineCorTemplates(temp.1,temp.3,temp.5,temp.8,temp.9,temp.10,
                                   # temp.11,temp.12,temp.16,temp.17,temp.19,
                                    #temp.21,temp.22,temp.23,temp.24,temp.25,temp.26)

lemur.temp<-combineCorTemplates(temp.1,temp.3,temp.5)

templateCutoff(lemur.temp)[1:length(lemur.temp)]<-rep(0.4,length(lemur.temp))

#lemur.temp<-combineCorTemplates(temp.1,temp.2,temp.3)

#plot(lemur.temp)
#Leer las grabaciones para que sean validadas por el reconocedor 
grabaciones.fp<-file.path("templatefiles/grabaciones/","SUKIA_2019-08-31_232000_UTC-6.wav")
#Contrastar grabaciones con templates 
cscores <- corMatch(grabaciones.fp,lemur.temp)

#Detectar senales de lemur
cdetects<- findPeaks(cscores)

detecciones<-getDetections(cdetects)

cantos<-timeAlign(cdetects)



###Ahora ver que pasa con 2 grabaciones####

aggregate(x=detecciones$score, by=list(detecciones$template), FUN=length)

plot(temp.26)

n.cantos<-nrow(cantos)



########INSTALAR PAQUETE############ 

require(rmarkdown)
library(rmarkdown)
install.packages("rmarkdown")
