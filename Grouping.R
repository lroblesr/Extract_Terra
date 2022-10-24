pacman::p_load(tidyverse)

lista_csv <- list.files("CSV/", full.names = T)
years <- 2010:2019

save_dir <- "G:/My Drive/Working/Deforestacion/CSV_Ver03/Year_"
for (i in length(lista_csv):1) {
  # i <- 10
  cat("****************************************", '\n')
  cat("****************************************", '\n')
  cat("Proceso en: ", years[i], "\n")
  print(Sys.time())
  cat("*************************", '\n')
  data <- read_csv(lista_csv[i])
  # View(data)
  
  data <- data %>%
    group_by(ID) %>%
    mutate(Weight_Fraction = Fraction / sum(Fraction)) 
  
  nombre <- paste0(save_dir, years[i], "_Weight_fraction.csv")
  write.csv(data, file = nombre)

  data <- data %>% 
      group_by(ID, Class) %>%
      summarise(
        sum_fraction = sum(Fraction),
        sum_weight_fraction = sum(Weight_Fraction),
        count = n()
      )
  
  nombre <- paste0(save_dir, years[i], "_Grouping_fraction.csv")
  write.csv(data, file = nombre)
}
print(Sys.time())

View(data)