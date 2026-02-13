# NOTE: Use the version of `medicaldata` on Github, not CRAN
# devtools::install_github(repo = "https://higgi13425.github.io/medicaldata/")

# Publication DOI: 10.1056/nejmoa062249

library(dplyr)
library(here)
library(labelled)
library(medicaldata)
library(stringr)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

perio_pregnancy <-
  medicaldata::opt %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::where(fn = is.factor),
      .fns = as.character
    ),
    dplyr::across(
      .cols = dplyr::where(fn = is.character),
      .fns = stringr::str_squish
    ),
    dplyr::across(
      .cols = dplyr::where(fn = is.character),
      .fns = function(y) replace(x = y, list = y == "", values = NA)
    ),
    Education =
      factor(
        x = Education,
        levels = c("LT 8 yrs", "8-12 yrs", "MT 12 yrs"),
        labels = c("1. Less than 8 years ", "2. 8-12 years ", "3. More than 12 years")
      ),
    Public.Asstce =
      factor(
        x = Public.Asstce,
        levels = c("No", "Yes"),
        labels = c("0. No", "1. Yes")
      ),
    Hypertension =
      factor(
        x = Hypertension,
        levels = c("N", "Y"),
        labels = c("0. No", "1. Yes")
      ),
    Diabetes =
      factor(
        x = Diabetes,
        levels = c("No", "Yes"),
        labels = c("0. No", "1. Yes")
      ),
    BL.Diab.Type =
      dplyr::case_when(
        Diabetes == "0. No" ~ "0. No Diabetes",
        BL.Diab.Type == "Type I" ~ "1. Type I Diabetes",
        BL.Diab.Type == "Type II" ~ "2. Type II Diabetes"
      ) %>%
      factor(),
    Use.Tob =
      factor(
        x = Use.Tob,
        levels = c("No", "Yes"),
        labels = c("0. No", "1. Yes")
      ),
    Prev.preg =
      factor(
        x = Prev.preg,
        levels = c("No", "Yes"),
        labels = c("0. No", "1. Yes")
      ),
    Live.PTB =
      case_when(
        Prev.preg == "0. No" ~ "NA. No Previous Pregnancy",
        Live.PTB == "No" ~ "0. No",
        Live.PTB == "Yes" ~ "1. Yes",
      ) %>%
      factor(),
    Any.stillbirth =
      case_when(
        Prev.preg == "0. No" ~ "NA. No Previous Pregnancy",
        Any.stillbirth == "No" ~ "0. No",
        Any.stillbirth == "Yes" ~ "1. Yes",
      ) %>%
      factor(),
    Spont.ab =
      case_when(
        Prev.preg == "0. No" ~ "NA. No Previous Pregnancy",
        Spont.ab == "No" ~ "0. No",
        Spont.ab == "Yes" ~ "1. Yes",
      ) %>%
      factor(),
    Induced.ab =
      case_when(
        Prev.preg == "0. No" ~ "NA. No Previous Pregnancy",
        Induced.ab == "No" ~ "0. No",
        Induced.ab == "Yes" ~ "1. Yes",
      ) %>%
      factor(),
    Any.live.ptb.sb.sp.ab.in.ab =
      case_when(
        Prev.preg == "0. No" ~ "NA. No Previous Pregnancy",
        Any.live.ptb.sb.sp.ab.in.ab == "No" ~ "0. No",
        Any.live.ptb.sb.sp.ab.in.ab == "Yes" ~ "1. Yes",
      ) %>%
      factor(),
    Group =
      factor(
        x = Group,
        levels = c("C", "T"),
        labels = c("0. Control (Exams)", "1. Treatment (Therapy)"),
      ),
    tx =
      dplyr::case_when(
        Group == "0. Control (Exams)" ~ 0,
        Group == "1. Treatment (Therapy)" ~ 1,
      ),
    low_birthweight = 1*(Birthweight < 2500),
    birthweight_category =
      dplyr::case_when(
        Birthweight < 1500 ~ "1. Very Low Birthweight",
        Birthweight < 2500 ~ "2. Low Birthweight",
        Birthweight >= 2500 ~ "3. Normal Birthweight",
      ) %>%
      factor()
  ) %>%
  dplyr::select(
    participant_id = PID,
    age_bl = Age,
    education_bl = Education,
    public_assistance_bl = Public.Asstce,
    hypertension_bl = Hypertension,
    diabetes_bl = Diabetes,
    diabetes_type_bl = BL.Diab.Type,
    bmi_bl = BMI,
    tobacco_use_bl = Use.Tob,
    previous_pregnancy_bl = Prev.preg,
    previous_live_preterm_bl = Live.PTB,
    previous_stillbirth_bl = Any.stillbirth,
    previous_spontaneous_abortion = Spont.ab,
    previous_induced_abortion = Induced.ab,
    any_lptb_sb_sa_ia_bl = Any.live.ptb.sb.sp.ab.in.ab,
    site = Clinic,
    arm = Group,
    tx,
    birth_outcome = Birth.outcome,
    birthweight = Birthweight,
    low_birthweight,
    birthweight_category,
    gestational_age = GA.at.outcome,
    apgar_1_min = Apgar1,
    apgar_5_min = Apgar5
  )

