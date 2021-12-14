#================#
# FUNCTIONS
#================#

# Percentage Function
percentage_func <- function(x) {
  percentage <- ((x / sum(x)) *100)
  return(percentage)
}

# Pie Chart
pie_chart_func <- function(dataset, counts_var, var_interest, title, subtitle, caption) {
  ggplot(dataset, aes("", counts_var)) +
    geom_col(
      position = "fill",
      color = "black",
      width = 1,
      aes(fill = factor(var_interest))
    ) +
    geom_text(
      aes(label = str_c(round(percent), "%"), group = factor(var_interest)),
      position = position_fill(vjust = 0.5),
      color = "white",
      size = 6,
      show.legend = FALSE,
      fontface = "bold"
    ) +
    coord_polar(theta = "y") +
    theme_void() +
    theme_void() +
    labs(
      title = title,
      subtitle = subtitle,
      caption = caption,
      fill = ""
    )
}
