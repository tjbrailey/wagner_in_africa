
library(magrittr)

# file paths
fp_main <- here::here()
fp_data <- paste0(fp_main, "/data")

# read data 
df <- read.csv(paste0(fp_data, "/acled_conflict_africa_1997_2022.csv"))

df_sub <- 
  df %>% 
  dplyr::select(data_id, year, country, dplyr::contains("actor")) %>% 
  as.data.frame(.)

df_dataframes <- split(df_sub, df_sub$year)

# create workbook
obj_wb <- openxlsx::createWorkbook()

#Iterate the same way as PavoDive, slightly different (creating an anonymous function inside Map())
Map(function(vec_data, vec_nameofsheet){     
  
  openxlsx::addWorksheet(obj_wb, vec_nameofsheet)
  openxlsx::writeData(obj_wb, vec_nameofsheet, vec_data)
  
}, df_dataframes, names(df_dataframes))

## Save workbook to excel file 
openxlsx::saveWorkbook(obj_wb, file = paste0(fp_data, "/acled_by_year.xlsx"), overwrite = TRUE)
