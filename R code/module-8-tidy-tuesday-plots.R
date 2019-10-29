################################################################################### PLOT 1 for MODULE 8 TidyTuesday 

library(tidyverse)
library(lubridate)

ramen_ratings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-04/ramen_ratings.csv")

##### Data Exploration ####

view(ramen_ratings)
head(ramen_ratings)

brand_count <- count(ramen_ratings, brand)
View(brand_count)

country_count <- count(ramen_ratings, country) %>%
  filter(n > 100)
country_count

style_count <- count(ramen_ratings, style)

#### Plot 1 ####

ramen_ratings %>%
  group_by(country) %>%
  summarise(stars = mean(stars, na.rm = TRUE),
            variety = n_distinct((variety))) %>%
  arrange(desc(variety)) %>%
  filter(variety > 100) -> ratings_by_country



ggplot(ratings_by_country,
       mapping = aes(x = reorder(country, variety),
                     y = variety)) +
  geom_bar(aes(fill = stars), 
           stat = "identity") +
  scale_fill_viridis_c(direction = -1, name = "Average Rating (0-5)", labels = c("0", "1", "2", "3", "4", "5")) +
  theme_minimal() +
  theme(legend.position = c(1, 0), legend.justification = c(1, 0)) +
  ylab("Number of Ramen Varieties") +
  xlab("Countries with more than 100 Ramen Varieties") +
  labs(title = "Number of Ramen Varieties per Country, Rated from 0 to 5") +
  coord_flip() +
  ggsave("module-8-plot-1.pdf")

#### Plot 2 ####

ramen_ratings %>%
  group_by(country, style) %>%
  summarise(stars = mean(stars, na.rm = TRUE),
            n = n()) %>%
  filter(style == "Bowl" | style == "Cup" | style == "Pack") ->style_country_stars

head(style_country_stars)
View(style_country_stars)
summary(style_country_stars)

style_country_stars %>%
  filter(n > 50) -> plot_2_data

ggplot(plot_2_data, mapping = aes(x = style, y = stars)) +
  geom_boxplot() +
  xlab("Ramen Style") +
  ylab("Ramen Rating") +
  geom_dotplot(aes(fill= country), 
               binaxis = 'y', 
               stackdir = 'center',
               dotsize = 0.05,
               binwidth = 1) +
  scale_fill_manual(
    values = c("yellowgreen", "yellow", "violetred1", "turquoise1", "tomato1", "snow3", "plum", "magenta", "lightblue", "navy", "red"),
    labels = c("China", "Hong Kong", "Indonesia", "Japan", "Malaysia", "Singapore", "South Korea", "Taiwan", "Thailand", "United States", "Vietnam"),
    name = "Country") +
  ggsave("module-8-plot-2.pdf")
