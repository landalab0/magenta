####----------------Packs---------------------------------------------------####
paquetes <- c(
  "tidyverse", "readxl", "devtools", "leaflet","leaflet.extras", "conflicted","ggmap")

instalar <- function(paquetes) {
  for (paquete in paquetes) {
    if (grepl("/", paquete)) {
      devtools::install_github(paquete)
    } else if (!require(paquete, character.only = TRUE)) {
      install.packages(paquete)
    }
    library(paquete, character.only = TRUE)
  }
}

instalar(paquetes)

lapply(paquetes, function(paquete) library(paquete, character.only = TRUE))
####------------------Data base--------------------------------------------####
#por poner enlace para descargar
ruta_archivo <- "C:\\Users\\cp_cu\\OneDrive\\Escritorio\\Mapa 05 10 23\\BASE1.xlsx"

metadata <- read_excel(ruta_archivo , skip=1 ) %>%
  distinct()
is.data.frame(metadata)
####-----------------Illumina----------------------------------------------####
#Creamos la base de datos illumina
illumina <- data.frame()

for (col in names(metadata)){
  filas_con_illumina <- which(
    grepl("illumina",tolower(metadata[[col]])))
  if (length(filas_con_illumina) > 0) {
    illumina <- rbind(illumina, metadata[filas_con_illumina, ])
  }
}
illumina <- illumina %>%
  unique()
####-----------------wgss---------------------------------------------####
wgs <- data.frame()

for (col in names(metadata)) {
  filas_con_wgs <- which(
    grepl("wgs", metadata[[col]],ignore.case = TRUE))
  
  
  if (length(filas_con_wgs) > 0) {
    wgs <- rbind(wgs, metadata[filas_con_wgs, ])
  }
}

wgs <- wgs%>%
  unique()
colnames(wgs)

wgs_mapa <- wgs %>%
  select(study_accession, location) %>%
  drop_na()

##Mapa-------------------------------------------------------------------------
# Crear una función para parsear las coordenadas en latitud y longitud
parse_coordinates <- function(coord_string) {
  
  parts <- strsplit(coord_string, " ")
  lat <- as.numeric(parts[[1]][1])
  lon <- as.numeric(parts[[1]][3])
  
  
  if (grepl("S", coord_string)) {
    lat <- -lat
  }
  if (grepl("W", coord_string)) {
    lon <- -lon
  }
  
  return(c(lat, lon))
}


wgs_mapa$coords <- lapply(
  wgs_mapa$location, parse_coordinates)


coord_df <- data.frame(do.call(rbind, wgs_mapa$coords))


wgs_mapa$lat <- coord_df$X1
wgs_mapa$lon <- coord_df$X2


num_wgs <- nrow(wgs_mapa)

# Filtrar los datos para eliminar las ubicaciones en Europa, Estados unidos, China y en Africa continental.
wgs_mapa <- wgs_mapa %>%
  dplyr::filter(!(lat > 31 )) %>%  # Eliminar ubicaciones al norte de lat 31
  dplyr::filter(!(lat > 3 & lat < 12 & lon > 34 & lon < 42)) #Ubicaciones en la sabana Africana


