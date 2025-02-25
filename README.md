# D2MR Mini Project 2: Transpose to Quarto 

# LDR vs. GCR Relationship Study: Trust and Satisfaction Analysis

## Overview

This project investigates the relationships between trust and relationship satisfaction in long-distance romantic relationships (LDRRs) and geographically close relationships (GCRs). The analysis utilizes R for statistical computations and data visualization, and Quarto for document generation with APA formatting.

(I took a paper from my undergrad which was 1. incomplete and 2. had a lot of research loop holes and tried to format it according to APA in a .qmd file (so one thing out of the two is better). I have added all the necessary information down below!)

## Project Structure

*   `LDR_vs_GCR_paper.qmd`: The main Quarto document containing the narrative, R code for analysis, and figure/table generation.
*   `Plotting_function.R`: An R script containing custom plotting functions used in the analysis.
*   `bibliography.bib`: A BibTeX file storing the bibliographic references used in the document.
*   `cleaned_ldrgcr.xlsx`: The cleaned dataset used for the analysis.
*   `README.md`: This file, providing an overview of the project.
*   `_extensions/`: Directory where Quarto extensions (like `apaquarto`) are stored.
*   `LDR_vs_GCR_paper.PDF`: Final paper rendered from the .qmd file.
*   `unedited_LDR_vs_GCR_paper.PDF`: The unedited version with which I started.

## Dependencies

*   **R:** (Version 4.0 or higher is recommended) Required for statistical analysis and plot generation.
*   **Quarto:** (Version 1.3 or higher is recommended)  Required for document rendering.
*   **Pandoc:** (Version 2.11 or higher is recommended) Required for DOCX/PDF conversion.  Quarto generally manages Pandoc.
*   **R Packages:** The following R packages are used in the analysis. Install these packages using `install.packages()` in R:
    *   `tidyverse`: For data manipulation and visualization.
    *   `flextable`: For creating publication-quality tables (DOCX compatible).
    *   `knitr`: For dynamic report generation.
    *   `dplyr`: For data manipulation.
    *   `readr`: For reading and writing data files.
    *   `readxl`: For reading Excel files.
    *   `ggplot2`: For data visualization.
    *   `gridExtra`: For arranging multiple plots.
    *   `kableExtra`: For styling plots.
    *   `ftExtra`: For Additional features for flextable
    *   `car`: For regression diagnostics.
    *   `conflicted`: For resolving function conflicts.
*   **Quarto Extensions:**
    *   `wjschne/apaquarto`: An extension to format Quarto documents according to APA style guidelines.

## Setup and Installation

1.  **Install R:** Download and install R from [https://www.r-project.org/](https://www.r-project.org/).
2.  **Install RStudio (Recommended):** Download and install RStudio Desktop from [https://www.rstudio.com/products/rstudio/download/](https://www.rstudio.com/products/rstudio/download/).
3.  **Install Quarto:** Download and install Quarto from [https://quarto.org/docs/get-started/](https://quarto.org/docs/get-started/).
4.  **Install R Packages:** Open R or RStudio and run the following code to install the required R packages:

    ```R
    install.packages(c("tidyverse", "flextable", "knitr", "dplyr", "readr", "readxl",
                         "ggplot2", "kableExtrat",  "gridExtra", "car", "conflicted"
                         "ftExtra"))
    ```

5.  **Install `apaquarto` Quarto Extension:**
    ```bash
    quarto extensions install wjschne/apaquarto
    ```

## Usage

1.  **Clone the Repository:** Clone this repository to your local machine.
2.  **Open the Project:** Open the `LDR_vs_GCR_paper.qmd` file in RStudio or a text editor.
3.  **Render the Document:** Use the Quarto CLI to render the document to the desired output format (PDF, HTML).

    *   **Render to PDF (APA Style):**
        ```bash
        quarto render LDR_vs_GCR_paper.qmd --to pdf
        ```

    *   **Render to HTML:**
        ```bash
        quarto render LDR_vs_GCR_paper.qmd --to html
        ```

    The output file (`LDR_vs_GCR_paper.docx`, `LDR_vs_GCR_paper.pdf`, or `LDR_vs_GCR_paper.html`) will be created in the same directory as the `.qmd` file.

## Data

The data for this study is stored in `cleaned_ldrgcr.xlsx`. This file contains the cleaned and preprocessed data used for the statistical analysis.  The dataset includes variables related to demographics, relationship characteristics, trust scores (TCRS), and relationship satisfaction scores (RAS).

## Analysis

The analysis is performed using R code embedded within the `LDR_vs_GCR_paper.qmd` file. Key analyses include:

*   **Descriptive Statistics:** Calculating means, standard deviations, etc.
*   **Independent Samples t-tests:** Comparing mean trust and relationship satisfaction scores between LDR and GCR groups.
*   **Correlation Analysis:** Examining the relationships between trust components and relationship satisfaction.
*   **Two-Way ANOVA:**  Investigating the effects of relationship type and relationship duration on trust and satisfaction.
*   **Data Visualizations:**  Creating bar plots, scatter plots, and boxplots to visualize the data and results.

## Troubleshooting

*   **Missing Packages:** If you encounter errors related to missing R packages, make sure you have installed all the required packages using `install.packages()`.
*   **Pandoc Issues:** If you encounter errors related to DOCX or PDF rendering, make sure you have a recent version of Pandoc installed and that it's in your system's PATH. Quarto usually handles this.
*   **`apaquarto` Errors:** If you encounter errors related to the `apaquarto` extension, try updating the extension or simplifying your figure and table captions. Check the apaquarto documentation for more information on APA style and the settings needed for quarto.  Be sure that figure cross-references are working.
*   **Character encoding issues:** Excel and R may sometimes cause problems.  Be sure that column headers do not contain special characters.

## Contact

Aditi Joshi - [aditij@uchicago.edu]

## Acknowledgements

I would like to thank my supervisors, Ms. Nikita Srivastava and Ms. Manjari Sarathe for their unwavering support, patience, encouragement, passion, and immense knowledge. Their expertise was paramount in generating a structure for the paper as well as identifying the key research techniques undertaken in the paper. Without their help, the final product would have been extremely lacking. Aside from my supervisors, I'd like to thank everyone who took part in the study and contributed to making the research process run smoothly.
