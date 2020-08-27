library(tidyverse)
library(ggplot2)

data <- read_csv('out.csv', col_types = 'dd') %>% 
  mutate(Tilt = Tilt/180 - 0.5, Psi = Psi/180)

data %>% 
  ggplot(aes(x = Psi, y = Tilt)) +
  theme_minimal() +
  geom_hex(binwidth = 0.04) +
  scale_fill_viridis_c() +
  expand_limits(x = c(-1, 1), y = c(-0.5, 0.5)) +
  scale_y_continuous(breaks = c(-0.5, -0.25, 0, 0.25, 0.5)) +
  coord_fixed()
ggsave('linear_heatmap.png', width = 5, height = 3)

data %>% 
  ggplot(aes(x = Psi, y = Tilt)) +
  theme_minimal() +
  geom_hex(binwidth = 0.04) +
  scale_fill_viridis_c(trans = 'log') +
  expand_limits(x = c(-1, 1), y = c(-0.5, 0.5)) +
  scale_y_continuous(breaks = c(-0.5, -0.25, 0, 0.25, 0.5)) +
  coord_fixed()
ggsave('log_heatmap.png', width = 5, height = 3)
