library(tidyverse)

prisonsum <- read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-01-22/prison_summary.csv")

prisonsum %>%
  filter(!pop_category %in% c("Male", "Female", "Total", "Other")) %>%
  group_by(year) %>%
  mutate(percent = rate_per_100000/sum(rate_per_100000)) %>% 
  filter(year >= 1990) %>%
  ggplot(aes(year, percent, fill = pop_category)) +
  geom_area(stat = "identity", position = "fill") +
  facet_grid(rows = "urbanicity") +
  scale_fill_brewer(palette = "Set2") +
  scale_y_continuous(labels = scales::percent) + 
  labs(fill = "Race",
       y = "Proportion",
       x = "Year",
       title = "Proportion of Prison Population per 100,000 people",
       subtitle = "Cross Section by Race and Region",
       caption = "Data from: https://github.com/rfordatascience/tidytuesday/blob/master/data/2019/2019-01-22/prison_summary.csv")
  
ggsave("20190122_plot.png")
