## --------------------------------------------------------------------------------------------
## SCRIPT: ggmap
## TALLER: Geoinquietos + RLadies
## FECHA: 25/03/2017
## Paquetes Necesarios: ggplot2,ggmap
##
## Para más información sobre el paquete ggmap:
## D. Kahle and H. Wickham. ggmap: Spatial Visualization with ggplot2. The R Journal,
## 5(1), 144-161. URL http://journal.r-project.org/archive/2013-1/kahle-wickham.pdf
## --------------------------------------------------------------------------------------------

## ---------------------------------------------------------------------------------------------

##### 1. Bloque de inicializacion de librerias #####

# ejecutar si no se dispone del paquete ggmap
# devtools::install_github("dkahle/ggmap") 
# ejecutar si al ejecutar los comandos aparecen errores relacionados con el environment
# devtools::install_github("hadley/ggplot2@v2.2.0")
library(ggmap)

## -------------------------------------------------------------------------

##### 2. Bloque de parametros iniciales #####
setwd("~/Desktop/Taller")


## -------------------------------------------------------------------------

##### 3. Bloque de carga de informacion #####

Viviendas <- read.csv("listings.csv")

## -------------------------------------------------------------------------

##### 4. Bloque de visualizacion de mapas #####

# A partir de la longitud y la latitud
Madrid=c(-3.6883432,40.453054)
map.Madrid <- get_map(location = Madrid)
save(map.Madrid,file="mapa madrid.map")
ggmap(map.Madrid)

# A partir de una posicion concreta
Barcelona <- geocode("Barcelona",source = "google")
map.Barcelona <- get_map(location = Barcelona)
ggmap(map.Barcelona)

# A partir de la zona perimetral
PeninsulaIberica <- c(left=-12,bottom=34,right=4,top=44.5)
mapPeninsulaIberica <- get_map(PeninsulaIberica)
ggmap(mapPeninsulaIberica)

## EJERCICIO: Visualizar un mapa de Nueva York

NuevaYork <- geocode("Nueva York",source = "google")
map.NuevaYork <- get_map(location = NuevaYork)
ggmap(map.NuevaYork)

## -------------------------------------------------------------------------

##### 4. Bloque de tipos de mapas #####

# el maptype por defecto es "terrain"

mapPeninsulaIberica <- get_map(PeninsulaIberica, maptype = "satellite")
ggmap(mapPeninsulaIberica)
mapPeninsulaIberica <- get_map(PeninsulaIberica, maptype = "hybrid")
ggmap(mapPeninsulaIberica)
mapPeninsulaIberica <- get_map(PeninsulaIberica, maptype = "roadmap")
ggmap(mapPeninsulaIberica)
mapPeninsulaIberica <- get_map(PeninsulaIberica, maptype = "watercolor")
ggmap(mapPeninsulaIberica)

## EJERCICIO: Visualizar un mapa de Nueva York tipo satellite

mapNuevaYork <- get_map(NuevaYork, maptype = "satellite")
ggmap(mapNuevaYork)

## -------------------------------------------------------------------------

##### 4. Bloque de zoom #####

Bernabeu=c(-3.6883432,40.453054)
map.Bernabeu <- get_map(location = Bernabeu,zoom = 17,maptype = "satellite")
ggmap(map.Bernabeu)

dev.off()
png("./mapa bernabeu.png")
ggmap(map.Bernabeu)
dev.off()

ArtedeMedir <- geocode("El Arte de Medir, Calle Cundinamarca, Madrid",source = "google")
map.ArtedeMedir <- get_map(location = as.numeric(ArtedeMedir),zoom = 20,maptype = "satellite")
ggmap(map.ArtedeMedir)

dev.off()
png("./mapa elartedemedir.png")
ggmap(map.ArtedeMedir)
dev.off()

## EJERCICIO: Visualizar un mapa de Nueva York tipo roadmap con Zoom 14


NuevaYork <- geocode("NuevaYork",source = "google")
map.NuevaYork<- get_map(location = as.numeric(NuevaYork),zoom = 14,maptype = "roadmap")
ggmap(map.NuevaYork)
## -------------------------------------------------------------------------

