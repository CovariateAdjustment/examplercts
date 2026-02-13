# Publication DOI: Colon Cancer Data: DOI: 10.1056/NEJM199002083220602
# enrollment_end <- as.Date("1987-10-31")
# enrollment_start <- time2 = as.Date("1984-03-01")

library(dplyr)
library(here)
library(labelled)
library(mice)
library(stringr)
library(survival)
library(tidyr)

set.seed(12345)

source(file = file.path(here::here(), "data-raw", "quick_codebook.R"))
data_dir <- file.path(here::here(), "data")

colon_cancer <-
  survival::colon %>%
  dplyr::select(
    participant_id = id,
    arm = rx,
    age_bl = age,
    sex,
    obstruction_bl = obstruct,
    perforation_bl = perfor,
    organ_adherence_bl = adhere,
    positive_nodes_bl = nodes,
    differentiation_bl = differ,
    local_spread_bl = extent,
    time_surgery_registration_bl = surg,
    event = status,
    time_to = time,
    event_type = etype
  ) %>%
  # Contains Records for Recurrence, Death: Convert from Long to Wide
  tidyr::pivot_longer(
    cols = all_of(x = c("event", "time_to"))
  ) %>%
  dplyr::mutate(
    event_type =
      case_when(
        event_type == 1 ~ "recurrence",
        event_type == 2 ~ "death"
      )
  ) %>%
  tidyr::unite(
    col = name,
    name, event_type
  ) %>%
  tidyr::pivot_wider(
    names_from = name,
    values_from = value
  ) %>%
  # Label factor variables
  dplyr::mutate(
    across(
      .cols = c("obstruction_bl", "perforation_bl", "organ_adherence_bl"),
      .fns = function(x)
        factor(
          x = x,
          levels = 0:1,
          labels = c("0. No", "1. Yes"),
        )
    ),

    arm =
      factor(
        x = arm,
        levels = c("Obs", "Lev", "Lev+5FU"),
        labels = c("Obs", "0. Lev", "1. Lev+5FU")
      ),

    tx =
      dplyr::case_when(
        arm == "1. Lev+5FU" ~ 1,
        arm == "0. Lev" ~ 0,
        arm == "Obs" ~ 0
      ),

    sex =
      factor(
        x = sex,
        levels = 0:1,
        labels = c("0. Female", "1. Male"),
      ),

    differentiation_bl =
      factor(
        x = differentiation_bl,
        levels = 1:3,
        labels = c("1. Well", "2. Moderate", "3. Poor"),
      ),

    local_spread_bl =
      factor(
        x = local_spread_bl,
        levels = 1:4,
        labels =
          c("1. Submucosa", "2. Muscle",
            "3. Serosa", "4. Contiguous structures"),
      ),

    time_surgery_registration_bl =
      factor(
        x = time_surgery_registration_bl,
        levels = 0:1,
        labels =
          c("0. Short", "1. Long")
      ),

    years_to_death = time_to_death/365.25,
    years_to_recurrence = time_to_recurrence/365.25
  )


labelled::var_label(colon_cancer$participant_id) <- "Participant ID"
labelled::var_label(colon_cancer$age_bl) <- "Age (BL)"
labelled::var_label(colon_cancer$sex) <- "Sex (BL)"
labelled::var_label(colon_cancer$obstruction_bl) <- "Tumor Obstructs Colon (BL)"
labelled::var_label(colon_cancer$perforation_bl) <- "Tumor Perforates Colon (BL)"
labelled::var_label(colon_cancer$organ_adherence_bl) <- "Tumor Organ Adherence (BL)"
labelled::var_label(colon_cancer$positive_nodes_bl) <- "Lymph Nodes with Cancer (BL)"
labelled::var_label(colon_cancer$differentiation_bl) <- "Tumor Differentiation (BL)"
labelled::var_label(colon_cancer$local_spread_bl) <- "Extent of Tumor Spread (BL)"
labelled::var_label(colon_cancer$time_surgery_registration_bl) <- "Time: Surgery to Registration (BL)"
labelled::var_label(colon_cancer$arm) <- "Study Arm"
labelled::var_label(colon_cancer$tx) <- "Treatment Indicator"
labelled::var_label(colon_cancer$event_death) <- "Death On Study"
labelled::var_label(colon_cancer$time_to_death) <- "Time to Death On Study (d)"
labelled::var_label(colon_cancer$years_to_death) <- "Time to Death On Study (Y)"
labelled::var_label(colon_cancer$event_recurrence) <- "Recurrence On Study"
labelled::var_label(colon_cancer$time_to_recurrence) <- "Time to Recurrence On Study (d)"
labelled::var_label(colon_cancer$years_to_recurrence) <- "Time to Recurrence On Study (Y)"

