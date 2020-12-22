#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from https://www.openicpsr.org/openicpsr/project/116438/version/V1/view
# Author: Kar Hian Ong
# Date: 16 December 2020
# Contact: kar.ong@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the dta file and saved it to "data" folder
# - Angelucci_Cage_AEJMicro_dataset.dta need to be in the Data folder
# - Create a folder called "cleaned data" in outputs folder
# - Don't forget to gitignore it!

library(haven)
library(tidyverse)
newspapers <- read_dta("Data/Angelucci_Cage_AEJMicro_dataset.dta")
newspapers <- 
  newspapers %>% 
  dplyr::select(year, id_news, after_national, local, national, # Diff in diff variables
                ra_cst, qtotal, ads_p4_cst, ads_s, # Advertising side dependents
                ps_cst, po_cst, qtotal, qs_s, rs_cst #Reader side dependents
                ,nb_journ) %>% 
  mutate(ra_cst_div_qtotal = ra_cst / qtotal) %>% # An advertising side dependents needs to be built
  mutate_at(vars(id_news, after_national, local, national), ~as.factor(.)) %>% # Change some to factors
  mutate(year = as.integer(year))

write.csv(newspapers,"Outputs/Cleaned data/newspaper_clean.csv")
