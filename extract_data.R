# rm(list = ls())
# ls()
setwd('D:/Desktop/Defo')
pacman::p_load(raster, rgdal, dplyr, rstudioapi, sf, tidyverse, exactextractr)

dir_shp  <- "Samples_25/All/"
dir_data <- "Data/All/"

shapes <- dir_shp %>% 
          list.files(pattern = '*.shp$', recursive = TRUE,
                     full.names = TRUE) 

list_data <- list.files("Data/All/", pattern = "*.tif$", full.names = T)
years <- 2010:2019

print(Sys.time())
cat("******************************", '\n')
shp <- shapes %>% terra::vect()
shp
save(shp, file = "Samples_25/R/Samples25_square.RData")
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

  colnames(extract_data) <- c("ID", "Class", "Weight")
  
  nombre_save <- paste0("CSV/Year_", years[j], ".csv")
  write.csv(extract_data, nombre_save, row.names = FALSE)
}
print(Sys.time())
