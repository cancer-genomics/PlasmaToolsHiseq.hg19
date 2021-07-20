#get the bins from the cluster and aggregate them into one csv
#this code has to be run on the cluster only
#for now I'm getting it from rlucas but that's probably not a good idea
library(data.table); library(tidyverse); library(readxl)
library("plyr") 
library(devtools)
load_all("../rlucas")
valid_meta <- valid_meta[id != "PGDX18450P1"]
refids54 <- valid_meta[ref_panel==TRUE][,id]
refbins54 <- valid_bins5mb[id %in% refids54]
write_csv(refbins54,"refbins54.csv")

ref20_samples <- read.csv("ReferenceIDs_healthies_for_z_scores.csv")
ref20_samples <- ref20_samples %>% filter(!is.na(psomagen_submission))
refids20 <- ref20_samples$pgdx_id
refbins20 <- valid_bins5mb[id %in% refids20]
write_csv(refbins20,"refbins20.csv")

#read in the csv from local directory
ref54_bins <- read_csv("refbins54.csv")
ref20_bins <- read_csv("refbins20.csv")
#save the directory
usethis::use_data(ref54_bins)
usethis::use_data(ref20_bins)