colon_cancer_codebook <- quick_codebook(colon_cancer)

### Impute Missing Covariates ##################################################
colon_cancer_original <- colon_cancer

# Fit Cox Model
cox_death_adjusted <-
  survival::coxph(
    formula =
      survival::Surv(time = years_to_death, event = event_death) ~
      arm + age_bl + sex + obstruction_bl + perforation_bl +
      organ_adherence_bl + local_spread_bl + time_surgery_registration_bl,
    data = colon_cancer
  )

# Get prediction of time-to-death under observation arm
colon_cancer$cox_expected_obs <-
  predict(
    object = cox_death_adjusted,
    newdata =
      within(
        data = colon_cancer,
        expr = {arm = "Obs"}
      ),
    type = "expected"
  )


### Impute Missing Covariates ##################################################
# Imputation of covariates involves model-based prediction of expected survival
# under observation given covariates without missingness
colon_cancer_impute <-
  colon_cancer %>%
  dplyr::select(
    dplyr::all_of(
      x = c("age_bl", "sex", "obstruction_bl", "perforation_bl",
            "organ_adherence_bl", "differentiation_bl", "local_spread_bl",
            "time_surgery_registration_bl", "positive_nodes_bl",
            "cox_expected_obs")
    )
  )

colon_cancer_impute_0 <-
  mice::mice(
    data = colon_cancer_impute,
    m = 1,
    maxit = 0
  )

predictor_matrix <- colon_cancer_impute_0$predictorMatrix
predictor_matrix[, "local_spread_bl"] <- 0

### Perform MICE ###############################################################
colon_cancer_mice <-
  mice::mice(
    data = colon_cancer_impute,
    predictorMatrix = predictor_matrix,
    # Single Imputation
    m = 1,
    # 20 Iterations of MICE Algorithm
    maxit = 20,
    # Seed for reproducibility
    seed = 12345,
    printFlag = FALSE
  )

# plot(colon_cancer_mice)

# Get completed data
colon_cancer_mice <-
  mice::complete(data = colon_cancer_mice) %>%
  dplyr::select(
    differentiation_bl, positive_nodes_bl
  )


### Assemble Completed Dataset #################################################
colon_cancer_imputed <-
  dplyr::bind_cols(
    colon_cancer %>%
      dplyr::select(
        -dplyr::all_of(x = names(colon_cancer_mice))
      ),
    colon_cancer_mice
  ) %>%
  as.data.frame() %>%
  dplyr::select(
    dplyr::any_of(
      x = names(colon_cancer_original)
    )
  )

# Subset colon cancer data to active treatment arms: Lev, Lev+5FU
colon_cancer_active <-
  colon_cancer_imputed %>%
  dplyr::filter(
    arm %in% c("1. Lev+5FU", "0. Lev")
  )

if(!file.exists(data_dir)){
  dir.create(path = data_dir)
}

data <- colon_cancer <- as.data.frame(colon_cancer)
data_name <- "colon_cancer"
colon_cancer_original <- as.data.frame(colon_cancer_original)
colon_cancer_active <- as.data.frame(colon_cancer_active)

usethis::use_data(colon_cancer_original, overwrite = TRUE)
usethis::use_data(colon_cancer, overwrite = TRUE)
usethis::use_data(colon_cancer_active, overwrite = TRUE)

data.r_path <- file.path(here::here(), "R", "data.R")
if(!file.exists(data.r_path)){
  file.create(data.r_path)
  data.r_text_old <- NULL
} else {
  data.r_text_old <-
    readLines(con = data.r_path)
}

