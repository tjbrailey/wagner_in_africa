######################################################################################################################################################
###### confirm that each manually edited google sheet has been coded correctly

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

