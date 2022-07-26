######################################################################################################################################################
###### confirm that each sheet has been coded correctly

# make sure we haven't missed anything (all outputs should be numeric(0))
# go to the corresponding output row to resolve any issues

which(is.na(df_acled_manual$actor1) != is.na(df_acled_manual$actor1_location)) + 1
which(is.na(df_acled_manual$actor2) != is.na(df_acled_manual$actor2_location)) + 1
which(is.na(df_acled_manual$assoc_actor_1) != is.na(df_acled_manual$assoc_actor_1_location)) + 1
which(is.na(df_acled_manual$assoc_actor_2) != is.na(df_acled_manual$assoc_actor_2_location)) + 1

# create country list
vec_acled_country <- unique(countrycode::codelist$country.name.en)
vec_acled_country <- c(vec_acled_country, "International")
vec_acled_country <- gsub(x = vec_acled_country, pattern = "Congo - Kinshasa", replacement = "Democratic Republic of Congo")
vec_acled_country <- gsub(x = vec_acled_country, pattern = "Congo - Brazzaville", replacement = "Republic of Congo")
vec_acled_country <- gsub(x = vec_acled_country, pattern = "Côte d’Ivoire", replacement = "Ivory Coast")
vec_acled_country <- gsub(x = vec_acled_country, pattern = "Eswatini", replacement = "eSwatini")

# ensure that each location input is a verified country (output should be numeric(0))
which(!df_acled_manual$actor1_location %in% c(vec_acled_country)) + 1
