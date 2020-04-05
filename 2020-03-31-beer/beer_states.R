#Load libraries
library(tidyverse)
library(scales)
library(here)
library(ggrepel)
library(hrbrthemes)
library(gcookbook)

#Import the data
beer_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-31/beer_states.csv')

#Save it to my computer
beer_states %>% write_csv(here::here("2020-03-31-beer/data", "beer_states_tidy.csv"))

#Import data to R
beer_states <- read_csv(here::here("2020-03-31-beer/data/beer_states_tidy.csv"))

#Convert years to date format
beer_states$year <- as.Date(paste(beer_states$year, 1, 1), '%Y %m %d')

#Remove the rows containing yearly totals, leaving only state data.
beer_states_no_totals <- beer_states %>%
  #select(state, barrels)
  filter(beer_states$state != "total")

#Calculate total production for each state by year, summing on premesis, in bottles and cans, and kegs and barrels. 
total_production_by_year <- beer_states_no_totals %>%
  group_by(state, year) %>%
  summarize(total = sum(barrels))

#Let's highlight only the top five producers in 2019. 
#Subset the data to only include 2019
total_2019 <-  subset(total_production_by_year, total_production_by_year$year == "2019-01-01")
#take the top 5
top2019 <- head(arrange(total_2019, desc(total)), n = 5)
#store that in a variable
interested <- top2019$state

p0 <- ggplot(total_production_by_year, aes(x = year, y = total))

#Draw the states we are not interested in, color them gray
p1 <- p0 + geom_line(data = subset(total_production_by_year, !(state %in% interested)),
                     aes(group = state),
                     alpha = 0.50,
                     color = "gray")

#Draw the states we are interested in. Ultimately labeling them got a bit messy. 
p2 <- p1 + 
  geom_line(data = subset(total_production_by_year, state %in% interested),aes(group=state, color = state))+
  scale_color_brewer(palette = "Dark2")
#geom_text_repel(data = subset(total_production_by_year, state %in% interested & year == "2019-01-01"),aes(label = state), size = 3)

#Format the scales, labels
p3 <- p2 +
  scale_y_continuous(
    labels = scales::label_comma()
  ) +
  scale_x_date(date_labels = "%Y")+
  labs(
    title = "Beer Production by State",
    subtitle = "Includes beer in bottles and cans, kegs and barrels, and beer kept on premesis",
    caption = "Data: https://www.ttb.gov/beer/statistics",
    x = NULL,
    y = "Barrels",
    color = "State"
  )+
  theme_ipsum()

p3

#Save the chart
ggsave(here::here("2020-03-31-beer/figs", "beer_states.png"), plot = p3, height = 8, width = 10)
