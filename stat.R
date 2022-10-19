pacman::p_load(dplyr, readr)

lista_csv <- list.files("CSV/Data/", full.names = T)
years <- 2010:2019

for (i in length(lista_csv):1) { # nolint
  cat("Proceso en: ", years[i], "\n")
  print(Sys.time())
  data <- read_csv(lista_csv[i])

  summer <- data %>%
    group_by(ID) %>%
    summarise(
      mean = mean(Class),
      median = median(Class),
      min = min(Class),
      max = max(Class),
      sd = sd(Class),
      var = var(Class),
      count = n()
    )
  write.csv(data, file = lista_csv[i])
}
print(Sys.time())
