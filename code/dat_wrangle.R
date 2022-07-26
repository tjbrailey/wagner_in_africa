######################################################################################################################################################
######

df_world_map <- dplyr::mutate(df_world_map, country = countrycode::countryname(sourcevar = name))

sf::sf_use_s2(FALSE)

df_origin_locations <- df_world_map %>%
  dplyr::select(name, country, geometry) %>% 
  dplyr::filter(!is.na(country)) %>%
  dplyr::mutate(
    centroid = sf::st_centroid(.),
    orig_lon = sf::st_coordinates(centroid)[,1],
    orig_lat = sf::st_coordinates(centroid)[,2]) %>%
  dplyr::rename(actor1_location = country) %>% 
  tibble::as_tibble(.) %>% 
  dplyr::select(-name, -geometry, -centroid)

df_acled_final <- df_acled_manual %>%
  dplyr::select(data_id, dplyr::contains("location")) %>%
  dplyr::left_join(., df_acled) %>%
  dplyr::left_join(., df_origin_locations, by = "actor1_location") %>% 
  #sf::st_as_sf(.) %>% 
  dplyr::mutate(latitude = as.numeric(latitude),
                longitude = as.numeric(longitude))
