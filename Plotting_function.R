# Load Required Libraries
#
# This section loads all necessary R packages required for the application to function correctly.
# Each package serves a specific purpose, ranging from creating the user interface to manipulating and visualizing data.

library(ggplot2) # A powerful and flexible package for creating static graphics, based on the grammar of graphics.  Used for generating various plot types (bar, scatter, boxplot).
library(dplyr) # A grammar of data manipulation, providing functions for data wrangling (filtering, selecting, mutating, summarizing).  Used for data cleaning, transformation, and aggregation.
library(readxl) # Used for reading data from Excel files (both .xls and .xlsx formats).  Allows the application to import data from Excel spreadsheets.
library(janitor) # Provides functions for cleaning and standardizing data, such as cleaning column names.  Enhances data consistency and usability.
library(RColorBrewer) # Offers pre-defined color palettes for visually appealing and informative plots.  Used for controlling plot aesthetics.
library(readr) # A fast and friendly way to read rectangular data (like CSV files). Provides efficient data input capabilities.
library(tidyr) # Helps to tidy messy datasets, making them easier to work with in R. Useful for restructuring data into a more usable format.
library(stringr) # Provides functions for working with strings (text data), such as trimming whitespace. Used for cleaning and standardizing text-based data.

# Custom Plotting Function (APA Style)
#
# This function, `CustomPlot`, generates customizable plots adhering to the American Psychological Association (APA) style guidelines.
# It encapsulates the logic for creating various plot types (bar charts, scatter plots, and box plots) with options for grouping, faceting,
# error bars, and different visual themes, all designed to meet APA standards for publication-quality figures.

