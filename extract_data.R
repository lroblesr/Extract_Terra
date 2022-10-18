# rm(list = ls())
# ls()
setwd('D:/Desktop/Defo')
pacman::p_load(raster, rgdal, dplyr, rstudioapi, sf, tidyverse, exactextractr)

dir_shp  <- "Samples_25/Tiles"
dir_data <- "Data/All/"

ID <- function(ii){
  ifelse(ii<10, paste0("0", ii), ii)
}


shapes <- dir_shp %>% 
          list.files(pattern = '*.shp$', recursive = TRUE,
                     full.names = TRUE) 

ID_Shp <- substr(shapes, 18, 19)

list_data <- list.files("Data/All/", pattern = "*.tif$", full.names = T)
years <- 2016:2019

for (i in 1:length(shapes)) {
  # i <- 1
  cat("******************************", '\n')
  cat("******************************", '\n')
  print(Sys.time())
  cat("Tile: ", i, "\n")
  cat("******************************", '\n')
  shp <- shapes[i] %>% terra::vect()
  save(shp, file = paste0("Samples_25/R/Tile_", ID_Shp[i],".RData"))
  cat("n = ", dim(shp)[1], '\n')
  
  for (j in 1:length(list_data)) {
    # j <- 1
    cat("***********", '\n')
    print(Sys.time())
    cat("Year: ", years[j], '\n')
    cat("***********", '\n')
    
    data <- terra::rast(list_data[j])

    extract_data <- data %>%
                    terra::extract(shp,
                                  df = TRUE,
                                  weights = TRUE,
                                  normalizeWeights = TRUE)

    colnames(extract_data) <- c("ID", "Class", "weight")
    
    nombre_save <- paste0("CSV/Year_", years[j], "_Tile_", ID_Shp[i], ".csv")
    write.csv(extract_data, nombre_save, row.names = FALSE)
  }
}
print(Sys.time())
