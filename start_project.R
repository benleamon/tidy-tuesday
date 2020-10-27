#Setup
library(lubridate)

#Get this Tuesday 
i = wday(Sys.Date(), week_start = 1)
this_tuesday <- Sys.Date() + (2 - i) 

#Ask user for date, set default to this Tuesday:
project_date <- readline(prompt = "Project Date (default is this Tuesday): ")
if (project_date == "") {
  project_date = this_tuesday
} else {project_date = project_date
}

#Ask user for name of dataset
project_name <- readline(prompt = "Name: ")

# Clean project name
clean_name <- str_to_title(str_replace(project_name, "-", " "))

#Create new week folder
if(project_name != ""){
  folder <- paste0(project_date,"-",project_name)
} else {
  folder <- paste0(project_date)
}
dir.create(file.path(folder), recursive = TRUE)

# Create folder for figures to publish
dir.create(file.path(paste0(folder,"/","figs")))

# Create folder for data
#dir.create(file.path(paste0(folder,"/","data")))

#Create Rmarkdown file
script_file <- paste0(folder, "/", project_name, "-", "analysis.rmd")
file.create(script_file)

# Ask if the user wants to add data-download code:
data_download <- readline(prompt = "Add download code? (y/n, default, y)")
if (data_download == "y" || data_download == "") {
  download_code <-  paste0(
    '```{r}',
    '\n',
    'tuesdata <- tidytuesdayR::tt_load("',
    project_date,
    '")',
    '\n',
    '```'
  )
} else {
  download_code <- ""
}

# Add default content to the script
script_text <- paste0(
  ## YAML heading 
  '---',
  '\n',
  'title: "',
  project_date,
  '-',
  project_name,
  '-analysis',
  '"',
  '\n',
  'author: "Ben Leamon"',
  '\n',
  'date: ',
  '"',
  Sys.Date(),
  '"',
  '\n',
  'output: html_document',
  '\n',
  '---',
  '\n\n',
  
  ## Setup chunk
  '```{r setup, include=FALSE}',
  '\n',
  'knitr::opts_chunk$set(echo = TRUE)',
  '\n',
  '```',
  '\n\n',
  '# ',
  project_date,
  ' Tidy Tuesday: ',
  clean_name,
  '\n',
  download_code,
  '\n',
  'proj_path <- "', 
  project_date,
  '-',
  project_name,
  '"'
  # This is where to add any more code we want in the new script.
)
write(as.character(script_text), file(script_file))

# Update current-script
current_script <- file("current-script.txt", "wt")
text <- paste0(project_date, "-" , project_name)
writeLines(text, current_script)
close(current_script)


# Open the file
file.edit(script_file)
