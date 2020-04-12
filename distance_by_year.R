library(tidyverse)
library(here)
library(scales)

#Import data
tdf <- read_csv(here::here("2020-04-07-tour/data/tdf.csv"))

tdf_data <- tdf %>% mutate(
  year = year(start_date),
  n = row_number()
)

#Distance by year
p <- ggplot(data = tdf_data, aes(x = year, y = distance))
p1 <- p+ 
  geom_line(data = filter(tdf_data, year < 1915), color ="gray") +
  geom_line(data = filter(tdf_data, year >1918 & year < 1940),color ="gray")+
  geom_line(data = filter(tdf_data, year > 1946),color ="gray")+
  geom_point() +
  scale_x_continuous()+
  scale_y_continuous(label = unit_format(unit = "km", sep = " "))+
  labs(
    title = "The Tour de France is getting shorter",
    subtitle = c("The 2019 edition was 2396km shorter than the longest tour in 1926.")
  )+ 
  theme_minimal()
  
p1