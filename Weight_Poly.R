pacman::p_load(dplyr, readr)

lista_csv <- list.files("CSV/Data/", full.names = T)
years <- 2010:2019

for (i in length(lista_csv):1) {
  cat("Proceso en: ", years[i], "\n")
  print(Sys.time())
  data <- read_csv(lista_csv[i])
  data <- data %>%
          group_by(ID) %>%
          mutate(Weight_Poly = Weight / sum(Weight))
  write.csv(data, file = lista_csv[i])
}
print(Sys.time())
