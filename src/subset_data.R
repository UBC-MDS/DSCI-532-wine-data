library(tidyverse)
data <- read_csv("winemag_data_130k_v2.csv")
subset <- data[sample(nrow(data), 20000),]
write.csv(subset,"winemag_subset_20k.csv")