labelled::var_label(perio_pregnancy$participant_id) <- "Participant ID"
labelled::var_label(perio_pregnancy$age_bl) <- "Mother's Age (BL)"
labelled::var_label(perio_pregnancy$education_bl) <- "Education (BL)"
labelled::var_label(perio_pregnancy$public_assistance_bl) <- "On Public Assistance (BL)"
labelled::var_label(perio_pregnancy$hypertension_bl) <- "Hypertension (BL)"
labelled::var_label(perio_pregnancy$diabetes_bl) <- "Any Diabetes (BL)"
labelled::var_label(perio_pregnancy$diabetes_type_bl) <- "Diabetes Type (BL)"
labelled::var_label(perio_pregnancy$bmi_bl) <- "Body Mass Index - kg/m^2 (BL)"
labelled::var_label(perio_pregnancy$tobacco_use_bl) <- "Tobacco Use (BL)"
labelled::var_label(perio_pregnancy$previous_pregnancy_bl) <- "Previous Pregnancy (BL)"
labelled::var_label(perio_pregnancy$previous_live_preterm_bl) <- "Previous Live Preterm Birth (BL)"
labelled::var_label(perio_pregnancy$previous_stillbirth_bl) <- "Previous Stillbirth (BL)"
labelled::var_label(perio_pregnancy$previous_spontaneous_abortion) <- "Previous Spontaneous Abortion (BL)"
labelled::var_label(perio_pregnancy$previous_induced_abortion) <- "Previous Induced Abortion (BL)"
labelled::var_label(perio_pregnancy$any_lptb_sb_sa_ia_bl) <- "Previous LPTB, SB, SA, or IA (BL)"
labelled::var_label(perio_pregnancy$site) <- "Study Site"
labelled::var_label(perio_pregnancy$arm) <- "Study Arm"
labelled::var_label(perio_pregnancy$tx) <- "Treatment Indicator"
labelled::var_label(perio_pregnancy$birth_outcome) <- "Birth Outcome"
labelled::var_label(perio_pregnancy$birthweight) <- "Birthweight at Outcome"
labelled::var_label(perio_pregnancy$low_birthweight) <- "Low Birthweight (<2500 g)"
labelled::var_label(perio_pregnancy$birthweight_category) <- "Birthweight Category"
labelled::var_label(perio_pregnancy$gestational_age) <- "Gestational Age at Outcome"
labelled::var_label(perio_pregnancy$apgar_1_min) <- "Apgar (1m)"
labelled::var_label(perio_pregnancy$apgar_5_min) <- "Apgar (5m)"

data <- perio_pregnancy <- as.data.frame(perio_pregnancy)
data_name <- "perio_pregnancy"
perio_pregnancy_codebook <- quick_codebook(perio_pregnancy)

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

usethis::use_data(perio_pregnancy, overwrite = TRUE)

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
    "`perio_pregnancy`: Maternal Periodontal Therapy and Pregnancy Outcomes",
    "",
    "This is a randomized controlled trial, conducted from 1984 to 2005, ",
    "evaluating whether maternal periodontic treatment 823 participants ",
    "(Michalowicz et al. 2006).",
    "",
    "This data was originally sourced from the ",
    "`medicaldata` package (Higgins 2022), and modified to be ready to use.",
    "",
    "Michalowicz, Bryan S., James S. Hodges, Anthony J. DiAngelis, Virginia ",
    "R. Lupo, M. John Novak, James E. Ferguson, William Buchanan, et al. ",
    "2006. \"Treatment of Periodontal Disease and the Risk of Preterm Birth.\"",
    "New England Journal of Medicine 355 (18): 1885–94. ",
    "https://doi.org/10.1056/nejmoa062249. ",
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
