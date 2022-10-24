pacman::p_load(stars, terra, tidyverse, raster)

# View_tiny <- read_stars("D:/Desktop/Defo/Data/Tiny_buffer.tif")
# plot(View_tiny, text_values = T, axes = T, col = terrain.colors(3))

data_tiny <- rast("D:/Desktop/Defo/Data/ShapeFile/Tiny_buffer.tif")
plot(data_tiny)

Tiny_shp <- "D:/Desktop/Defo/Data/ShapeFile/Tiny_1Poly/Tiny3.shp" %>% vect()
plot(Tiny_shp, add = T)

# Tiny_extract_weight   <- terra::extract(data_tiny, Tiny_shp,
#                                 weight = TRUE
#                                 # cells = TRUE
#                                 )
# porcentaje_weight <- Tiny_extract %>%
#                       group_by(ID) %>%
#                       mutate(Weight_Poly = weight / sum(weight))

Tiny_extract_fraction <- terra::extract(data_tiny, Tiny_shp,
                                weight = FALSE,
                                exact = TRUE
                                # cells=T
                                )

porcentaje_fraction <- Tiny_extract_fraction %>%
                        group_by(ID) %>%
                        mutate(Weight_fraction = fraction / sum(fraction))

# Analy <- cbind(ID = porcentaje_weight$ID,
#                 Clase = porcentaje_weight$Tiny_buffer,
#                 Weight = porcentaje_weight$weight,
#                 Fraction= porcentaje_fraction$fraction,
#                 Porcentaje_Weight= porcentaje_weight$Weight_Poly,
#                 Porcentaje_Fraction= porcentaje_fraction$Weight_Poly)
# View(Analy)

# View(porcentaje_fraction)

grouping_fraction <- porcentaje_fraction %>%
  group_by(ID, Tiny_buffer) %>%
  summarise(
    sum_fraction = sum(fraction),
    sum_weight_fraction = sum(Weight_fraction),
    count = n()
  )


Weight <- grouping_fraction %>%
  dplyr::select(ID, Tiny_buffer, sum_weight_fraction) %>%
  pivot_wider(names_from = Tiny_buffer, values_from = sum_weight_fraction)

Count <- grouping_fraction %>%
  dplyr::select(ID, Tiny_buffer, count) %>%
  pivot_wider(names_from = Tiny_buffer, values_from = count)
