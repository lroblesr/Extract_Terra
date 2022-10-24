pacman::p_load(tidyverse, dplyr, readr, readxl)

shp_ID <- "G:/My Drive/Working/BackUp/CEO_Samples/CEO_Samples_25square_Regions_Columna/"

csv_files <- "G:/My Drive/Working/Deforestacion/CSV_Ver04/"

shape <- shp_ID %>%
  list.files(pattern = '*.shp$', recursive = TRUE, full.names = TRUE)

shp <- shape %>% terra::vect()

lista_csv <- list.files(csv_files, full.names = T, pattern = "*.csv")
years <- 2010:2019

nombre_final <- "G:/My Drive/Working/Deforestacion/CSV_FINAL/"

for (i in length(lista_csv):1) {
  # i <- 10
  cat("Proceso en: ", years[i], "\n")
  print(Sys.time())
  data <- read_csv(lista_csv[i])
  if(ncol(data) == 6){
    data <- data[, -1]
  }
  # View(data)

  Weight <- data %>%
    dplyr::select(ID, Class, sum_weight_fraction) %>%
    pivot_wider(names_from = Class, values_from = sum_weight_fraction)

  Count <- data %>%
    dplyr::select(ID, Class, count) %>%
    pivot_wider(names_from = Class, values_from = count)

  Join <- cbind(Weight, Count[, -1])
  # View(Join)
  names(Join) <- c("ID_R",
                  paste0("Weight_",1:3), "Weight_NA",
                  paste0("Count_", 1:3), "Count_NA")

  write.csv(Join, file = paste0(nombre_final, "Defo_Year_",
                                years[i], "_Final.csv"),
            row.names = FALSE)
}
print(Sys.time())
