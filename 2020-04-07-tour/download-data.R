#Download and save data:
library(here)
library(tidyverse)
tdf_winners <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-04-07/tdf_winners.csv')
tdf_winners %>% write_csv(here::here("2020-04-07-tour/data", "tdf.csv"))
