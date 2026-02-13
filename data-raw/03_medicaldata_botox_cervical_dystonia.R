# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1212/wnl.53.7.1439

library(dplyr)
library(haven)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

# Make IDs unique; Make Factor Levels Descriptive
cdystonia <-
  medicaldata::cdystonia %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::where(fn = labelled::is.labelled),
      .fns = haven::as_factor
    )
  ) %>%
  dplyr::mutate(
    id = factor(x = paste0(site, ".", id)),
    sex =
      factor(
        x = sex,
        levels = c("F", "M"),
        labels = c("0. Female", "1. Male")
      ),
    treat =
      factor(
        x = as.character(treat),
        levels = c("Placebo", "5000U", "10000U"),
        labels = c("0. Placebo", "1. 5000U", "2. 10000U")
      ),
    tx =
      dplyr::case_when(
        treat == "0. Placebo" ~ 0,
        treat == "1. 5000U" ~ 1,
        treat == "2. 10000U" ~ 1,
      ),
  ) %>%
  as.data.frame() %>%
  dplyr::select(
    participant_id = id, site, week, age, sex, arm = treat, tx, twstrs
  )

# Ensure each ID has a record at each study visit
# Add baseline as a covariate
botox_dystonia <-
  dplyr::full_join(
    x =
      tidyr::expand_grid(
        cdystonia %>%
          dplyr::filter(
            week == 0
          ) %>%
          dplyr::select(
            participant_id, site, age, sex, arm, tx, twstrs_bl = twstrs
          ),
        week = c(2, 4, 8, 12, 16)
      ),
    y =
      cdystonia %>%
      dplyr::filter(week > 0) %>%
      dplyr::select(
        participant_id, week, twstrs
      ),
    by = c("participant_id", "week")
  )


labelled::var_label(botox_dystonia$participant_id) <- "Participant ID"
labelled::var_label(botox_dystonia$site) <- "Site ID"
labelled::var_label(botox_dystonia$age) <- "Age at Baseline"
labelled::var_label(botox_dystonia$sex) <- "Sex"
labelled::var_label(botox_dystonia$arm) <- "Study Arm"
labelled::var_label(botox_dystonia$tx) <- "Treatment Indicator"
labelled::var_label(botox_dystonia$twstrs_bl) <- "TWSTRS Total Score (BL)"
labelled::var_label(botox_dystonia$week) <- "Week Post Randomization"
labelled::var_label(botox_dystonia$twstrs) <- "TWSTRS Total Score - Followup"

data <- botox_dystonia <- as.data.frame(botox_dystonia)
data_name <- "botox_dystonia"
botox_dystonia_codebook <-
  quick_codebook(x = botox_dystonia, exclude_listing = "participant_id")

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(botox_dystonia, overwrite = TRUE)

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
    "`botox_dystonia`: Indomethicin vs. Placebo for Post-ERCP Pancreatitis (PEP)",
    "",
    "This is a randomized controlled trial conducted from 2009 to 2011 of 545 ",
    "individuals, evaluating the efficacy of botulinium toxin B for cervical ",
    "dystonia (Brashear et al. 1999).",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Brashear, A., M. F. Lew, D. D. Dykstra, C. L. Comella, S. A. Factor, ",
    "R. L. Rodnitzky, R. Trosch, et al. 1999. \"Safety and Efficacy of ",
    "NeuroBloc (Botulinum Toxin Type b) in Type a–Responsive Cervical ",
    "Dystonia.\" Neurology 53 (7): 1439–39. ",
    "https://doi.org/10.1212/wnl.53.7.1439. ",
    "",
    "Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.",
    "https://github.com/higgi13425/medicaldata.",
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
    "@source <https://github.com/higgi13425/medicaldata>"
  )

data.r_text <- paste0("#' ", data.r_text)

data.r_text <- c(data.r_text, paste0("\"", data_name, "\""))

writeLines(
  text = c(data.r_text_old, "\n\n\n", paste(data.r_text, collapse = "\n")),
  con = data.r_path
)
