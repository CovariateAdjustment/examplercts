# Clear old `data.R`
data.r_path <- file.path(here::here(), "R", "data.R")

if(file.exists(data.r_path)){
  file.remove(data.r_path)
}

data_raw_dir <- file.path(here::here(), "data-raw")
all_scripts <- list.files(path = data_raw_dir)
all_data_scripts <-
  stringr::str_subset(string = all_scripts, pattern = "^\\d{2}_")

for(i in 1:length(all_data_scripts)){
  callr::rscript(
    script = file.path(data_raw_dir, all_data_scripts[i])
  )
}
