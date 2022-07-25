######################################################################################################################################################
######

rm(list = ls())
options(scipen = 999)
gc()

library(ggplot2)
library(magrittr)

googlesheets4::gs4_get(email = "thomasjbrailey@gmail.com")

# file paths
fp_main <- here::here()
fp_data <- paste0(fp_main, "/data")
fp_code <- paste0(fp_main, "/code")

# read data 
df_acled        <- read.csv(paste0(fp_data, "/acled_conflict_africa_1997_2022.csv"))

vec_ss    <- "https://docs.google.com/spreadsheets/d/1SQsSwuNcle_i1laXZmtxNutgi5VH27WF/edit#gid=96111818"
vec_years <- c(1997:2022)

df_acled_manual <- sapply(X = seq_along(vec_years), FUN = function(x) googlesheets4::read_sheet(ss = vec_ss, sheet = vec_years[x]))

######################################################################################################################################################
###### read scripts

source(paste0(fp_code, "/dat_prep_acled_for_manual_edits.R"))

source(paste0(fp_code, "/dat_acled_manual_edits_check.R"))