##### 5. Bloque de distancias #####

desde=c("El Arte de Medir, Calle Cundinamarca, Madrid")
hasta=c("Medialab-Prado, Calle de la Alameda, Madrid")

mapdist(desde, hasta, mode = "driving")
mapdist(desde, hasta, mode = "bicycling")
mapdist(desde, hasta, mode = "walking")

## EJERCICIO: Calcular la distancia entre Central Park y Wall Street en bicicleta, caminando y en coche

desde=c("Estación de Madrid Atocha, Plaza Emperador Carlos V, Madrid")
hasta=c("Chamartín, Madrid")
mapdist(desde, hasta, mode = "driving")
mapdist(desde, hasta, mode = "bicycling")
mapdist(desde, hasta, mode = "walking")

## -------------------------------------------------------------------------

##### 6. Bloque de posicionamiento de objetos #####

#ArtedeMedir <- geocode("El Arte de Medir, Calle Cundinamarca, Madrid",source = "google")
#map.ArtedeMedir <- get_map(location = as.numeric(ArtedeMedir),zoom = 18,maptype = "roadmap")
str(ArtedeMedir)
ggmap(map.ArtedeMedir) + geom_point(aes(x = lon, y = lat),
                                    data = ArtedeMedir, colour = 'red',
                                    size = 4)

str(Viviendas)
#Madrid=c(-3.6883432,40.453054)
map.Madrid <- get_map(location = Madrid)
ggmap(map.Madrid)+ geom_point(aes(x = longitude, y = latitude),
                                       data = Viviendas, colour = 'red', alpha=1)

## -------------------------------------------------------------------------

##### 6. Bloque de consulta de consumo de API #####

geocodeQueryCheck()

## -------------------------------------------------------------------------

##### 7. Bloque de representacion de variables categoricas #####

str(Viviendas)
table(Viviendas$room_type)
#Madrid=c(-3.6883432,40.453054)
map.Madrid <- get_map(location = Madrid,zoom=12,maptype = "satellite")
ggmap(map.Madrid)+ geom_point(aes(x = longitude, y = latitude),
                              data = Viviendas, colour = 4+as.numeric(Viviendas$room_type))

#Bernabeu=c(-3.6883432,40.453054)
map.Bernabeu <- get_map(location = Bernabeu,zoom = 16,maptype = "satellite")
ggmap(map.Bernabeu) + geom_point(aes(x = longitude, y = latitude),
                                 data = Viviendas, colour = 4+as.numeric(Viviendas$room_type))

## EJERCICIO: Representar en un mapa tipo satellite las viviendas cercanas a Sol con Zoom 18

Sol=c(-3.7033,40.4169)
map.Sol <- get_map(location = Sol,zoom = 18,maptype = "satellite")
ggmap(map.Sol) + geom_point(aes(x = longitude, y = latitude),
                                 data = Viviendas, colour = 4+as.numeric(Viviendas$room_type))

## -------------------------------------------------------------------------

##### 8. Bloque de representacion de variables continuas #####

str(Viviendas)
hist(Viviendas$price)
hist(log(Viviendas$price))
#Madrid=c(-3.6883432,40.453054)
map.Madrid <- get_map(location = Madrid,zoom=12,maptype = "satellite")
ggmap(map.Madrid)+ geom_point(aes(x = longitude, y = latitude,col = room_type,size=price) ,
                              data = Viviendas)

#Bernabeu=c(-3.6883432,40.453054)
map.Bernabeu <- get_map(location = Bernabeu,zoom = 16,maptype = "satellite")
ggmap(map.Bernabeu) + geom_point(aes(x = longitude, y = latitude,col = room_type,size=price) ,
                                 data = Viviendas)

ggmap(map.Bernabeu) + geom_point(aes(x = longitude, y = latitude,col = room_type,size=price) ,
                                 data = Viviendas,shape=8)


ggmap(map.Bernabeu) + geom_point(aes(x = longitude, y = latitude), shape=2,
                                 data = Viviendas, colour = 5+as.numeric(Viviendas$room_type),
                                 size=log(Viviendas$price),show.legend = TRUE) 



## -------------------------------------------------------------------------




