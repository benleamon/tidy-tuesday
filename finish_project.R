# Setup
library(stringr)

# Get project name and date
name_date <- readLines("current-script.txt")

# Split name from date:
project_date <- str_sub(name_date, 1,10)
project_name <- str_sub(name_date, 12)

# Clean project name
clean_name <- str_to_title(str_replace(project_name, "-", " "))

# Get files in figs folder
figs_folder <- paste0(name_date, "/figs")
figs <- list.files(path = figs_folder)

# Create string to add to readme.md
## Title
readme_lines <- paste0("\n", "## ",project_date," ", clean_name)
## Links to figs
for (i in figs) {
  readme_lines <- c(readme_lines, 
                    paste0("![",clean_name," graph ",i,"](",name_date,"/figs/",i,")"))
}
## Link to code at end of figs 
readme_lines <- c(readme_lines, paste0("Code can be found [here](", name_date,")."))

# Read the current readme file
readme <- readLines("README.md")

#Last line of the heading (edit this if it gets longer)
heading_end <- 2

# Create the new readme file
new_readme <- c(readme[1:heading_end], readme_lines, readme[(heading_end + 1): length(readme)])

# Write lines: 
writeLines(new_readme, "README.md")