CustomPlot <- function(data, x_var, y_var, group_var = NULL, error_type = "SE",
                       plot_type = "bar",
                       bar_width = 0.8, error_bar_width = 0.2,
                       x_label = NULL, y_label = "Value",
                       dodge_position = 0.9, point_size = 3,
                       facet_var = NULL,
                       font_size = 12,
                       theme_choice = "bw",
                       add_regression_line = FALSE) { # Added add_regression_line argument
  # Arguments:
  #data (data.frame): The input data frame.
  #x_var (character): The name of the column to use for the x-axis.
  #y_var (character): The name of the column to use for the y-axis.
  #group_var (character, optional): The name of the column to use for grouping. Defaults to NULL.
  #error_type (character, optional): The type of error bar to display ("SE" or "CI"). Defaults to "SE". Only used for bar plots.
  #plot_type (character, optional): The type of plot to generate ("bar", "scatter", or "boxplot"). Defaults to "bar".
  #bar_width (numeric, optional): The width of the bars in a bar chart. Defaults to 0.8.
  #error_bar_width (numeric, optional): The width of the error bars in a bar chart. Defaults to 0.2.
  #title (character, optional): The title of the plot. Defaults to "Custom Plot".
  #x_label (character, optional): The label for the x-axis. Defaults to NULL (uses x_var).
  #y_label (character): The label for the y-axis. Defaults to "Value".
  #dodge_position (numeric, optional): The position dodge value for grouped elements. Defaults to 0.9.
  #point_size (numeric, optional): The size of the points in a scatter plot. Defaults to 3.
  #facet_var (character, optional): The name of the column to use for faceting. Defaults to NULL.
  #font_size (numeric, optional): The font size for plot elements. Defaults to 12.
  #theme_choice (character, optional): The ggplot2 theme to use ("bw", "classic", or "dark"). Defaults to "bw".
  #add_regression_line (logical, optional): Whether to add a regression line to scatter plots. Defaults to FALSE.
  
  
  # Input Validation: Data Type Check
  # Ensures that the input `data` is a data frame, which is required for subsequent data manipulation and plotting operations.
  if (!is.data.frame(data)) {
    stop("Error: The input data must be a data frame.")
  }
  
  # Input Standardization: Variable Name Cleaning
  # Converts all variable names (x_var, y_var, group_var) to lowercase and replaces spaces with underscores.
  # This ensures consistency and avoids errors caused by case sensitivity or spaces in variable names.
  
  
  # Input Validation: Column Existence Check
  # Verifies that all specified column names (x_var, y_var, group_var, facet_var) exist in the input data frame.
  # This prevents errors that would occur if a non-existent column name were used in subsequent data operations.
  required_vars <- c(x_var, y_var)
  if (!is.null(group_var)) {
    required_vars <- c(required_vars, group_var)
  }
  if (!is.null(facet_var)) {
    required_vars <- c(required_vars, facet_var)
  }
  
  if (!all(required_vars %in% names(data))) {
    stop("Error: One or more specified columns do not exist in the data frame.")
  }
  
  # Data Cleaning: Handling Missing Values
  # Removes rows from the data frame where the value in the y_var column is missing (NA).
  # This ensures that missing values do not cause errors during plot generation or statistical calculations.
  data <- data %>% dplyr::filter(!is.na(.data[[y_var]]))
  if (nrow(data) == 0) {
    stop("Error: Dataset is empty after removing NA values in y_var.")
  }
  
  # Theme Definitions: APA Style Themes
  # Defines three custom ggplot2 themes ("bw", "classic", and "dark") that adhere to APA style guidelines.
  # Dark doesn't really but added it here just for fun
  # These themes control the overall visual appearance of the plots, including font, colors, and grid lines.
  # These themes are stored within the function for selection by the user via dropdown.
  
  # Define available ggplot2 themes WITH APA STYLE ELEMENTS INTEGRATED
  themeApa <- function(base_size = font_size, base_family = "serif") {
    ggplot2::theme_bw(base_size = base_size, base_family = base_family) +
      ggplot2::theme(
        text = ggplot2::element_text(size = base_size, family = base_family),
        plot.title = ggplot2::element_blank(), # REMOVE HEADING ELEMENT
        axis.title.x = ggplot2::element_text(face = "bold", family = base_family),
        axis.title.y = ggplot2::element_text(face = "bold", family = base_family),
        legend.position = "top",
        panel.border = ggplot2::element_rect(color = "black", fill = NA),
        legend.key = ggplot2::element_rect(fill = "white")
      )
  }
  
  themeClassicApa <- function(base_size = font_size, base_family = "serif") {
    ggplot2::theme_classic(base_size = base_size, base_family = base_family) +
      ggplot2::theme(
        text = ggplot2::element_text(size = base_size, family = base_family),
        plot.title = ggplot2::element_blank(), # REMOVE HEADING ELEMENT
        axis.title.x = ggplot2::element_text(face = "bold", family = base_family),
        axis.title.y = ggplot2::element_text(face = "bold", family = base_family),
        legend.position = "top",
        panel.border = ggplot2::element_rect(color = "black", fill = NA),
        legend.key = ggplot2::element_rect(fill = "white")
      )
  }
  
  themeDarkApa <- function(base_size = font_size, base_family = "serif") {
    ggplot2::theme_dark(base_size = base_size, base_family = base_family) +
      ggplot2::theme(
        text = ggplot2::element_text(size = base_size, family = base_family),
        plot.title = ggplot2::element_blank(), # REMOVE HEADING ELEMENT
        axis.title.x = ggplot2::element_text(face = "bold", family = base_family),
        axis.title.y = ggplot2::element_text(face = "bold", family = base_family),
        legend.position = "top",
        panel.border = ggplot2::element_rect(color = "white", fill = NA), # Use white border for dark theme
        legend.key = ggplot2::element_rect(fill = "black", color = "white")  # Adjust legend key for dark theme
      )
  }
  theme_options <- list(
    "classic" = themeClassicApa(font_size),
    "dark" = themeDarkApa(font_size),
    "bw" = themeApa(font_size)
  )
  
  # Plot Generation: Conditional Plot Type Logic
  # Uses an if-else structure to generate different plot types based on the value of the `plot_type` parameter.
  # This allows the function to create bar charts, scatter plots, or box plots based on user input.
  if (plot_type == "bar") {
    # Bar Chart Generation: Grouped or Ungrouped
    # Generates bar charts, either with or without grouping based on the presence of the `group_var` parameter.
    # Calculates summary statistics (mean, standard error, confidence interval) for each group, and creates the bar chart with error bars.
    if (!is.null(group_var)) {
      # Data Summarization: Grouped Data
      # Groups the data by the x_var and group_var columns, calculates the mean, standard error (SE), and confidence interval (CI) of the y_var for each group.
      # The results are stored in a summary_data data frame.
      summary_data <- data %>%
        dplyr::group_by(dplyr::across(dplyr::all_of(c(x_var, group_var)))) %>%
        dplyr::summarize(
          Mean = mean(.data[[y_var]], na.rm = TRUE),
          SE = sd(.data[[y_var]], na.rm = TRUE) / sqrt(dplyr::n()),
          CI = stats::qt(0.975, df = dplyr::n()-1) * (sd(.data[[y_var]], na.rm = TRUE) / sqrt(dplyr::n())),
          .groups = 'drop'
        )
      
      # Error Bar Type Selection: SE or CI
      # Sets the `error_col` variable based on the user's choice of error type (SE or CI).
      # This determines which column from the summary_data data frame will be used to plot the error bars.
      error_col <- ifelse(error_type == "SE", "SE", "CI")
      
      # ggplot Bar Chart: Grouped with Error Bars
      # Creates a bar chart using ggplot2, with the x-axis representing the x_var, the y-axis representing the mean, and the bars colored by the group_var.
      # Error bars are added to each bar, representing either the standard error or confidence interval.
      p <- ggplot2::ggplot(summary_data, aes(x = !!rlang::sym(x_var), y = Mean, fill = !!rlang::sym(group_var))) +
        ggplot2::geom_bar(stat = "identity", position = ggplot2::position_dodge(dodge_position), width = bar_width, color = "black") +
        ggplot2::geom_errorbar(aes(ymin = Mean - !!rlang::sym(error_col), ymax = Mean + !!rlang::sym(error_col)),
                               width = error_bar_width, position = ggplot2::position_dodge(dodge_position)) +
        theme_options[[theme_choice]]
      
    } else {
      # Data Summarization: Ungrouped Data
      # Groups the data by the x_var column, calculates the mean, standard error (SE), and confidence interval (CI) of the y_var for each group.
      # The results are stored in a summary_data data frame.
      summary_data <- data %>%
        dplyr::group_by(dplyr::across(dplyr::all_of(c(x_var)))) %>%
        dplyr::summarize(
          Mean = mean(.data[[y_var]], na.rm = TRUE),
          SE = sd(.data[[y_var]], na.rm = TRUE) / sqrt(dplyr::n()),
          CI = stats::qt(0.975, df = dplyr::n()-1) * (sd(.data[[y_var]], na.rm = TRUE) / sqrt(dplyr::n())),
          .groups = 'drop'
        )
      
      # Error Bar Type Selection: SE or CI
      # Sets the `error_col` variable based on the user's choice of error type (SE or CI).
      # This determines which column from the summary_data data frame will be used to plot the error bars.
      error_col <- ifelse(error_type == "SE", "SE", "CI")
      
      # ggplot Bar Chart: Ungrouped with Error Bars
      # Creates a bar chart using ggplot2, with the x-axis representing the x_var, the y-axis representing the mean.
      # Error bars are added to each bar, representing either the standard error or confidence interval.
      p <- ggplot2::ggplot(summary_data, aes(x = !!rlang::sym(x_var), y = Mean)) +
        ggplot2::geom_bar(stat = "identity", position = ggplot2::position_dodge(dodge_position), width = bar_width, color = "black") +
        ggplot2::geom_errorbar(aes(ymin = Mean - !!rlang::sym(error_col), ymax = Mean + !!rlang::sym(error_col)),
                               width = error_bar_width, position = ggplot2::position_dodge(dodge_position)) +
        theme_options[[theme_choice]]
    }
  } else if (plot_type == "scatter") {
    # Scatter Plot Generation: Grouped or Ungrouped
    # Generates scatter plots, either with or without grouping based on the presence of the `group_var` parameter.
    # Creates a scatter plot with points representing the relationship between the x_var and y_var.
    if (!is.null(group_var)) {
      # ggplot Scatter Plot: Grouped
      # Creates a scatter plot using ggplot2, with the x-axis representing the x_var, the y-axis representing the y_var, and the points colored by the group_var.
      p <- ggplot2::ggplot(data, aes(x = !!rlang::sym(x_var), y = !!rlang::sym(y_var), color = !!rlang::sym(group_var))) +
        ggplot2::geom_point(size = point_size, alpha = 0.7, shape = 16) +
        theme_options[[theme_choice]]
    } else {
      # ggplot Scatter Plot: Ungrouped
      # Creates a scatter plot using ggplot2, with the x-axis representing the x_var and the y-axis representing the y_var.
      p <- ggplot2::ggplot(data, aes(x = !!rlang::sym(x_var), y = !!rlang::sym(y_var))) +
        ggplot2::geom_point(size = point_size, alpha = 0.7, shape = 16) +
        theme_options[[theme_choice]]
    }
    # Adding regression line if specified
    if (add_regression_line) {
      p <- p + ggplot2::geom_smooth(method = "lm", se = FALSE, color = "red") # Example options
    }
  } else if (plot_type == "boxplot") {
    # Box Plot Generation: Grouped or Ungrouped
    # Generates box plots, either with or without grouping based on the presence of the `group_var` parameter.
    # Creates a box plot summarizing the distribution of the y_var for each group.
    if (!is.null(group_var)) {
      # ggplot Box Plot: Grouped
      # Creates a box plot using ggplot2, with the x-axis representing the x_var, the y-axis representing the y_var, and the boxes filled by the group_var.
      # Includes outliers, mean points, and other customization options.
      p <- ggplot2::ggplot(data, aes(x = !!rlang::sym(x_var), y = !!rlang::sym(y_var), fill = !!rlang::sym(group_var))) +
        ggplot2::geom_boxplot(outlier.colour = "black", outlier.shape = 1,
                              alpha = 0.7, width = 0.6, size = 0.5,
                              position = ggplot2::position_dodge(0.75)) +
        ggplot2::stat_summary(aes(group = !!rlang::sym(group_var)),  # Retain group_var in stat_summary
                              fun = mean, geom = "point", shape = 18, size = 3, color = "black",
                              position = ggplot2::position_dodge(0.75)) +
        ggplot2::guides(fill = ggplot2::guide_legend(override.aes = list(shape = NA))) +
        theme_options[[theme_choice]]
    } else {
      # ggplot Box Plot: Ungrouped
      # Creates a box plot using ggplot2, with the x-axis representing the x_var, the y-axis representing the y_var.
      p <- ggplot2::ggplot(data, aes(x = !!rlang::sym(x_var), y = !!rlang::sym(y_var))) +
        ggplot2::geom_boxplot(outlier.colour = "black", outlier.shape = 1,
                              alpha = 0.7, width = 0.6, size = 0.5,
                              position = ggplot2::position_dodge(0.75)) +
        ggplot2::stat_summary(aes(group = 1),  # Retain group_var in stat_summary
                              fun = mean, geom = "point", shape = 18, size = 3, color = "black",
                              position = position_dodge(0.75)) +
        theme_options[[theme_choice]]
    }
  } else {
    # Error Handling: Invalid Plot Type
    # Raises an error if the specified `plot_type` is not one of the allowed values ("bar", "scatter", or "boxplot").
    stop("Error: Invalid plot type. Choose 'bar', 'scatter', or 'boxplot'.")
  }
  
  # Faceting: Conditional Facet Wrap
  # If a `facet_var` is specified, facet the plot using `facet_wrap`.
  # Faceting creates separate subplots for each unique value in the facet_var column.
  if (!is.null(facet_var)) {
    p <- p + ggplot2::facet_wrap(vars(!!rlang::sym(facet_var)))
  }
  
  # Labels: Applying X and Y Axis Labels
  # Applies the specified x-axis and y-axis labels to the plot.
  # If no x-axis label is provided, the x_var column name is used as the label.
  p <- p +
    ggplot2::labs(x = x_label %||% x_var, y = y_label)
  
  # Legend: Removing Legend Title
  # Removes the legend title if a grouping variable is used, as APA style discourages legend titles.
  if (!is.null(group_var)) {
    p <- p + ggplot2::theme(legend.title = ggplot2::element_blank())
  }
  # Returns:
  #   ggplot: A ggplot object representing the generated plot.
  return(p)
  
}

