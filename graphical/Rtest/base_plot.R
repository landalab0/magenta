
# Change the path to the local file, you don't have to download.
# download.file("http://thematicmapping.org/downloads/TM_WORLD_BORDERS_SIMPL-0.3.zip" , destfile="~/Desktop/world_shape_file.zip")

# Unzip if you have the zip file
# system("unzip ~/Desktop/world_shape_file.zip")
# You have 4 files. One of these files is a .shp file (TM_WORLD_BORDERS_SIMPL-0.3.shp)

# Call (you can use the /external for some)
library(rgdal)
library(dplyr)
library(leaflet)
library(RColorBrewer)


# The map with all the abstract borders
world_spdf <- readOGR( 
  dsn= "~/Desktop/world_shape_file" , 
  layer="TM_WORLD_BORDERS_SIMPL-0.3",
  verbose=FALSE
)

# Clean 
world_spdf@data$POP2005[ which(world_spdf@data$POP2005 == 0)] = NA
world_spdf@data$POP2005 <- as.numeric(as.character(world_spdf@data$POP2005)) / 1000000 %>% round(2)

mypalette <- colorNumeric( palette="viridis", domain=world_spdf@data$POP2005, na.color="transparent")
mypalette(c(45,43))

# Choropleth
m <- leaflet(world_spdf) %>% 
  addTiles()  %>% 
  setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( fillColor = ~mypalette(POP2005), stroke=FALSE )

m <- leaflet(world_spdf)%>% addTiles()  %>% setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5, color = ~colorQuantile("YlOrRd", POP2005)(POP2005) )


m <- leaflet(world_spdf)%>% addTiles()  %>% setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5, color = ~colorNumeric("YlOrRd", POP2005)(POP2005) )


m <- leaflet(world_spdf)%>% addTiles()  %>% setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( stroke = FALSE, fillOpacity = 0.5, smoothFactor = 0.5, color = ~colorBin("YlOrRd", POP2005)(POP2005) )

mybins <- c(0,10,20,50,100,500,Inf)
mypalette <- colorBin( palette="YlOrBr", domain=world_spdf@data$POP2005, na.color="transparent", bins=mybins)

# This is where you shold insert the data of interest, you create a df and link our data with the world_spf df.
# So instead of data$AREA it should be pointing at our file of interest (country_count, country names, etc.)
mytext <- paste(
  "Country: ", world_spdf@data$NAME,"<br/>", 
  "Area: ", world_spdf@data$AREA, "<br/>", 
  "Population: ", round(world_spdf@data$POP2005, 2), 
  sep="") %>%
  lapply(htmltools::HTML)

# Final Map
leaflet(world_spdf) %>% 
  addTiles()  %>% 
  setView( lat=10, lng=0 , zoom=2) %>%
  addPolygons( 
    fillColor = ~mypalette(POP2005), 
    stroke=TRUE, 
    fillOpacity = 0.9, 
    color="white", 
    weight=0.3,
    label = mytext,
    labelOptions = labelOptions( 
      style = list("font-weight" = "normal", padding = "3px 8px"), 
      textsize = "13px", 
      direction = "auto"
    )
  ) %>%
  addLegend( pal=mypalette, values=~POP2005, opacity=0.9, title = "Population (M)", position = "bottomleft" )

