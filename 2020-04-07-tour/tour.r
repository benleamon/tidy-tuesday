#Load libraries
library(tidyverse)
library(here)
library(lubridate)
library(cowplot)
library(ggtext)



#Import data
tdf <- read_csv(here::here("2020-04-07-tour/data/tdf.csv"))

#lower <- format("1920-06-27", "%y-%m-%d")
ww1s <- "1915-01-01"

tdf_data <- tdf %>% mutate(
  year = year(start_date),
  n = row_number()
)

#Distance by year
p <- ggplot(data = tdf_data)
p1 <- p+ geom_area(data = filter(tdf_data, year < 1915), aes(x = n, y = distance)) +
  geom_area(data = filter(tdf_data, year >1918 & year < 1945), aes(x = n, y = distance)) + 
  #geom_line()+
  #geom_point() +
  geom_text(aes(x = n, y = 0,label = winner_name)) +
  scale_x_reverse()+
  coord_flip(clip = "off") 
  #scale_y_continuous(expand = expansion(add = 10))
  

p1
# p2 <- p + geom_text(aes(x = n, y = 0,label = winner_name))+
#   scale_x_reverse()+
#   coord_flip()+
#   theme_void()
# 
# plot_grid(p2, p1)


