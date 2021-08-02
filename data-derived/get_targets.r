#get the target distribution from the cluster
#this is done by running the correct weights.r and weights.sh script
#the target distribution should be specified based on the correct reference files
library(tidyverse)
#read in the target.csv from local directory
target54 <- read_csv("target54.csv")
target20 <- read_csv("target20.csv")
target55 <- read_csv("target55.csv")

#save the target
usethis::use_data(target54)
usethis::use_data(target20,overwrite=TRUE)
usethis::use_data(target55,overwrite=TRUE)
