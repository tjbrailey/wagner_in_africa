######################################################################################################################################################
######

# visualize
plot_acled_manual_edits <-
  ggplot() +
  geom_line(
    data = df_acled_manual_checks_long, 
    mapping = aes(
      x = year, 
      y = value, 
      #color = actor,
      linetype = actor), 
    size = 1, 
    alpha = 1) +
  scale_y_continuous(limits = c(0.5, 1.0)) + 
  labs(x = "Year", y = "Proportion completed", color = "") +
  facet_wrap(
    . ~ name, 
    labeller = as_labeller(
      c("missing" = "Missing entries", 
        "valid" = "Entry appears in ACLED"))) + 
  theme_classic() + 
  theme(text = element_text(size = 18),
        panel.grid.major.y = element_line())
plot_acled_manual_edits

ggsave(plot = plot_acled_manual_edits, file = paste0(fp_figures, "/vis_acled_manual_edit_completion.pdf"),
       device = cairo_pdf)