#Primero abrimos la ruta de acceso de los datos COMPLETOS
rm(list=ls())
library(readxl)
datos<- read_excel("datos_VAR.xlsx", na="..")

datos$Consu_reno_N <- as.factor(datos$Consu_reno_N)
datos$P_GSO_N <- as.factor(datos$P_GSO_N)
datos$P_DIE_N <- as.factor(datos$P_DIE_N)
library(knitr)
kable(summary(datos))

boxplot(datos$PIB_PC_LN ~ datos$P_GSO_N, 
        main = "Precio de la gasolina según el PIB per cápita", las = 1, col = "blue4")

boxplot(datos$PIB_PC_LN ~ datos$P_DIE_N, 
        main = "Precio de la gasolina según el PIB per cápita", las = 1, col = "blue4")



#Tiramos el modelo de regresión lineal     
modelo1 <- aov(datos$PIB_PC_LN ~ datos$P_GSO_N, datos$P_DIE_N) 
              
summary(modelo1)

par(mfrow = c(2, 2))
plot(modelo1)


bartlett.test(datos$PIB_PC_LN ~ datos$P_GSO_N, datos$P_DIE_N)
             
shapiro.test(residuals(modelo1))

kruskal.test(datos$PIB_PC_LN ~ datos$P_GSO_N, datos$P_DIE_N)

pgirmess::kruskalmc(datos$PIB_PC_LN ~ datos$P_GSO_N, datos$P_DIE_N)

TukeyHSD(modelo1, conf.level = 0.95)











#Analisis de componentes principales


rm(list=ls())
library(readxl)
datos2 <- read_excel("datos_ACP.xlsx")

summary(datos2)
subdatos <- subset(datos2, select = c(ECO2_LIQUIDO,
                               VA_INDUS,GTO_CONSUFINAL,
                               PIB,CONTAMI_AIRE))

#Analisis de las correlaciones                   
correlaciones <- cor(subdatos)
correlaciones
library(corrplot)
sig <- cor.mtest(subdatos, conf.level = 0.95)
corrplot(correlaciones, method = "number", type = "lower",p.mat = sig[[1]])
ez::ezCor(subdatos, r_size_lims = c(4, 8), label_size = 3)

ZDatos <- scale(subdatos)
head(ZDatos)
#Crear el modelo de componentes principales
modelo1 <- prcomp(subdatos, scale = TRUE)
summary(modelo1)
#Seleccion de componentes (autovalores mayores que 1)
autovalores <- modelo1$sdev^2
autovalores
selec <- sum(autovalores > 1)
selec

plot(autovalores, main = "Gráfico de Sedimentación", 
     xlab = "Nº de Autovalor", ylab="Valor", pch = 16, col = "red4", type = "b", 
     lwd = 2, las = 1)
abline(h = 1, lty = 2, col = "green4")

#Cargas factoriales(correlaciones entre las componente retenidas y las variables originales)
coeficientes <- modelo1$rotation
cargas <- t(coeficientes[, 1:2])*(sqrt(autovalores[1:2]))
cargas
factoextra::fviz_pca_biplot(modelo1)

#Regresión multiple para explicar la variable EMI_CO2
datos2 <- cbind(datos2, modelo1$x[, 1:2])

regre2 <- lm(EMI_CO2 ~ PC1+PC2, data = datos2)
summary(regre2)












#Analisis cluster


rm(list=ls())
library(readxl)
datos3 <- data.frame(read_excel("Datos_CLUS.xlsx"))
datos3$Fecha <- as.factor(datos3$Fecha)
rownames(datos3) <- datos3[,1]
datos3[,1] <- NULL
#Análisis exploratorio
summary(datos3)
par(mfrow = c(2, 2))
hist(datos3$Renovables, main = "Producción de renovables", xlab = "")
hist(datos3$Emisiones_CO2, main = "Emisiones de CO2", xlab = "")
boxplot(datos3$Renovables)
boxplot(datos3$Emisiones_CO2)
#Crear el gráfico y grupos
datostip <- scale(datos3)
head(datostip)

library(scales)
par(mfrow = c(1,1 ))
plot(datostip, col = alpha("orange", 0.5), pch = 19, las = 1)
text(datostip, rownames(datostip), pos = 3, cex = .6)
d <- dist(datostip, method = "euclidean") 
cluster <- hclust(d, method="ward.D")
plot(cluster, cex = .6, xlab = "", ylab = "Distancia", 
     sub = "Cluster de grupos para los años") 

#Función Nbclust
NbClust::NbClust(data = datostip, 
        distance = "euclidean", 
        method = "ward.D", max.nc = 5)

#Metodo no jerarquico
set.seed(1)
tresgrupos <- kmeans(scale(datos3), 3)
library(factoextra)
fviz_dend(cluster, 3)
fviz_cluster(tresgrupos, datostip, show.clust.cent = TRUE,
             ellipse.type = "euclid", star.plot = TRUE, repel = TRUE) 
#Agrupación de boxplot con k-means y caracterización
set.seed(1)
kme <- kmeans(datostip, 3)
kme
datostipkm <- data.frame(datostip, GRUPO = factor(kme$cluster))
datos3$GRUPO <- factor(kme$cluster)
datos3

aggregate(cbind(Renovables, Emisiones_CO2) ~ GRUPO, data = datos3, 
          FUN = mean)

par(mfrow = c(1, 2))
boxplot(Renovables ~ GRUPO, main = "Boxplot de producción de renovables", col = c("palevioletred1","orange","green2"), data = datos3, las = 1)
boxplot(Emisiones_CO2 ~ GRUPO, main = "Boxplot de las emisiones de CO2", col = c("palevioletred1","orange","green2"), data = datos3, las = 1)

