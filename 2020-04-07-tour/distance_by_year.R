library(tidyverse)
library(here)
library(scales)

#Import data
tdf <- read_csv(here::here("2020-04-07-tour/data/tdf.csv"))

tdf_data <- tdf %>% mutate(
  year = year(start_date),
  n = row_number()
)

#Define some variables
lineColor <- "#1380A1"
font <- "Helvetica"

#Distance by year
p <- ggplot(data = tdf_data, aes(x = year, y = distance))
p1 <- p+ 
  geom_line(data = filter(tdf_data, year < 1915), color = lineColor) +
  geom_line(data = filter(tdf_data, year >1918 & year < 1940),color = lineColor)+
  geom_line(data = filter(tdf_data, year > 1946),color = lineColor)+
  geom_point(color = lineColor) +
  scale_x_continuous()+
  scale_y_continuous(label = unit_format(unit = "km", sep = " "))+
  labs(
    title = "The Tour de France is getting shorter",
    subtitle = "Tour de France distance 1903-2019",
    caption = "Data: https://github.com/alastairrushworth/tdf"
  )+
  theme_minimal()+
  theme(
    plot.title = element_text(family = font, size = 28, face = "bold", color = "#222222"),
    plot.subtitle = element_text(family = font, size = 22, margin = margin(9,0,0,0)),
    plot.caption = element_text(family = font, color = "#cbcbcb"),
    axis.text = element_text(family = font, size = 18),
    axis.text.x = element_text(margin = margin(5, b = 10)), 
    axis.ticks = element_blank(),
    axis.line = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major.y = element_line(color = "#cbcbcb"),
    panel.grid.major.x = element_blank(),
    panel.background = element_blank(),
    #strip.background = element_rect(fill="white"),
    axis.title.x=element_blank(),
    axis.title.y = element_blank()
  )
  
p1
ggsave(here::here("2020-04-07-tour/figs", "distance_by_year.png"), plot = p1, height = (450/72), width = (650/72), units = "in")

