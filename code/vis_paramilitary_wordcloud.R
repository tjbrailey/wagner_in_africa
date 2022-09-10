
vec_paramilitary_words <- df_paramilitary$`paramilitary group name`

vec_paramilitary_words

vec_paramilitary_words_clean <- gsub("https\\S*", "", vec_paramilitary_words) 
vec_paramilitary_words_clean <- gsub("@\\S*", "", vec_paramilitary_words_clean) 
vec_paramilitary_words_clean <- gsub("amp", "", vec_paramilitary_words_clean) 
vec_paramilitary_words_clean <- gsub("[\r\n]", "", vec_paramilitary_words_clean)
vec_paramilitary_words_clean <- gsub("[[:punct:]]", "", vec_paramilitary_words_clean)
vec_paramilitary_words_clean <- gsub("–", " ", vec_paramilitary_words_clean)

df_paramilitary_words_clean <- 
  vec_paramilitary_words_clean %>%
  tibble::as_tibble(.) %>%
  dplyr::mutate(words = strsplit(as.character(value), " ")) %>% 
  tidyr::unnest(words) %>% 
  dplyr::group_by(words) %>%
  dplyr::filter(words != "") %>%
  dplyr::summarise(count = dplyr::n()) %>% 
  dplyr::arrange(desc(count))
df_paramilitary_words_clean

plot_wordcloud <- wordcloud2::wordcloud2(
  df_paramilitary_words_clean, shuffle = FALSE, fontFamily = "Times",
  minRotation = 0, maxRotation = 0)
plot_wordcloud

htmlwidgets::saveWidget(widget = plot_wordcloud, file = paste0(fp_figures, "/vis_wordcloud.html"), selfcontained = FALSE)

webshot::webshot(url = paste0(fp_figures, "/vis_wordcloud.html"), 
                 file = paste0(fp_figures, "/vis_wordcloud.pdf"), 
                 delay = 5, 
                 vwidth = 20000, vheight = 20000)


