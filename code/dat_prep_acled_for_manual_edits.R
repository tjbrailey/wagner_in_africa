######################################################################################################################################################
###### prepare acled dataset for manual edits


# for remaining NA values, do more regexing
df_acled_sub <- 
  df_acled %>% 
  dplyr::select(data_id, year, country, dplyr::contains("actor")) %>% 
  dplyr::mutate(
    actor1_location = stringr::str_match(string = actor1, pattern = paste(vec_acled_country, collapse = "|"))[,1],
    actor2_location = stringr::str_match(string = actor2, pattern = paste(vec_acled_country, collapse = "|"))[,1],
    assoc_actor_1_location = stringr::str_match(string = assoc_actor_1, pattern = paste(vec_acled_country, collapse = "|"))[,1],
    assoc_actor_2_location = stringr::str_match(string = assoc_actor_2, pattern = paste(vec_acled_country, collapse = "|"))[,1],
  ) %>% 
  dplyr::mutate(dplyr::across(dplyr::everything(), ~ ifelse(. == "character(0)", NA, .))) %>% 
  dplyr::select(data_id, country, year, actor1, assoc_actor_1, actor2, assoc_actor_2, actor1_location, assoc_actor_1_location, actor2_location, assoc_actor_2_location) %>%
  as.data.frame(.)

# split dataframe into separate frames by year
df_dataframes <- split(df_acled_sub, df_acled_sub$year)

# create workbook frame
obj_wb <- openxlsx::createWorkbook()

# iterate over each sub-dataframe, saving them as new sheets
Map(function(vec_data, vec_nameofsheet){     
  
  openxlsx::addWorksheet(obj_wb, vec_nameofsheet)
  openxlsx::writeData(obj_wb, vec_nameofsheet, vec_data)
}, 
df_dataframes, names(df_dataframes))

# save workbook to excel file 
openxlsx::saveWorkbook(obj_wb, file = paste0(fp_data, "/acled_by_year.xlsx"), overwrite = TRUE)

# next, upload this .xlsx file to google drive (THIS HAS BEEN DONE - DO NOT DO AGAIN)
