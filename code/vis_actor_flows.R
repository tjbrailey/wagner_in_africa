######################################################################################################################################################
###### plot maps of actor country of origin and conflict locations

plot_coo_conflict <- ggplot() + 
  geom_sf(data = df_world_map, fill = NA) + 
  geom_curve(
    data = df_acled_final, 
    color = "purple",
    alpha = 0.5, 
    curvature = 0.2,
    aes(
      x = orig_lon,
      y = orig_lat,
      xend = longitude,
      yend = latitude)) + 
  #coord_sf(xlim = c(-40, 60), ylim = c(-30, 70)) + 
  geom_point(
    data = df_acled_final, 
    mapping = aes(x = longitude, y = latitude), 
    color = "purple", 
    alpha = 0.5, show.legend = TRUE) +
  geom_point(
    data = df_acled_final, 
    mapping = aes(x = orig_lon,  y = orig_lat),
    color = "orange", 
    alpha = 0.5) + 
  labs(x = "", y = "", color = "Test") + 
  theme_minimal()
plot_coo_conflict
