######################################################################################################################################################
######

df_acled_sub <- 
  df_acled %>% 
  dplyr::select(data_id, year, country, dplyr::contains("actor")) %>% 
  dplyr::mutate(
    actor1_location = as.character(stringr::str_match_all(string = actor1, pattern = "(?<=\\().+?(?=\\))")),
    actor2_location = as.character(stringr::str_match_all(string = actor2, pattern = "(?<=\\().+?(?=\\))")),
    assoc_actor_1_location = as.character(stringr::str_match_all(string = assoc_actor_1, pattern = "(?<=\\().+?(?=\\))")),
    assoc_actor_2_location = as.character(stringr::str_match_all(string = assoc_actor_2, pattern = "(?<=\\().+?(?=\\))"))) %>%
  dplyr::mutate(dplyr::across(dplyr::everything(), ~ ifelse(. == "character(0)", NA, .))) %>% 
  dplyr::select(data_id, country, year, actor1, assoc_actor_1, actor2, assoc_actor_2, actor1_location, assoc_actor_1_location, actor2_location, assoc_actor_2_location) %>%
  as.data.frame(.)

df_dataframes <- split(df_acled_sub, df_acled_sub$year)

# create workbook
obj_wb <- openxlsx::createWorkbook()

#Iterate the same way as PavoDive, slightly different (creating an anonymous function inside Map())
Map(function(vec_data, vec_nameofsheet){     
  
  openxlsx::addWorksheet(obj_wb, vec_nameofsheet)
  openxlsx::writeData(obj_wb, vec_nameofsheet, vec_data)
  
}, df_dataframes, names(df_dataframes))

## Save workbook to excel file 
openxlsx::saveWorkbook(obj_wb, file = paste0(fp_data, "/acled_by_year.xlsx"), overwrite = TRUE)

googlesheets4::gs4_create("acled_by_year", sheets = df_dataframes)
