suppressMessages(library(tidyverse))
suppressMessages(library(ggplot2))
suppressMessages(library(scales))

args = commandArgs(trailingOnly = TRUE)
setwd(args[1])

data <- read_csv(args[2], col_types = 'dd') %>%
  mutate(Tilt = Tilt/180 - 0.5, Psi = Psi/180)

data %>%
  ggplot(aes(x = Psi, y = Tilt)) +
  theme_minimal() +
  geom_hex(binwidth = 0.04) +
  scale_fill_viridis_c(name = 'Number of images') +
  expand_limits(x = c(-1, 1), y = c(-0.5, 0.5)) +
  scale_y_continuous(breaks = c(-0.5, -0.25, 0, 0.25, 0.5)) +
  coord_fixed()
ggsave('linear_heatmap.png', width = 5, height = 3)

data %>%
  ggplot(aes(x = Psi, y = Tilt)) +
  theme_minimal() +
  geom_hex(binwidth = 0.04) +
  scale_fill_gradientn(colors = c("#00007F", "blue", "#007FFF", "cyan",
                                  "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"),
                       trans = 'log',
                       name = 'log(images)',
                       breaks = breaks_log()) +
  expand_limits(x = c(-1, 1), y = c(-0.5, 0.5)) +
  scale_y_continuous(breaks = c(-0.5, -0.25, 0, 0.25, 0.5)) +
  coord_fixed() +
  ggtitle('This emulates Jet. Don\'t use!')
ggsave('jet_heatmap.png', width = 5, height = 3)

data %>%
  ggplot(aes(x = Psi, y = Tilt)) +
  theme_minimal() +
  geom_hex(binwidth = 0.04) +
  scale_fill_viridis_c(trans = 'log', name = 'log(images)',
                       breaks = breaks_log()) +
  expand_limits(x = c(-1, 1), y = c(-0.5, 0.5)) +
  scale_y_continuous(breaks = c(-0.5, -0.25, 0, 0.25, 0.5)) +
  coord_fixed()
ggsave('log_heatmap.png', width = 5, height = 3)
