# rm(list = ls())
# ls()
setwd('D:/Desktop/Defo/')
pacman::p_load(dplyr, readr)

dir_shp  <- "Data/ShapeFile/CEO_Samples_25square_ID_JOIN/"
dir_csv <- "CSV/"

list_shp <- dir_shp %>%
            list.files(pattern = '*.shp$', recursive = TRUE, full.names = TRUE)

lista_csv <- list.files(dir_csv, full.names = T, pattern = "*.csv")
years <- 2010:2019

shp <- list_shp %>% terra::vect()
cat("n = ", dim(shp), '\n')


for (i in length(lista_csv):1) {
  # i <- 10
  cat("Proceso en: ", years[i], "\n")
  print(Sys.time())
  data <- read_csv(lista_csv[i])
  print(head(data))
  # if(dim(data)[2] == 5){
  #   data <- data[ ,-1]
  # }
  cat("Total dim: ", dim(data), "\n")

  # Ok_to_bind <- ID_OK_R[rep(ID_OK_R$TARGET_FID, Count_data$count), ]
  to_write <- cbind(shp[[1:6]], data)
  write.csv(to_write, file = lista_csv[i], row.names = FALSE)
}
print(Sys.time())
