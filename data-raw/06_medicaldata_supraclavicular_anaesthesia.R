# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1097/AAP.0b013e31820d4235

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

supraclavicular <-
  medicaldata::supraclavicular %>%
  dplyr::mutate(
    group =
      factor(
        x = group,
        levels = c(1, 2),
        labels = c("0. Mixture", "1. Sequential"),
      ),
    tx =
      dplyr::case_when(
        group == "0. Mixture" ~ 0,
        group == "1. Sequential" ~ 1,
      ),
    gender =
      factor(
        x = gender,
        levels = c(0, 1),
        labels = c("0. Female", "1. Male"),
      ),
    nerve_block_censor_copy = nerve_block_censor,
    nerve_block_censor_f =
      factor(
        x = nerve_block_censor,
        levels = c(1, 0),
        labels = c("0. Block Failed", "1. Block Achieved")
      ),
    nerve_block_censor =
      dplyr::case_when(
        nerve_block_censor_f == "0. Block Failed" ~ 0,
        nerve_block_censor_f == "1. Block Achieved" ~ 1,
      ),
    med_censor_copy = med_censor,
    med_censor_f =
      factor(
        x = med_censor,
        levels = c(1, 0),
        labels = c("0. No Medication Requested", "1. Requested Medication")
      ),
    med_censor =
      dplyr::case_when(
        med_censor_f == "0. No Medication Requested" ~ 0,
        med_censor_f == "1. Requested Medication" ~ 1,
      )
  ) %>%
  dplyr::select(
    participant_id = subject,
    age_bl = age,
    gender,
    bmi_bl = bmi,
    arm = group,
    tx,
    fentanyl_intraop = fentanyl,
    alfentanil_intraop = alfentanil,
    midazolam_intraop = midazolam,
    time_4_nerve_block = onset_sensory,
    time_1st_nerve_block = onset_first_sensory,
    nerve_block_achieved = nerve_block_censor,
    nerve_block_achieved_f = nerve_block_censor_f,
    time_complete_motor_block = onset_motor,
    time_block_to_meds = med_duration,
    meds_requested = med_censor,
    meds_requested_f = med_censor_f,
    max_postop_pain_rest = vps_rest,
    max_postop_pain_movement = vps_movement,
    total_opioids = opioid_total
  )

labelled::var_label(supraclavicular$participant_id) <- "Participant ID"
labelled::var_label(supraclavicular$age_bl) <- "Age at Baseline (BL)"
labelled::var_label(supraclavicular$gender) <- "Gender (BL)"
labelled::var_label(supraclavicular$bmi_bl) <- "Body Mass Index - kg/m^2 (BL)"
labelled::var_label(supraclavicular$arm) <- "Study Arm"
labelled::var_label(supraclavicular$tx) <- "Treatment Indicator"
labelled::var_label(supraclavicular$fentanyl_intraop) <- "Intraoperative Fentanyl (ug)"
labelled::var_label(supraclavicular$alfentanil_intraop) <- "Intraoperative Alfentanyl (mg)"
labelled::var_label(supraclavicular$midazolam_intraop) <- "Intraoperative Midazolam (mg)"
labelled::var_label(supraclavicular$time_4_nerve_block) <- "Time: 4-Nerve Sensory Block (m)"
labelled::var_label(supraclavicular$time_1st_nerve_block) <- "Time: 1st Sensory Block (m)"
labelled::var_label(supraclavicular$nerve_block_achieved) <- "Achieve Sensory+Motor Block"
labelled::var_label(supraclavicular$nerve_block_achieved_f) <- "Achieve Sensory+Motor Block"
labelled::var_label(supraclavicular$time_complete_motor_block) <- "Time: Complete Motor Block (m)"
labelled::var_label(supraclavicular$time_block_to_meds) <- "Time: Nerve Block to Meds Requested (h)"
labelled::var_label(supraclavicular$meds_requested) <- "Analgesia Requested 2d Post-op"
labelled::var_label(supraclavicular$meds_requested_f) <- "Analgesia Requested 2d Post-op"
labelled::var_label(supraclavicular$max_postop_pain_rest) <- "Max Postop Verbal Pain (0-10): Rest"
labelled::var_label(supraclavicular$max_postop_pain_movement) <- "Max Postop Verbal Pain (0-10): Movement"
labelled::var_label(supraclavicular$total_opioids) <- "Total Opioids (mg)"

data <- supraclavicular <- as.data.frame(supraclavicular)
data_name <- "supraclavicular"
supraclavicular_codebook <- quick_codebook(supraclavicular)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(supraclavicular, overwrite = TRUE)

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
    "`supraclavicular`: Combined vs. Sequential Administration of ",
    "Supraclavicular Anaesthesia",
    "",
    "This is a randomized controlled trial conducted from 2009 to 2011 of 545 ",
    "individuals, evaluating the efficacy of botulinium toxin B for cervical ",
    "dystonia (Brashear et al. 1999).",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Roberman, Dmitry, Harendra Arora, Daniel I. Sessler, Michael Ritchey, ",
    "Jing You, and Priya Kumar. 2011. \"Combined Versus Sequential Injection ",
    "of Mepivacaine and Ropivacaine for Supraclavicular Nerve Blocks.\" ",
    "Regional Anesthesia and Pain Medicine 36 (2): 145–50.",
    "https://doi.org/10.1097/aap.0b013e31820d4235. ",
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
