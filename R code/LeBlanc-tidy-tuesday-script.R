# tidytuesday / data / 2019 / 2019-03-12 /
# Board Games Database
library(tidyverse)
board_games <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-03-12/board_games.csv")

#### Description #####
# The data from this tidytuesda comes from Board Game Geek's (website) database. The dataset is limited to around 10K games, all with >/= 50 ratings, and made between 1950 and 2016. The original dataset has 90K games, but the smaller dataset will be used here. Ratings are on a 1 to 10 scale. I chose this dataset because I love board games, particularly Settlers of Catan (which I play at least once a week). 

# This tidytuesday comes linked to an article, which has some figures already included.
#### A ggplot ####
board_games
head(board_games)
str(board_games)

?filter
b_g_data <- filter(board_games, average_rating, playing_time <= 500, users_rated >= 1000)

ggplot(b_g_data, mapping = aes(
  x = playing_time, 
  y = average_rating)) + 
  geom_point(position = "jitter") +
  geom_smooth(se = FALSE) +
  labs(
    x = "Game Play Time (min)",
    y = "Average Game Rating",
    title = "The Relationship Between Game Play Time and Average Game Rating",
    subtitle = "Includes ratings and game play time for games with more than 1000 ratings and less than 500 minutes of playing time",
    caption = "Source: Board Game Geek, 2016") +
  theme_light()
ggsave("LeBlanc-BoardGame-Plot-Tidytues.pdf", width = 8, height = 10, units = "in")