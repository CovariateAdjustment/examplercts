# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1213/ANE.0b013e318299a650

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

licorice_gargle <-
  medicaldata::licorice_gargle %>%
  dplyr::mutate(
    participant_id = dplyr::row_number(),
    preOp_gender =
      factor(
        x = preOp_gender,
        levels = c(1, 0),
        labels = c("0. Female", "1. Male")
      ),
    preOp_asa =
      factor(
        x = preOp_asa,
        levels = c(1, 2, 3),
        labels = c("1. Healthy", "2. Mild Systemic Disease",
                   "3. Severe Systemic Disease")
      ),
    # Pool top levels of Mallampati Score
    preOp_mallampati =
      dplyr::case_when(
        preOp_mallampati %in% 1:3 ~ preOp_mallampati,
        preOp_mallampati == 4 ~ 3
      ) %>%
      factor(
        x = .,
        levels = 1:3,
        labels = c("1. 1", "2. 2", "3. 3+")
      ),
    preOp_smoking =
      factor(
        x = preOp_smoking,
        levels = 1:3,
        labels = c("1. Current Smoker", "2. Former Smoker", "3. Never Smoker")
      ),
    preOp_pain =
      factor(
        x = preOp_pain,
        levels = c(0, 1),
        labels = c("0. No", "1. Yes")
      ),
    treat =
      factor(
        x = treat,
        levels = c(0, 1),
        labels = c("0. 5g Sugar", "1. 0.5g Licorice")
      ),
    tx =
      dplyr::case_when(
        treat == "0. 5g Sugar" ~ 0,
        treat == "1. 0.5g Licorice" ~ 1
      ),
    intraOp_surgerySize =
      factor(
        x = intraOp_surgerySize,
        levels = 1:3,
        labels = c("1. Small", "2. Medium", "3. Large")
      ),
    extubation_cough =
      factor(
        x = extubation_cough,
        levels = 0:3,
        labels = c("0. No Cough", "1. Mild Cough", "2. Moderate Cough",
                   "3. Severe Cough")
      ),
    pacu30min_cough =
      factor(
        x = pacu30min_cough,
        levels = 0:3,
        labels = c("0. No Cough", "1. Mild Cough", "2. Moderate Cough",
                   "3. Severe Cough")
      ),
    pacu_30_min_any_throat_pain = 1*(pacu30min_throatPain > 0),
    pacu90min_cough =
      factor(
        x = pacu90min_cough,
        levels = 0:3,
        labels = c("0. No Cough", "1. Mild Cough", "2. Moderate Cough",
                   "3. Severe Cough")
      ),
    postOp4hour_cough =
      factor(
        x = postOp4hour_cough,
        levels = 0:3,
        labels = c("0. No Cough", "1. Mild Cough", "2. Moderate Cough",
                   "3. Severe Cough")
      ),
    pod1am_cough =
      factor(
        x = pod1am_cough,
        levels = 0:3,
        labels = c("0. No Cough", "1. Mild Cough", "2. Moderate Cough",
                   "3. Severe Cough")
      ),

    pacu_30_min_any_throat_pain = 1*(pacu30min_throatPain > 0),
    pacu_90_min_any_throat_pain = 1*(pacu90min_throatPain > 0),
    postop_4h_any_throat_pain = 1*(postOp4hour_throatPain > 0),
    postop_1d_am_any_throat_pain = 1*(pod1am_throatPain > 0)
  ) %>%
  dplyr::select(
    participant_id,
    age_bl = preOp_age,
    gender = preOp_gender,
    asa_physical_status_bl = preOp_asa,
    bmi_bl = preOp_calcBMI,
    mallampati_bl = preOp_mallampati,
    smoking_bl = preOp_smoking,
    pain_yn_bl = preOp_pain,
    arm = treat,
    tx,
    surgery_size_post_rnd = intraOp_surgerySize,
    extubation_cough,
    pacu_30_min_cough = pacu30min_cough,
    pacu_30_min_throat_pain = pacu30min_throatPain,
    pacu_30_min_any_throat_pain,
    pacu_30_min_swallow_pain = pacu30min_swallowPain,
    pacu_90_min_cough = pacu90min_cough,
    pacu_90_min_throat_pain = pacu90min_throatPain,
    pacu_90_min_any_throat_pain,
    postop_4h_cough = postOp4hour_cough,
    postop_4h_throat_pain = postOp4hour_throatPain,
    postop_4h_any_throat_pain,
    postop_1d_am_cough = pod1am_cough,
    postop_1d_am_throat_pain = pod1am_throatPain,
    postop_1d_am_any_throat_pain
  )

