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
####-----------------amplicons---------------------------------------------####
amplicon <- data.frame()

for (col in names(metadata)) {
  filas_con_amplicon <- which(
    grepl("amplicon", metadata[[col]],ignore.case = TRUE))
  
  
  if (length(filas_con_amplicon) > 0) {
    amplicon <- rbind(amplicon, metadata[filas_con_amplicon, ])
  }
}

amplicon <- amplicon%>%
  unique()
colnames(amplicon)

amplicon_mapa <- amplicon %>%
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


amplicon_mapa$coords <- lapply(
  amplicon_mapa$location, parse_coordinates)


coord_df <- data.frame(do.call(rbind, amplicon_mapa$coords))


amplicon_mapa$lat <- coord_df$X1
amplicon_mapa$lon <- coord_df$X2


num_amplicon <- nrow(amplicon_mapa)

# Filtrar los datos para eliminar las ubicaciones en Europa, Estados unidos, China y en Africa continental.
amplicon_mapa <- amplicon_mapa %>%
  dplyr::filter(!(lat > 31 )) %>%  # Eliminar ubicaciones al norte de lat 31
  dplyr::filter(!(lat > 3 & lat < 12 & lon > 34 & lon < 42)) #Ubicaciones en la sabana Africana


map_amplicon <- leaflet(
  amplicon_mapa, options = leafletOptions(
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
    html = "<h3>AMPLICORN</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_amplicon),
    position = "bottomleft"
  )

# Mostrar el mapa
map_amplicon

# MAPA Water-------------------------------------------------------------------
amplicon_water <- data.frame()

for (col in names(metadata)) {
  filas_con_water <- which(
    grepl("SEAWATER", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_water) > 0) {
    amplicon_water <- rbind(
      amplicon_water, metadata[filas_con_water, ])
  }
}

amplicon_water <- amplicon_mapa %>%
  dplyr::filter(study_accession %in% amplicon_water$study_accession)

num_amplicon_water <- nrow(amplicon_water)

map_amplicon_water <- leaflet(
  amplicon_water, options = leafletOptions(
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
    html = "<h3>AMPLICORN, SEAWEATER</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_amplicon_water),
    position = "bottomleft"
  )

# Mostrar el mapa
map_amplicon_water


####-------------------amplicon sediment-----------------------------------####
amplicon_sediment <- data.frame()

for (col in names(metadata)) {
  filas_con_sediment <- which(
    grepl("sediment", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_sediment) > 0) {
    amplicon_sediment <- rbind(
      amplicon_sediment, metadata[filas_con_sediment, ])
  }
}



amplicon_sediment <- amplicon_mapa %>%
  dplyr::filter(study_accession %in% amplicon_sediment$study_accession)


num_amplicon_sediment <- nrow(amplicon_sediment)

map_amplicon_sediment <- leaflet(
  amplicon_sediment, options = leafletOptions(zoomControl = FALSE)) %>%
  addProviderTiles("Stadia.AlidadeSmooth") %>%
  addCircleMarkers(
    lng = ~lon,        
    lat = ~lat,        
    radius = 1,        
    fillOpacity = 0.6, 
    color = "skyblue"   
  ) %>%
  addControl(
    html = "<h3>AMPLICORN, SEDIMENT</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_amplicon_sediment),
    position = "bottomleft"
  )

# Mostrar el mapa
map_amplicon_sediment

##------------amplicon rhizosfera------------------------------------------####
amplicon_rhizosphere <- data.frame()

for (col in names(metadata)) {
  filas_con_rhizosphere <- which(
    grepl("rhizosphere", metadata[[col]],ignore.case = TRUE))
  
  if (length(filas_con_rhizosphere) > 0) {
    amplicon_rhizosphere <- rbind(
      amplicon_rhizosphere, metadata[filas_con_rhizosphere, ])
  }
}

amplicon_rhizosphere <- amplicon_mapa %>%
  dplyr::filter(
    study_accession %in% amplicon_rhizosphere$study_accession)


num_amplicon_rhizosphere <- nrow(amplicon_rhizosphere)


map_amplicon_rhizosphere <- leaflet(
  amplicon_rhizosphere, options = leafletOptions(
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
    html = "<h3>AMPLICORN, RIZOSFERA</h3>",
    position = "topright"
  ) %>%
  addControl(
    html = paste("Number of studies: ", num_amplicon_rhizosphere),
    position = "bottomleft"
  )

# Mostrar el mapa
map_amplicon_rhizosphere

## MAPA POR CATEGORIA----------------------------------------------------------

# Cargar las ubicaciones de las tres bases de datos
locations_water <- data.frame(
  lat = amplicon_water$lat, lon = amplicon_water$lon)
locations_rhizosphere <- data.frame(
  lat = amplicon_rhizosphere$lat, lon = amplicon_rhizosphere$lon)
locations_sediment <- data.frame(
  lat = amplicon_sediment$lat, lon = amplicon_sediment$lon)

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
    html = "<h3>AMPLICORN</h3>",
    position = "topright"
  ) %>%
  # Agregar leyenda
  addLegend(
    position = "bottomright",
    colors = c("blue", "darkblue", "skyblue"),
    labels = c(paste("Water: ", num_amplicon_water), paste(
      "Rhizosphere: ", num_amplicon_rhizosphere), paste(
        "Sediment: ", num_amplicon_sediment) )
  )%>%
  addControl(
    html = paste("Number of studies: ", num_amplicon),
    position = "bottomleft"
  )

# Mostrar el mapa
map_combined

