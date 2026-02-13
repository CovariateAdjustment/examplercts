# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1056/NEJMoa1111103

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

indo_rct <-
  medicaldata::indo_rct %>%
  as.data.frame %>%
  dplyr::mutate(
    gender =
      factor(
        x = gender,
        levels = c("1_female", "2_male"),
        labels = c("0. Female", "1. Male")
      ),
    rx =
      factor(
        x = rx,
        levels = c("0_placebo", "1_indomethacin"),
        labels = c("0. Placebo", "1. Indomethacin")
      ),
    tx =
      dplyr::case_when(
        rx %in% "1. Indomethacin" ~ 1,
        rx %in% "0. Placebo" ~ 0
      ),
    pep =
      factor(
        x = pep,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    recpanc =
      factor(
        x = recpanc,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    psphinc =
      factor(
        x = psphinc ,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    precut =
      factor(
        x = precut,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    difcan =
      factor(
        x = difcan,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    pneudil =
      factor(
        x = pneudil,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    amp =
      factor(
        x = amp,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    paninj =
      factor(
        x = paninj,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    asa =
      factor(
        x = asa,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    pdstent =
      factor(
        x = pdstent,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    sodsom =
      factor(
        x = sodsom,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    bsphinc =
      factor(
        x = bsphinc,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    train =
      factor(
        x = train,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    status =
      factor(
        x = status,
        levels = c("0_inpatient", "1_outpatient"),
        labels = c("0. Inpatient", "1. Outpatient")
      ),
    type =
      factor(
        x = type,
        levels = c("0_no SOD", "1_type 1", "2_type 2", "3_type 3"),
        labels = c("0. No SOD", "1. Type 1", "2. Type 2", "3. Type 3")
      ),
    outcome =
      factor(
        x = outcome,
        levels = c("0_no", "1_yes"),
        labels = c("0. No", "1. Yes")
      ),
    pep_binary =
      dplyr::case_when(
        outcome == "1. Yes" ~ 1,
        outcome == "0. No" ~ 0
      )
  ) %>%
  dplyr::select(
    participant_id = id,
    arm = rx, tx,
    age, gender,
    previous_pep_bl = pep,
    pancreatitis_bl = recpanc,
    p_sphincterotmy_bl = psphinc,
    sphincter_precut_bl = precut,
    difficult_cannulation_bl = difcan,
    pneumatic_dilation_bl = pneudil,
    ampullectomy_bl = amp,
    injected_contrast_bl = paninj,
    aspirin_any_bl = asa,
    any_p_duct_stent_bl = pdstent,
    oddi_manometry_bl = sodsom,
    b_sphincterotmy_bl = bsphinc,
    trainee_bl = train,
    is_outpatient_bl = status,
    oddi_dysfunction_bl = type,
    pep = outcome,
    pep_binary
  )

labelled::var_label(indo_rct$participant_id) <- "Participant ID"
labelled::var_label(indo_rct$arm) <- "Study Arm"
labelled::var_label(indo_rct$tx) <- "Treatment Indicator"
labelled::var_label(indo_rct$age) <- "Age at Baseline"
labelled::var_label(indo_rct$gender) <- "Gender"
labelled::var_label(indo_rct$previous_pep_bl) <- "Previous PEP (BL)"
labelled::var_label(indo_rct$pancreatitis_bl) <- "Recurrent Pancreatitis (BL)"
labelled::var_label(indo_rct$p_sphincterotmy_bl) <- "Pancreatic Sphincterotomy (BL)"
labelled::var_label(indo_rct$sphincter_precut_bl) <- "Sphincter Pre-cut Needed (BL)"
labelled::var_label(indo_rct$difficult_cannulation_bl) <- "Difficult Cannulation of Papilla (BL)"
labelled::var_label(indo_rct$pneumatic_dilation_bl) <- "Pneumatic Dilation of Papilla (BL)"
labelled::var_label(indo_rct$ampullectomy_bl) <- "Ampullectomy Performed(BL)"
labelled::var_label(indo_rct$injected_contrast_bl) <- "Contrast Injected (BL)"
labelled::var_label(indo_rct$aspirin_any_bl) <- "Any Aspirin Use (BL)"
labelled::var_label(indo_rct$any_p_duct_stent_bl) <- "Pancreatic Duct Stent Used (BL)"
labelled::var_label(indo_rct$oddi_manometry_bl) <- "Sphicter of Oddi Manometry (BL)"
labelled::var_label(indo_rct$b_sphincterotmy_bl) <- "Biliary Sphincterotomy (BL)"
labelled::var_label(indo_rct$trainee_bl) <- "Trainee Involved in ERCP(BL)"
labelled::var_label(indo_rct$is_outpatient_bl) <- "Outpatient Status (BL)"
labelled::var_label(indo_rct$oddi_dysfunction_bl) <- "Sphincter of Oddi Dysfunction (BL)"
labelled::var_label(indo_rct$pep) <- "Post-ERCP Pancreatitis"
labelled::var_label(indo_rct$pep_binary) <- "Post-ERCP Pancreatitis"

data <- indo_rct <- as.data.frame(indo_rct)
data_name <- "indo_rct"
indo_rct_codebook <- quick_codebook(indo_rct)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(indo_rct, overwrite = TRUE)

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
    "`indo_rct`: Indomethicin vs. Placebo for Post-ERCP Pancreatitis (PEP)",
    "",
    "This is a randomized controlled trial conducted from 2009 to 2011 of 602 ",
    "individuals, evaluating the efficacy of indomethicin for prevention of ",
    "Post-ERCP Pancreatitis (Elmunzer et al. 2012).",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Elmunzer, B. Joseph, James M. Scheiman, Glen A. Lehman, Amitabh Chak, ",
    "Patrick Mosler, Peter D. R. Higgins, Rodney A. Hayward, et al. 2012. ",
    "\"A Randomized Trial of Rectal Indomethacin to Prevent Post-ERCP ",
    "Pancreatitis.\" New England Journal of Medicine 366 (15): 1414–22. ",
    "https://doi.org/10.1056/nejmoa1111103.",
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


data.r_text_old

writeLines(
  text = c(data.r_text_old, "\n\n\n", paste(data.r_text, collapse = "\n")),
  con = data.r_path
)
