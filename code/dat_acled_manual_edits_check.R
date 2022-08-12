######################################################################################################################################################
###### confirm that each manually edited google sheet has been coded correctly

# read googlesheet-stored datasets
vec_ss <- "https://docs.google.com/spreadsheets/d/1m1f2efMV61YMtlz1ugsQnPMCB0XLfIlMV1m_N8KGCbk/edit#gid=179470013" 
vec_years <- c(as.character(1997:2022))
vec_out <- NA

vec_acled_manual_checks <- lapply(X = seq_along(vec_years), FUN = function(x){
  
  df_acled_manual <- googlesheets4::read_sheet(ss = vec_ss, sheet = vec_years[x])
  vec_nrow_this_df <- nrow(df_acled_manual)
  
  vec_out[x] <-
    c(missing_1 = 1 - sum(is.na(df_acled_manual$actor1) != is.na(df_acled_manual$actor1_location))/vec_nrow_this_df,
      missing_2 = 1 - sum(is.na(df_acled_manual$actor2) != is.na(df_acled_manual$actor2_location))/vec_nrow_this_df,
      missing_3 = 1 - sum(is.na(df_acled_manual$assoc_actor_1) != is.na(df_acled_manual$assoc_actor_1_location))/vec_nrow_this_df,
      missing_4 = 1 - sum(is.na(df_acled_manual$assoc_actor_2) != is.na(df_acled_manual$assoc_actor_2_location))/vec_nrow_this_df,
      valid_1   = 1 - sum(!df_acled_manual$actor1_location %in% c(vec_acled_country))/vec_nrow_this_df,
      valid_2   = 1 - sum(!df_acled_manual$actor2_location[!is.na(df_acled_manual$actor2_location)] %in% c(vec_acled_country))/vec_nrow_this_df,
      valid_3   = 1 - sum(!df_acled_manual$assoc_actor_1_location[!is.na(df_acled_manual$assoc_actor_1_location)] %in% c(vec_acled_country))/vec_nrow_this_df,
      valid_4   = 1 - sum(!df_acled_manual$assoc_actor_2_location[!is.na(df_acled_manual$assoc_actor_2_location)] %in% c(vec_acled_country))/vec_nrow_this_df)
})

df_acled_manual_checks <- dplyr::bind_rows(vec_acled_manual_checks)

df_acled_manual_checks_long <-
  df_acled_manual_checks %>% 
  tidyr::pivot_longer(cols = dplyr::everything(), 
                      names_to = c(".value", "actor"),
                      names_pattern = c("(.*)_(.*)")) %>% 
  dplyr::mutate(
    actor = dplyr::case_when(
      actor == 1 ~ "Actor 1",
    actor == 2 ~ "Actor 2",
    actor == 3 ~ "Associate actor 1",
    actor == 4 ~ "Associate actor 2"
  ),
  year = as.numeric(rep(vec_years, each = 4))
  ) %>% 
  tidyr::pivot_longer(cols = c(missing, valid))

ggplot() +
  geom_line(
    data = df_acled_manual_checks_long, 
            mapping = aes(x = year, y = value, color = actor)) +
  labs(x = "Year", y = "Proportion completed", color = "") +
  facet_wrap(. ~ name, labeller = as_labeller(c("missing" = "Missing entries", 
                                                "valid" = "Entry appears in ACLED"))) + 
  theme_classic() + 
  theme(text = element_text(size = 18))

### primary checks

# make sure we haven't missed anything (all outputs should be numeric(0))
# go to the corresponding output row to resolve any issues
which(is.na(df_acled_manual$actor1) != is.na(df_acled_manual$actor1_location)) + 1

# ensure that each location input is a verified country (output should be numeric(0))
which(!df_acled_manual$actor1_location %in% c(vec_acled_country)) + 1

### secondary checks

which(is.na(df_acled_manual$actor2) != is.na(df_acled_manual$actor2_location)) + 1
which(is.na(df_acled_manual$assoc_actor_1) != is.na(df_acled_manual$assoc_actor_1_location)) + 1
which(is.na(df_acled_manual$assoc_actor_2) != is.na(df_acled_manual$assoc_actor_2_location)) + 1

which(!df_acled_manual$actor2_location[!is.na(df_acled_manual$actor2_location)] %in% c(vec_acled_country)) + 1
which(!df_acled_manual$assoc_actor_1_location[!is.na(df_acled_manual$assoc_actor_1_location)] %in% c(vec_acled_country)) + 1
which(!df_acled_manual$assoc_actor_2_location[!is.na(df_acled_manual$assoc_actor_2_location)] %in% c(vec_acled_country)) + 1


