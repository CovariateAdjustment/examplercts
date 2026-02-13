# Publication DOI: 10.2307/2334539
# Kalbfleisch & Prentice (2002) cite Prentice (1973). No citation is made to the
# trial itself, only an attribution listed below:
# "The author would like to thank the Veterans Administration Lung Cancer Study
# Group for permission to use their data."

library(dplyr)
library(here)
library(labelled)
library(stringr)
library(survival)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

lung_cancer <-
  survival::veteran %>%
  dplyr::mutate(
    participant_id = dplyr::row_number(),
    trt =
      factor(
        x = trt,
        levels = c("1", "2"),
        labels = c("0. Standard Care", "1. Chemotherapy")
      ),
    tx =
      dplyr::case_when(
        trt == "0. Standard Care" ~ 0,
        trt == "1. Chemotherapy" ~ 1
      ),
    prior =
      factor(
        x = prior,
        levels = c(0, 10),
        labels = c("0. No", "1. Yes")
      ),
    celltype =
      factor(
        x = as.character(celltype),
        levels = c("squamous", "smallcell", "adeno", "large"),
        labels =
          c("1. Squamous Cell", "2. Small Cell", "3. Adenocarcinoma",
            "4. Large Cell")
      )
  ) %>%
  dplyr::select(
    participant_id,
    age_bl = age,
    cell_type_bl = celltype,
    karnofsky_bl = karno,
    time_from_dx_bl = diagtime,
    arm = trt,
    tx,
    time_to_event = time,
    event = status
  )

labelled::var_label(lung_cancer$participant_id) <- "Participant ID"
labelled::var_label(lung_cancer$age_bl) <- "Age (BL)"
labelled::var_label(lung_cancer$cell_type_bl) <- "Tumor Cell Type (BL)"
labelled::var_label(lung_cancer$karnofsky_bl) <- "Karnofsky Performance Score (BL)"
labelled::var_label(lung_cancer$time_from_dx_bl) <- "Time: Diagnosis to Randomization (BL)"
labelled::var_label(lung_cancer$arm) <- "Study Arm"
labelled::var_label(lung_cancer$tx) <- "Treatment Indicator"
labelled::var_label(lung_cancer$event) <- "Death On Study"
labelled::var_label(lung_cancer$time_to_event) <- "Time to Death On Study (d)"

data <- lung_cancer <- as.data.frame(lung_cancer)
data_name <- "lung_cancer"
lung_cancer_codebook <- quick_codebook(lung_cancer)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(lung_cancer, overwrite = TRUE)

data.r_path <- file.path(here::here(), "R", "data.R")
if(!file.exists(data.r_path)){
  file.create(data.r_path)
  data.r_text_old <- NULL
} else {
  data.r_text_old <-
    readLines(con = data.r_path)
}

data.r_text <-
  c(
    "`lung_cancer`: Veteran’s Administration Lung Cancer Trial",
    "",
    "This is a randomized controlled trial conducted by the Veteran’s ",
    "Administration Lung Cancer group, comparing survival among 137 ",
    "participants randomized to two treatment regimens.",
    "",
    "This data was originally sourced from the `survival` package ",
    "(Therneau 2026), and modified to be ready to use.",
    "",
    "Prentice, R. L. 1973. \"Exponential Survivals with Censoring and ",
    "Explanatory Variables.\" Biometrika 60 (2): 279–88. ",
    "https://doi.org/10.1093/biomet/60.2.279. ",
    "",
    "Kalbfleisch, John D., and Ross L. Prentice. 2002. The Statistical ",
    "Analysis of Failure Time Data. Wiley Series in Probability and ",
    "Statistics. Wiley. https://doi.org/10.1002/9781118032985. ",
    "",
    "Therneau, Terry M. 2026. A Package for Survival Analysis in r. ",
    "https://CRAN.R-project.org/package=survival. ",
    "",
    paste0("@format ## `", data_name, "`"),
    paste0(
      "A data frame with ", nrow(data), " rows and ", ncol(data), " columns: "
    ),
    "\\describe{"
  )


data.r_text <-
  c(
    data.r_text,
    paste0("\\item{", colnames(data), "}{",
           do.call(what = c, args = labelled::var_label(data)), "}"),
    "}",
    "@source <https://cran.r-project.org/web/packages/survival/index.html>"
  )

data.r_text <- paste0("#' ", data.r_text)

data.r_text <- c(data.r_text, paste0("\"", data_name, "\""))

writeLines(
  text = c(data.r_text_old, "\n\n\n", paste(data.r_text, collapse = "\n")),
  con = data.r_path
)

