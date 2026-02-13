# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1213/ane.0b013e31822cf47d

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

laryngoscope <-
  medicaldata::laryngoscope %>%
  dplyr::mutate(
    participant_id = dplyr::row_number(),
    gender =
      factor(
        x = gender,
        levels = 0:1,
        labels = c("0. Female", "1. Male")
      ),
    asa =
      factor(
        x = asa,
        levels = c(1, 2, 3, 4),
        labels = c("1. I", "2. II", "3. III", "4. IV")
      ),
    Mallampati =
      factor(
        x = Mallampati,
        levels = 1:4,
        labels = c("1. 1", "2. 2", "3. 3", "4. 4")
      ),
    Randomization =
      factor(
        x = Randomization,
        levels = 0:1,
        labels = c("0. Macintosh", "1. Pentax AWS")
      ),
    tx =
      dplyr::case_when(
        Randomization %in% "0. Macintosh" ~ 0,
        Randomization %in% "1. Pentax AWS" ~ 1
      ),
    attempt_1_f =
      factor(
        x = attempt1_S_F,
        levels = 0:1,
        labels = c("0. Failure", "1. Success")
      ),
    attempt_2_f =
      factor(
        x = attempt2_S_F,
        levels = 0:1,
        labels = c("0. Failure", "1. Success")
      ),
    attempt_3_f =
      factor(
        x = attempt3_S_F,
        levels = 0:1,
        labels = c("0. Failure", "1. Success")
      ),
    sore_throat =
      dplyr::case_when(
        sore_throat %in% 0:1 ~ sore_throat,
        sore_throat %in% 2:3 ~ 2,
      ) %>%
      factor(
        x = .,
        levels = c(0, 1, 2),
        labels = c("0. None", "1. Mild", "2. Moderate/Severe"),
      ),
    view =
      factor(
        x = view,
        levels = c(0, 1),
        labels = c("0. Grade 1-2 (Not Good)", "0. Grade 3-4 (Good)")
      )
  ) %>%
  dplyr::select(
    participant_id, age_bl = age, gender,
    asa_physical_status_bl = asa,
    mallampati_bl = Mallampati,
    bmi_bl = BMI,
    arm = Randomization, tx,
    attempt_1_time = attempt1_time,
    attempt_1 = attempt1_S_F,
    attempt_1_f,
    attempt_2_time = attempt2_time,
    attempt_2 = attempt2_S_F,
    attempt_2_f,
    attempt_3_time = attempt3_time,
    attempt_3 = attempt3_S_F,
    attempt_3_f,
    attempts,
    failures,
    total_intubation_time,
    bleeding,
    difficulty = ease,
    sore_throat,
    glottic_view_grade = view
  )

labelled::var_label(laryngoscope$participant_id) <- "Participant ID"
labelled::var_label(laryngoscope$age_bl) <- "Age at Baseline"
labelled::var_label(laryngoscope$gender) <- "Gender"
labelled::var_label(laryngoscope$asa_physical_status_bl) <- "ASA Physical Status"
labelled::var_label(laryngoscope$bmi_bl) <- "Body Mass Index (kg/m^2)"
labelled::var_label(laryngoscope$mallampati_bl) <- "Mallampati Score (BL)"
labelled::var_label(laryngoscope$arm) <- "Study Arm"
labelled::var_label(laryngoscope$tx) <- "Treatment Indicator"
labelled::var_label(laryngoscope$attempt_1_time) <- "Attempt 1 Time (s)"
labelled::var_label(laryngoscope$attempt_1_f) <- "Attempt 1 Outcome"
labelled::var_label(laryngoscope$attempt_1) <- "Attempt 1 Outcome"
labelled::var_label(laryngoscope$attempt_2_time) <- "Attempt 2 Time (s)"
labelled::var_label(laryngoscope$attempt_2_f) <- "Attempt 2 Outcome"
labelled::var_label(laryngoscope$attempt_2) <- "Attempt 2 Outcome"
labelled::var_label(laryngoscope$attempt_3_time) <- "Attempt 3 Time (s)"
labelled::var_label(laryngoscope$attempt_3_f) <- "Attempt 3 Outcome"
labelled::var_label(laryngoscope$attempt_3) <- "Attempt 3 Outcome"
labelled::var_label(laryngoscope$attempts) <- "Intubation Attempts"
labelled::var_label(laryngoscope$failures) <- "Intubation Failures"
labelled::var_label(laryngoscope$total_intubation_time) <- "Total Intubation Time (s)"
labelled::var_label(laryngoscope$bleeding) <- "Post-Intubation Bleeding"
labelled::var_label(laryngoscope$difficulty) <- "Intubation Difficulty: Easy (0) - Difficult (100)"
labelled::var_label(laryngoscope$sore_throat) <- "Post-Intubation Sore Throat"
labelled::var_label(laryngoscope$glottic_view_grade) <- "Grade of Glottic View"

data <- laryngoscope <- as.data.frame(laryngoscope)
data_name <- "laryngoscope"
laryngoscope_codebook <- quick_codebook(laryngoscope)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(laryngoscope, overwrite = TRUE)

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
    "`laryngoscope`: Macintosh vs. Pentax Laryngoscope for Orotracheal Intubation",
    "",
    "This is a randomized controlled trial of 99 individuals, evaluating the ",
    "relative efficacy of two laryngoscope models for orotracheal intubation ",
    "in obese patients (Abdallah et al. 2011). ",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Abdallah, Rania, Ursula Galway, Jing You, Andrea Kurz, Daniel I. ",
    "Sessler, and D. John Doyle. 2011. \"A Randomized Comparison Between the ",
    "Pentax AWS Video Laryngoscope and the Macintosh Laryngoscope in Morbidly ",
    "Obese Patients.\" Anesthesia & Analgesia 113 (5): 1082–87. ",
    "https://doi.org/10.1213/ane.0b013e31822cf47d. ",
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