### colon_cancer: imputed - all arms ###########################################
data.r_text <-
  c(
    "`colon_cancer`: 5-Fluorouracil for Colon Cancer",
    "",
    "This is a randomized controlled trial, enrolling between 1984 to 1987, ",
    "comparing survival and cancer recurrence among 929 participants ",
    "randomized to 5-Fluorouracil + levamisole, levamisole alone, or ",
    "observation (Laurie et al. 1989). ",
    "",
    "This data was originally sourced from the `survival` package ",
    "(Therneau 2026), and modified to be ready to use. Note that covariates ",
    "have been imputed using Multiple Imputation with Chained Equations ",
    "(MICE) using the `mice` package. This contains all experimental arms.",
    "",
    "Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, ",
    "G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. \"Surgical ",
    "Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole ",
    "and the Combination of Levamisole and Fluorouracil. The North Central ",
    "Cancer Treatment Group and the Mayo Clinic.\" Journal of Clinical ",
    "Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. ",
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




### colon_cancer_original: all arms ############################################
data <- colon_cancer_original
data_name <- "colon_cancer_original"

data.r_text_2 <-
  c("`colon_cancer_original`: 5-Fluorouracil for Colon Cancer",
    "",
    "This is a randomized controlled trial, enrolling between 1984 to 1987, ",
    "comparing survival and cancer recurrence among 929 participants ",
    "randomized to 5-Fluorouracil + levamisole, levamisole alone, or ",
    "observation (Laurie et al. 1989). ",
    "",
    "This data was originally sourced from the `survival` package ",
    "(Therneau 2026), and modified to be ready to use. No missing data have ",
    "been imputed in this dataset.",
    "",
    "Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, ",
    "G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. \"Surgical ",
    "Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole ",
    "and the Combination of Levamisole and Fluorouracil. The North Central ",
    "Cancer Treatment Group and the Mayo Clinic.\" Journal of Clinical ",
    "Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. ",
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


data.r_text_2 <-
  c(
    data.r_text_2,
    paste0("\\item{", colnames(data), "}{",
           do.call(what = c, args = labelled::var_label(data)), "}"),
    "}",
    "@source <https://cran.r-project.org/web/packages/survival/index.html>"
  )

data.r_text_2 <- paste0("#' ", data.r_text_2)
data.r_text_2 <- c(data.r_text_2, paste0("\"", data_name, "\""))




### colon_cancer_active: active arms ###########################################
data <- colon_cancer_active
data_name <- "colon_cancer_active"

data.r_text_3 <-
  c("`colon_cancer_active`: 5-Fluorouracil for Colon Cancer",
    "",
    "This is a randomized controlled trial, enrolling between 1984 to 1987, ",
    "comparing survival and cancer recurrence among 929 participants ",
    "randomized to 5-Fluorouracil + levamisole, levamisole alone, or ",
    "observation (Laurie et al. 1989). ",
    "",
    "This data was originally sourced from the `survival` package ",
    "(Therneau 2026), and modified to be ready to use. Note that covariates ",
    "have been imputed using Multiple Imputation with Chained Equations ",
    "(MICE) using the `mice` package. This contains only active treatment ",
    "arms.",
    "",
    "Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, ",
    "G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. \"Surgical ",
    "Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole ",
    "and the Combination of Levamisole and Fluorouracil. The North Central ",
    "Cancer Treatment Group and the Mayo Clinic.\" Journal of Clinical ",
    "Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. ",
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


data.r_text_3 <-
  c(
    data.r_text_3,
    paste0("\\item{", colnames(data), "}{",
           do.call(what = c, args = labelled::var_label(data)), "}"),
    "}",
    "@source <https://cran.r-project.org/web/packages/survival/index.html>"
  )

data.r_text_3 <- paste0("#' ", data.r_text_3)
data.r_text_3 <- c(data.r_text_3, paste0("\"", data_name, "\""))

writeLines(
  text =
    c(data.r_text_old, "\n\n\n",
      paste(
        c(data.r_text, "\n\n\n", data.r_text_2, "\n\n\n", data.r_text_3),
        collapse = "\n"
      )
    ),
  con = data.r_path
)
