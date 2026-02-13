# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1136/bmj.317.7167.1248b

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

strep_tb <-
  medicaldata::strep_tb %>%
  dplyr::mutate(
    arm =
      factor(
        x = arm,
        levels = c("Control", "Streptomycin"),
        labels = c("0. Control", "1. Streptomycin")
      ),
    tx =
      dplyr::case_when(
        arm %in% "1. Streptomycin" ~ 1,
        arm %in% "0. Control" ~ 0
      ),
    gender =
      factor(
        x = gender,
        levels = c("F", "M"),
        labels = c("0. Female", "1. Male")
      ),
    baseline_condition =
      factor(
        x = baseline_condition,
        levels = c("1_Good", "2_Fair", "3_Poor"),
        labels = c("1. Good", "2. Fair", "3. Poor")
      ),
    # Pool labels: Looks like some labels constructed incorrectly
    baseline_temp =
      case_when(
        baseline_temp %in% c("1_<=98.9F/37.2C") ~ "1. <=98.9F/37.2C",
        baseline_temp %in%
          c("2_99-99.9F/37.3-37.7C", "2_99-99.9F/37.3-37.7C/37.3-37.7C") ~
          "2. 99-99.9F/37.3-37.7C",
        baseline_temp %in%
          c("3_100-100.9F/37.8-38.2C", "3_100-100.9F/37.8-38.2C/37.8-38.2C") ~
          "3. 100-100.9F/37.8-38.2C",
        baseline_temp %in% c("4_>=101F/38.3C") ~ "4. >=101F/38.3C"
      ),
    baseline_temp =
      factor(
        x = baseline_temp
      ),
    baseline_esr =
      factor(
        x = baseline_esr,
        levels = c("2_11-20", "3_21-50", "4_51+"),
        labels = c("2. 11-20", "3. 21-50", "4. 51+")
      ),
    baseline_cavitation =
      factor(
        x = baseline_cavitation,
        levels = c("no", "yes"),
        labels = c("0. No", "1. Yes")
      ),
    strep_resistance =
      factor(
        x = strep_resistance,
        levels = c("1_sens_0-8", "2_mod_8-99", "3_resist_100+"),
        labels = c("1. 0-8: Sensitive", "2. 8-99: Moderate", "3. 100+: Resistant")
      ),
    radiologic_6m =
      factor(
        x = radiologic_6m,
        levels = c("1_Death", "2_Considerable_deterioration",
                   "3_Moderate_deterioration", "4_No_change",
                   "5_Moderate_improvement", "6_Considerable_improvement"),
        labels = c("1. Death", "2. Considerable Deterioration",
                   "3. Moderate Deterioration", "4. No Change",
                   "5. Moderate Improvement", "6. Considerable Improvement")
      ),

    improved_factor =
      factor(
        x = improved,
        levels = c(FALSE, TRUE),
        labels = c("0. Not Improved", "1. Improved")
      ),
    improved = 1*improved
  ) %>%
  dplyr::select(
    patient_id, arm, tx, gender,
    condition_bl = baseline_condition,
    temperature_bl = baseline_temp,
    sed_rate_esr_bl = baseline_esr,
    cxr_lung_cavitation_bl = baseline_cavitation,
    strep_resistance_6m = strep_resistance,
    radiologic_outcome_6m = radiologic_6m,
    chest_xray_rating_6m = rad_num,
    radiologic_improvement_6m = improved,
    radiologic_improvement_f_6m = improved_factor
  )

labelled::var_label(strep_tb$patient_id) <- "Participant ID"
labelled::var_label(strep_tb$arm) <- "Study Arm"
labelled::var_label(strep_tb$tx) <- "Treatment Indicator"
labelled::var_label(strep_tb$gender) <- "Gender"
labelled::var_label(strep_tb$condition_bl) <- "Condition (BL)"
labelled::var_label(strep_tb$temperature_bl) <- "Temperature  (BL)"
labelled::var_label(strep_tb$sed_rate_esr_bl) <- "ESR: Sedimentation Rate (BL)"
labelled::var_label(strep_tb$cxr_lung_cavitation_bl) <- "Lung Cavitation on X-Ray (BL)"
labelled::var_label(strep_tb$strep_resistance_6m) <- "Strep Resistance (6M)"
labelled::var_label(strep_tb$radiologic_outcome_6m) <- "Radiologic Outcome (6M)"
labelled::var_label(strep_tb$chest_xray_rating_6m) <- "Chest X-Ray Numeric Rating (6M)"
labelled::var_label(strep_tb$radiologic_improvement_6m) <- "Radiologic Improvement (6M)"
labelled::var_label(strep_tb$radiologic_improvement_f_6m) <- "Radiologic Improvement (6M)"

data <- strep_tb <- as.data.frame(strep_tb)
data_name <- "strep_tb"
strep_tb_codebook <- quick_codebook(strep_tb)


if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(strep_tb, overwrite = TRUE)

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
    "`strep_tb`: Streptomycin for Tuberculosis",
    "",
    "This is a randomized controlled trial of 107 individuals, evaluating the ",
    "efficacy of streptomycin for pulmonary tuberculosis, conducted in 1947 ",
    "(Medical Research Council 1998). Participants were randomized to receive ",
    "streptomycin and bed rest (treatment) or bed rest alone (control), and ",
    "followed up after six months.",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Medical Research Council. 1998. \"Streptomycin Treatment of Pulmonary",
    "Tuberculosis.\" Edited by British Medical Journal Publishing Group. ",
    "BMJ 317 (7167): 1248. https://doi.org/10.1136/bmj.317.7167.1248b.",
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
  text = paste(data.r_text, collapse = "\n"),
  con = data.r_path
)
