######################################################################################################################################################
###### The Destabilizing Effects of Foreign Paramilitaries in Africa

rm(list = ls())
options(scipen = 999)
gc()

library(ggplot2)
library(magrittr)

windowsFonts(font = windowsFont("Times New Roman"))

googlesheets4::gs4_deauth()

googlesheets4::gs4_auth(email = "thomasjbrailey@gmail.com")

# file paths
fp_main     <- here::here()
fp_data     <- paste0(fp_main, "/data")
fp_code     <- paste0(fp_main, "/code")
fp_exhibits <- paste0(fp_main, "/exhibits")
fp_tables   <- paste0(fp_exhibits, "/tables")
fp_figures  <- paste0(fp_exhibits, "/figures")

# read data 
df_acled     <- read.csv(paste0(fp_data, "/acled_conflict_africa_1997_2022.csv")) # raw acled data
df_world_map <- rnaturalearth::ne_countries(scale = "medium", type = "map_units", returnclass = "sf")

######################################################################################################################################################
###### wrangle data 

source(paste0(fp_code, "/dat_acled_manual_edits_check.R"))
source(paste0(fp_code, "/dat_wrangle.R"))

######################################################################################################################################################
###### read scripts

#source(paste0(fp_code, "/dat_prep_acled_for_manual_edits.R"))

source(paste0(fp_code, "/vis_acled_manual_edit_completion.R"))
source(paste0(fp_code, "/vis_actor_flows.R"))