labelled::var_label(licorice_gargle$participant_id) <- "Participant ID"
labelled::var_label(licorice_gargle$age_bl) <- "Age at Baseline"
labelled::var_label(licorice_gargle$gender) <- "Gender"
labelled::var_label(licorice_gargle$asa_physical_status_bl) <- "ASA Physical Status"
labelled::var_label(licorice_gargle$bmi_bl) <- "Body Mass Index (kg/m^2)"
labelled::var_label(licorice_gargle$mallampati_bl) <- "Mallampati Score (BL)"
labelled::var_label(licorice_gargle$smoking_bl) <- "Smoking Status (BL)"
labelled::var_label(licorice_gargle$pain_yn_bl) <- "Preoperative Pain (BL)"
labelled::var_label(licorice_gargle$arm) <- "Study Arm"
labelled::var_label(licorice_gargle$tx) <- "Treatment Indicator"

labelled::var_label(licorice_gargle$surgery_size_post_rnd) <- "Surgery Size (Post-Randomization)"
labelled::var_label(licorice_gargle$extubation_cough) <- "Cough At Extubation"
labelled::var_label(licorice_gargle$pacu_30_min_cough) <- "Cough at PACU: 30 Minutes"
labelled::var_label(licorice_gargle$pacu_30_min_throat_pain) <- "Throat Pain at PACU: 30 Minutes"
labelled::var_label(licorice_gargle$pacu_30_min_any_throat_pain) <- "Any Throat Pain at PACU: 30 Minutes"
labelled::var_label(licorice_gargle$pacu_30_min_swallow_pain) <- "Swallow Pain at PACU: 30 Minutes"
labelled::var_label(licorice_gargle$pacu_90_min_cough) <- "Cough at PACU: 90 Minutes"
labelled::var_label(licorice_gargle$pacu_90_min_throat_pain) <- "Throat Pain at PACU: 90 Minutes"
labelled::var_label(licorice_gargle$pacu_90_min_any_throat_pain) <- "Any Throat Pain at PACU: 90 Minutes"
labelled::var_label(licorice_gargle$postop_4h_cough) <- "Cough: 4H Post-Op"
labelled::var_label(licorice_gargle$postop_4h_throat_pain) <- "Throat Pain: 4H Post-Op"
labelled::var_label(licorice_gargle$postop_4h_any_throat_pain) <- "Any Throat Pain: 4H Post-Op"
labelled::var_label(licorice_gargle$postop_1d_am_cough) <- "Cough: 1d Post-Op in AM"
labelled::var_label(licorice_gargle$postop_1d_am_throat_pain) <- "Throat Pain: 1d Post-Op in AM"
labelled::var_label(licorice_gargle$postop_1d_am_any_throat_pain) <- "Any Throat Pain: 1d Post-Op in AM"

data <- licorice_gargle <- as.data.frame(licorice_gargle)
data_name <- "licorice_gargle"
licorice_gargle_codebook <- quick_codebook(licorice_gargle)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(licorice_gargle, overwrite = TRUE)
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
    "`licorice_gargle`: Licorice Gargle vs. Sucrose for Management of ",
    "Endotracheal Intubation",
    "",
    "This is a randomized controlled trial, conducted from 2010 to 2011, ",
    "evaluating whether a licorice or sucrose gargle provided better ",
    "management of endotracheal tube extubation symptoms in 235 participants ",
    "(Ruetzler et al. 2013).",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Ruetzler, Kurt, Michael Fleck, Sabine Nabecker, Kristina Pinter, Gordian ",
    "Landskron, Andrea Lassnigg, Jing You, and Daniel I. Sessler. 2013. \"A ",
    "Randomized, Double-Blind Comparison of Licorice Versus Sugar-Water ",
    "Gargle for Prevention of Postoperative Sore Throat and Postextubation ",
    "Coughing.\" Anesthesia & Analgesia 117 (3): 614–21. ",
    "https://doi.org/10.1213/ane.0b013e318299a650. ",
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
