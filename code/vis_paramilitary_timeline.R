
variable.names(df_paramilitary)

vec_current_year <- format(Sys.Date(), "%Y")

df_paramilitary %>% 
  dplyr::mutate(
    `year of breakup/ rename/ incorporation` = ifelse(`year of breakup/ rename/ incorporation` == "NA", vec_current_year, `year of breakup/ rename/ incorporation`),
    `year of breakup/ rename/ incorporation` = as.numeric(as.character(`year of breakup/ rename/ incorporation`))) %>%
  dplyr::filter(!is.na(`year of origin`) & !is.na(`year of breakup/ rename/ incorporation`)) %>% 
  dplyr::rename(start = `year of origin`,
                end   = `year of breakup/ rename/ incorporation`,
                param = `paramilitary group name`) %>% 
  ggplot() +
  geom_segment(mapping = aes(x = start, xend = end, y = param, yend = param, color = param), linetype = 1, size = 4) +
  theme_minimal() + 
  theme(legend.position = "none")