map_wgs <- leaflet(
  wgs_mapa, options = leafletOptions(
    zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  addCircleMarkers(
    lng = ~lon,        
    lat = ~lat,        
    radius = 1,        
    fillOpacity = 0.6, 
    color = "black"   
  ) %>%
  addControl(
    html = "<h3>wgs</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_wgs),
    position = "bottomleft"
  )

# Mostrar el mapa
map_wgs

# MAPA Water-------------------------------------------------------------------
wgs_water <- data.frame()

for (col in names(metadata)) {
  filas_con_water <- which(
    grepl("SEAWATER", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_water) > 0) {
    wgs_water <- rbind(
      wgs_water, metadata[filas_con_water, ])
  }
}

wgs_water <- wgs_mapa %>%
  dplyr::filter(study_accession %in% wgs_water$study_accession)

num_wgs_water <- nrow(wgs_water)

map_wgs_water <- leaflet(
  wgs_water, options = leafletOptions(
    zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  addCircleMarkers(
    lng = ~lon,        
    lat = ~lat,        
    radius = 1,        
    fillOpacity = 0.6, 
    color = "blue"   
  ) %>%
  addControl(
    html = "<h3>wgs, SEAWEATER</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_wgs_water),
    position = "bottomleft"
  )

# Mostrar el mapa
map_wgs_water


####-------------------wgs sediment-----------------------------------####
wgs_sediment <- data.frame()

for (col in names(metadata)) {
  filas_con_sediment <- which(
    grepl("sediment", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_sediment) > 0) {
    wgs_sediment <- rbind(
      wgs_sediment, metadata[filas_con_sediment, ])
  }
}



wgs_sediment <- wgs_mapa %>%
  dplyr::filter(study_accession %in% wgs_sediment$study_accession)


num_wgs_sediment <- nrow(wgs_sediment)

map_wgs_sediment <- leaflet(
  wgs_sediment, options = leafletOptions(zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  addCircleMarkers(
    lng = ~lon,        
    lat = ~lat,        
    radius = 1,        
    fillOpacity = 0.6, 
    color = "skyblue"   
  ) %>%
  addControl(
    html = "<h3>wgs, SEDIMENT</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_wgs_sediment),
    position = "bottomleft"
  )

# Mostrar el mapa
map_wgs_sediment

##------------wgs rhizosfera------------------------------------------####
wgs_rhizosphere <- data.frame()

for (col in names(metadata)) {
  filas_con_rhizosphere <- which(
    grepl("rhizosphere", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_rhizosphere) > 0) {
    wgs_rhizosphere <- rbind(
      wgs_rhizosphere, metadata[filas_con_rhizosphere, ])
  }
}

wgs_rhizosphere <- wgs_mapa %>%
  dplyr::filter(
    study_accession %in% wgs_rhizosphere$study_accession)


num_wgs_rhizosphere <- nrow(wgs_rhizosphere)


map_wgs_rhizosphere <- leaflet(
  wgs_rhizosphere, options = leafletOptions(
    zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  addCircleMarkers(
    lng = ~lon,        
    lat = ~lat,        
    radius = 1,        
    fillOpacity = 0.6, 
    color = "darkblue"   
  ) %>%
  addControl(
    html = "<h3>AMPLICORNIO, RIZOSFERA</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_wgs_rhizosphere),
    position = "bottomleft"
  )

# Mostrar el mapa
map_wgs_rhizosphere

## MAPA POR CATEGORIA----------------------------------------------------------

# Cargar las ubicaciones de las tres bases de datos
locations_water <- data.frame(
  lat = wgs_water$lat, lon = wgs_water$lon)
locations_rhizosphere <- data.frame(
  lat = wgs_rhizosphere$lat, lon = wgs_rhizosphere$lon)
locations_sediment <- data.frame(
  lat = wgs_sediment$lat, lon = wgs_sediment$lon)

# Crear un mapa Leaflet
map_combined <- leaflet(
  , options = leafletOptions(zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  
  
  addCircleMarkers(
    data = locations_water,
    lng = ~lon,
    lat = ~lat,
    radius = 4,
    fillOpacity = 0.6,
    color = "blue",
    group = "Water" 
  ) %>%
  
  
  addCircleMarkers(
    data = locations_rhizosphere,
    lng = ~lon,
    lat = ~lat,
    radius = 4,
    fillOpacity = 0.6,
    color = "darkblue",
    group = "Rhizosphere" 
  ) %>%
  
  
  addCircleMarkers(
    data = locations_sediment,
    lng = ~lon,
    lat = ~lat,
    radius = 4,
    fillOpacity = 0.6,
    color = "skyblue",
    group = "Sediment" 
  ) %>%
  addControl(
    html = "<h3>METAGENOM</h3>",
    position = "topright"
  ) %>%
  # Agregar leyenda
  addLegend(
    position = "bottomright",
    colors = c("blue", "darkblue", "skyblue"),
    labels = c(paste(
      "Water: ", num_wgs_water), paste(
        "Rhizosphere: ", num_wgs_rhizosphere), paste(
          "Sediment: ", num_wgs_sediment) )
  )%>%
  addControl(
    html = paste("Number of studies: ", num_wgs),
    position = "bottomleft"
  )

# Mostrar el mapa
map_combined

