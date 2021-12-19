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


# Proportions features VS Attrition Function
bar_plot_proportions <- function(feature, target){
  
  varCat <- as_label(enquo(feature))
  varCat <- str_to_title(str_replace(varCat, "_", " "))
  
  if(missing(target)) {
    prop_data <- mydb %>%  
      group_by({{feature}}) %>% 
      summarise(n = n(), .groups = "drop") %>% 
      ungroup() %>% 
      mutate(percent = str_c(round(n/sum(n)*100,0),"%"),
             just = n/4,
             VarName = fct_reorder(factor({{feature}}), n ),
             label_hjust = case_when(
               n < quantile(n, probs = 0.85) ~ -0.2,
               TRUE ~ 1.1,
             ), 
             label_color = case_when(
               n < quantile(n, probs = 0.85) ~ "black",
               TRUE ~ "white",
             ))
    
    ggplot(prop_data, aes(x = VarName, y = n, fill = VarName)) +
      geom_col(width = 0.7,
               size = 1,
               show.legend = FALSE) +
      coord_flip() +
      geom_text(show.legend = FALSE,
                aes(y = n, label = str_c(percent,n, sep = " "), hjust = label_hjust,
                    color = label_color) ,
                size = 2.5
      ) +
      scale_y_continuous(expand = expansion(add = c(50, max(prop_data$just)))) +
      scale_fill_viridis_d(direction = -1) +
      scale_color_manual(values = c("black", "white")) +
      theme(
        legend.position = "right",
        plot.background = element_rect(colour = "gray"),
        plot.title.position = "panel",
        plot.title = element_text(size = 10, hjust = 0.5),
        plot.subtitle = element_text(size = 8),
        plot.caption.position = "plot",
        plot.caption = element_text(size = 6, color = "grey"),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 8)
      ) +
      labs(
        title = NULL,
        subtitle = NULL,
        x = NULL,
        y = NULL
      ) 
    
  } 
  else {
    
    prop_data <- mydb %>%  
      group_by({{feature}},{{target}}) %>% 
      summarise(n = n(), .groups = "drop") %>% 
      ungroup() %>% 
      mutate(percent = str_c(round(n/sum(n)*100,0),"%"),
             just = n/4,
             VarName = reorder_within(factor({{feature}}), n, {{target}}),
             label_hjust = case_when(
               n < quantile(n, probs = 0.85) ~ -0.2,
               TRUE ~ 1.1,
             ), 
             label_color = case_when(
               n < quantile(n, probs = 0.85) ~ "black",
               TRUE ~ "white",
             ))
    
    ggplot(prop_data, aes(x = VarName, y = n, fill = VarName)) +
      geom_col(width = 0.7,
               size = 1,
               show.legend = FALSE) +
      coord_flip() +
      geom_text(show.legend = FALSE,
                aes(y = n, label = str_c(percent,n, sep = " "), hjust = label_hjust,
                    color = label_color) ,
                size = 2.5
      ) +
      facet_wrap(vars({{target}}), scales = "free_y")+
      scale_y_continuous(expand = expansion(add = c(10, max(prop_data$just)))) +
      scale_x_reordered() +
      scale_fill_viridis_d(direction = -1) +
      scale_color_manual(values = c("black", "white")) +
      theme(
        legend.position = "right",
        strip.background = element_rect(fill = "#CD3B16"),
        strip.text = element_text(color = "white", face = "bold", size = 8),
        plot.background = element_rect(colour = "gray"),
        plot.title.position = "panel",
        plot.title = element_text(size = 10, hjust = 0.5),
        plot.subtitle = element_text(size = 8),
        plot.caption.position = "plot",
        plot.caption = element_text(size = 6, color = "grey"),
        panel.grid = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(size = 6)
      ) +
      labs(
        title = glue("{varCat} VS Attrition"),
        subtitle = NULL,
        x = NULL,
        y = NULL
      )
  }
  
}


# Plot using user defined function across numeric variables
across_features_num_x_plot <- function(x_var, section, subsection, y_var) {
  
  y_axis_label <- c("monthly_income" = "Monthly Income",
                    "monthly_rate" = "Monthly Rate",
                    "percent_salary_hike"= "Percent Salary Hike",
                    "training_times_last_year" = "Training Times Last Year",
                    "years_at_company" = "Years at Company",
                    "years_with_curr_manager" = "Years With Current Manager")[y_var]
  
  
  
  title_text   <- c("monthly_income" = "Monthly Income by ",
                    "monthly_rate" = "Monthly Rate by ",
                    "percent_salary_hike"= "Percent Salary Hike by ",
                    "training_times_last_year" = "Training Times Last Year by ",
                    "years_at_company" = "Years at Company by ",
                    "years_with_curr_manager" = "Years With Current Manager by ")[y_var]
  
  
  ggplot(mydb %>% filter((!!as.name(section)) == subsection),
         aes_string(x = x_var, y = y_var)) +
    geom_point(color = "#16529A") +
    geom_rug(color = "#0E8A41", sides = "lb", position = "jitter") +
    labs(
      title = str_glue(title_text,
                       str_to_title(str_replace_all(x_var, "_", " ")),
                       " (",
                       subsection,
                       " ",
                       str_to_title(str_replace_all(section, "_", " ")), " )"),
      x = NULL,
      y = NULL,
      fill = NULL
    )  +
    theme(plot.title.position = "plot",
          plot.title = element_text(
            hjust = 0,
            face = "bold",
            size = 13,
            color = "#000000"
          ))
  
}

# Plot using user defined function across catigorical variables
across_features_fact_x_plot <- function(x_var, section, subsection, y_var) {
  
  y_axis_label <- c("monthly_income" = "Monthly Income",
                    "monthly_rate" = "Monthly Rate",
                    "percent_salary_hike"= "Percent Salary Hike",
                    "training_times_last_year" = "Training Times Last Year",
                    "years_at_company" = "Years at Company",
                    "years_with_curr_manager" = "Years With Current Manager")[y_var]
  
  
  
  title_text   <- c("monthly_income" = "Monthly Income by ",
                    "monthly_rate" = "Monthly Rate by ",
                    "percent_salary_hike"= "Percent Salary Hike by ",
                    "training_times_last_year" = "Training Times Last Year by ",
                    "years_at_company" = "Years at Company by ",
                    "years_with_curr_manager" = "Years With Current Manager by ")[y_var]
  
  
  ggplot(mydb %>% filter((!!as.name(section)) == subsection),
         aes_string(x = x_var, y = y_var)) +
    geom_violin(color = "#16529A", fill = "#D3E8FB") +
    geom_dotplot(binaxis = "y", binwidth = 170,  stackdir = "center", color = "#F3C80D")+
    geom_rug(color = "#0E8A41", sides = "lb", position = "jitter") +
    labs(
      title = str_glue(title_text,
                       str_to_title(str_replace_all(x_var, "_", " ")),
                       " (",
                       subsection,
                       " ",
                       str_to_title(str_replace_all(section, "_", " ")), " )"),
      x = NULL,
      y = NULL,
      fill = NULL
    ) +
    theme(plot.title.position = "plot",
          plot.title = element_text(
            hjust = 0,
            face = "bold",
            size = 13,
            color = "#000000"
          ))
  
}

