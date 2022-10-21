# rm(list = ls())
# ls()
setwd('D:/Desktop/Defo')
pacman::p_load(terra, tidyverse)

dir_shp <- "D:/Desktop/Defo/Data/ShapeFile/CEO_Samples_25square/"
dir_data <- "D:/Desktop/Defo/Data/Raster/"

shapes <- dir_shp %>%
          list.files(pattern = '*.shp$', recursive = TRUE,
                    full.names = TRUE)

list_data <- list.files(dir_data, pattern = "*.tif$", full.names = T)
years <- 2010:2019

print(Sys.time())
cat("******************************", '\n')
shp <- shapes %>% terra::vect()
cat("n = ", dim(shp)[1], '\n')

for (i in length(list_data):1) {
  # i <- 10
  cat("*********************************", '\n')
  cat("*********************************", '\n')
  print(Sys.time())
  cat("Year: ", years[i], '\n')
  cat("*********************************", '\n')
  data <- terra::rast(list_data[i])

  extract_data <- data %>%
                  terra::extract(shp,
                                df = TRUE,
                                weights = FALSE,
                                exact = TRUE
                                # normalizeWeights = TRUE
                                )
  dim(extract_data)
  # View(extract_data)

  colnames(extract_data) <- c("ID", "Class", "Fraction")

  nombre_save <- paste0("CSV/Year_", years[i], "_fraction.csv")
  write.csv(extract_data, nombre_save, row.names = FALSE)
}
print(Sys.time())
# 3:12
