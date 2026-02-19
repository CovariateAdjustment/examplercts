#' `strep_tb`: Streptomycin for Tuberculosis
#' 
#' This is a randomized controlled trial of 107 individuals, evaluating the 
#' efficacy of streptomycin for pulmonary tuberculosis, conducted in 1947 
#' (Medical Research Council 1998). Participants were randomized to receive 
#' streptomycin and bed rest (treatment) or bed rest alone (control), and 
#' followed up after six months.
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Medical Research Council. 1998. "Streptomycin Treatment of Pulmonary
#' Tuberculosis." Edited by British Medical Journal Publishing Group. 
#' BMJ 317 (7167): 1248. https://doi.org/10.1136/bmj.317.7167.1248b.
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `strep_tb`
#' A data frame with 107 rows and 13 columns: 
#' \describe{
#' \item{patient_id}{Participant ID}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{gender}{Gender}
#' \item{condition_bl}{Condition (BL)}
#' \item{temperature_bl}{Temperature  (BL)}
#' \item{sed_rate_esr_bl}{ESR: Sedimentation Rate (BL)}
#' \item{cxr_lung_cavitation_bl}{Lung Cavitation on X-Ray (BL)}
#' \item{strep_resistance_6m}{Strep Resistance (6M)}
#' \item{radiologic_outcome_6m}{Radiologic Outcome (6M)}
#' \item{chest_xray_rating_6m}{Chest X-Ray Numeric Rating (6M)}
#' \item{radiologic_improvement_6m}{Radiologic Improvement (6M)}
#' \item{radiologic_improvement_f_6m}{Radiologic Improvement (6M)}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"strep_tb"




#' `indo_rct`: Indomethicin vs. Placebo for Post-ERCP Pancreatitis (PEP)
#' 
#' This is a randomized controlled trial conducted from 2009 to 2011 of 602 
#' individuals, evaluating the efficacy of indomethicin for prevention of 
#' Post-ERCP Pancreatitis (Elmunzer et al. 2012).
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Elmunzer, B. Joseph, James M. Scheiman, Glen A. Lehman, Amitabh Chak, 
#' Patrick Mosler, Peter D. R. Higgins, Rodney A. Hayward, et al. 2012. 
#' "A Randomized Trial of Rectal Indomethacin to Prevent Post-ERCP 
#' Pancreatitis." New England Journal of Medicine 366 (15): 1414–22. 
#' https://doi.org/10.1056/nejmoa1111103.
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `indo_rct`
#' A data frame with 602 rows and 22 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{age}{Age at Baseline}
#' \item{gender}{Gender}
#' \item{previous_pep_bl}{Previous PEP (BL)}
#' \item{pancreatitis_bl}{Recurrent Pancreatitis (BL)}
#' \item{p_sphincterotmy_bl}{Pancreatic Sphincterotomy (BL)}
#' \item{sphincter_precut_bl}{Sphincter Pre-cut Needed (BL)}
#' \item{difficult_cannulation_bl}{Difficult Cannulation of Papilla (BL)}
#' \item{pneumatic_dilation_bl}{Pneumatic Dilation of Papilla (BL)}
#' \item{ampullectomy_bl}{Ampullectomy Performed(BL)}
#' \item{injected_contrast_bl}{Contrast Injected (BL)}
#' \item{aspirin_any_bl}{Any Aspirin Use (BL)}
#' \item{any_p_duct_stent_bl}{Pancreatic Duct Stent Used (BL)}
#' \item{oddi_manometry_bl}{Sphicter of Oddi Manometry (BL)}
#' \item{b_sphincterotmy_bl}{Biliary Sphincterotomy (BL)}
#' \item{trainee_bl}{Trainee Involved in ERCP(BL)}
#' \item{is_outpatient_bl}{Outpatient Status (BL)}
#' \item{oddi_dysfunction_bl}{Sphincter of Oddi Dysfunction (BL)}
#' \item{pep}{Post-ERCP Pancreatitis}
#' \item{pep_binary}{Post-ERCP Pancreatitis}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"indo_rct"




#' `botox_dystonia`: Indomethicin vs. Placebo for Post-ERCP Pancreatitis (PEP)
#' 
#' This is a randomized controlled trial conducted from 2009 to 2011 of 545 
#' individuals, evaluating the efficacy of botulinium toxin B for cervical 
#' dystonia (Brashear et al. 1999).
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Brashear, A., M. F. Lew, D. D. Dykstra, C. L. Comella, S. A. Factor, 
#' R. L. Rodnitzky, R. Trosch, et al. 1999. "Safety and Efficacy of 
#' NeuroBloc (Botulinum Toxin Type b) in Type a–Responsive Cervical 
#' Dystonia." Neurology 53 (7): 1439–39. 
#' https://doi.org/10.1212/wnl.53.7.1439. 
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `botox_dystonia`
#' A data frame with 545 rows and 9 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{site}{Site ID}
#' \item{age_bl}{Age at Baseline (BL)}
#' \item{sex}{Sex}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{twstrs_bl}{TWSTRS Total Score (BL)}
#' \item{week}{Week Post Randomization}
#' \item{twstrs}{TWSTRS Total Score - Followup}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"botox_dystonia"




#' `laryngoscope`: Macintosh vs. Pentax Laryngoscope for Orotracheal Intubation
#' 
#' This is a randomized controlled trial of 99 individuals, evaluating the 
#' relative efficacy of two laryngoscope models for orotracheal intubation 
#' in obese patients (Abdallah et al. 2011). 
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Abdallah, Rania, Ursula Galway, Jing You, Andrea Kurz, Daniel I. 
#' Sessler, and D. John Doyle. 2011. "A Randomized Comparison Between the 
#' Pentax AWS Video Laryngoscope and the Macintosh Laryngoscope in Morbidly 
#' Obese Patients." Anesthesia & Analgesia 113 (5): 1082–87. 
#' https://doi.org/10.1213/ane.0b013e31822cf47d. 
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `laryngoscope`
#' A data frame with 99 rows and 24 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{age_bl}{Age at Baseline}
#' \item{gender}{Gender}
#' \item{asa_physical_status_bl}{ASA Physical Status}
#' \item{mallampati_bl}{Mallampati Score (BL)}
#' \item{bmi_bl}{Body Mass Index (kg/m^2)}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{attempt_1_time}{Attempt 1 Time (s)}
#' \item{attempt_1}{Attempt 1 Outcome}
#' \item{attempt_1_f}{Attempt 1 Outcome}
#' \item{attempt_2_time}{Attempt 2 Time (s)}
#' \item{attempt_2}{Attempt 2 Outcome}
#' \item{attempt_2_f}{Attempt 2 Outcome}
#' \item{attempt_3_time}{Attempt 3 Time (s)}
#' \item{attempt_3}{Attempt 3 Outcome}
#' \item{attempt_3_f}{Attempt 3 Outcome}
#' \item{attempts}{Intubation Attempts}
#' \item{failures}{Intubation Failures}
#' \item{total_intubation_time}{Total Intubation Time (s)}
#' \item{bleeding}{Post-Intubation Bleeding}
#' \item{difficulty}{Intubation Difficulty: Easy (0) - Difficult (100)}
#' \item{sore_throat}{Post-Intubation Sore Throat}
#' \item{glottic_view_grade}{Grade of Glottic View}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"laryngoscope"




#' `licorice_gargle`: Licorice Gargle vs. Sucrose for Management of 
#' Endotracheal Intubation
#' 
#' This is a randomized controlled trial, conducted from 2010 to 2011, 
#' evaluating whether a licorice or sucrose gargle provided better 
#' management of endotracheal tube extubation symptoms in 235 participants 
#' (Ruetzler et al. 2013).
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Ruetzler, Kurt, Michael Fleck, Sabine Nabecker, Kristina Pinter, Gordian 
#' Landskron, Andrea Lassnigg, Jing You, and Daniel I. Sessler. 2013. "A 
#' Randomized, Double-Blind Comparison of Licorice Versus Sugar-Water 
#' Gargle for Prevention of Postoperative Sore Throat and Postextubation 
#' Coughing." Anesthesia & Analgesia 117 (3): 614–21. 
#' https://doi.org/10.1213/ane.0b013e318299a650. 
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `licorice_gargle`
#' A data frame with 235 rows and 25 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{age_bl}{Age at Baseline}
#' \item{gender}{Gender}
#' \item{asa_physical_status_bl}{ASA Physical Status}
#' \item{bmi_bl}{Body Mass Index (kg/m^2)}
#' \item{mallampati_bl}{Mallampati Score (BL)}
#' \item{smoking_bl}{Smoking Status (BL)}
#' \item{pain_yn_bl}{Preoperative Pain (BL)}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{surgery_size_post_rnd}{Surgery Size (Post-Randomization)}
#' \item{extubation_cough}{Cough At Extubation}
#' \item{pacu_30_min_cough}{Cough at PACU: 30 Minutes}
#' \item{pacu_30_min_throat_pain}{Throat Pain at PACU: 30 Minutes}
#' \item{pacu_30_min_any_throat_pain}{Any Throat Pain at PACU: 30 Minutes}
#' \item{pacu_30_min_swallow_pain}{Swallow Pain at PACU: 30 Minutes}
#' \item{pacu_90_min_cough}{Cough at PACU: 90 Minutes}
#' \item{pacu_90_min_throat_pain}{Throat Pain at PACU: 90 Minutes}
#' \item{pacu_90_min_any_throat_pain}{Any Throat Pain at PACU: 90 Minutes}
#' \item{postop_4h_cough}{Cough: 4H Post-Op}
#' \item{postop_4h_throat_pain}{Throat Pain: 4H Post-Op}
#' \item{postop_4h_any_throat_pain}{Any Throat Pain: 4H Post-Op}
#' \item{postop_1d_am_cough}{Cough: 1d Post-Op in AM}
#' \item{postop_1d_am_throat_pain}{Throat Pain: 1d Post-Op in AM}
#' \item{postop_1d_am_any_throat_pain}{Any Throat Pain: 1d Post-Op in AM}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"licorice_gargle"




#' `supraclavicular`: Combined vs. Sequential Administration of 
#' Supraclavicular Anaesthesia
#' 
#' This is a randomized controlled trial conducted from 2009 to 2011 of 545 
#' individuals, evaluating the efficacy of botulinium toxin B for cervical 
#' dystonia (Brashear et al. 1999).
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Roberman, Dmitry, Harendra Arora, Daniel I. Sessler, Michael Ritchey, 
#' Jing You, and Priya Kumar. 2011. "Combined Versus Sequential Injection 
#' of Mepivacaine and Ropivacaine for Supraclavicular Nerve Blocks." 
#' Regional Anesthesia and Pain Medicine 36 (2): 145–50.
#' https://doi.org/10.1097/aap.0b013e31820d4235. 
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `supraclavicular`
#' A data frame with 103 rows and 20 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{age_bl}{Age at Baseline (BL)}
#' \item{gender}{Gender (BL)}
#' \item{bmi_bl}{Body Mass Index - kg/m^2 (BL)}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{fentanyl_intraop}{Intraoperative Fentanyl (ug)}
#' \item{alfentanil_intraop}{Intraoperative Alfentanyl (mg)}
#' \item{midazolam_intraop}{Intraoperative Midazolam (mg)}
#' \item{time_4_nerve_block}{Time: 4-Nerve Sensory Block (m)}
#' \item{time_1st_nerve_block}{Time: 1st Sensory Block (m)}
#' \item{nerve_block_achieved}{Achieve Sensory+Motor Block}
#' \item{nerve_block_achieved_f}{Achieve Sensory+Motor Block}
#' \item{time_complete_motor_block}{Time: Complete Motor Block (m)}
#' \item{time_block_to_meds}{Time: Nerve Block to Meds Requested (h)}
#' \item{meds_requested}{Analgesia Requested 2d Post-op}
#' \item{meds_requested_f}{Analgesia Requested 2d Post-op}
#' \item{max_postop_pain_rest}{Max Postop Verbal Pain (0-10): Rest}
#' \item{max_postop_pain_movement}{Max Postop Verbal Pain (0-10): Movement}
#' \item{total_opioids}{Total Opioids (mg)}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"supraclavicular"




#' `perio_pregnancy`: Maternal Periodontal Therapy and Pregnancy Outcomes
#' 
#' This is a randomized controlled trial, conducted from 1984 to 2005, 
#' evaluating whether maternal periodontic treatment 823 participants 
#' (Michalowicz et al. 2006).
#' 
#' This data was originally sourced from the 
#' `medicaldata` package (Higgins 2022), and modified to be ready to use.
#' 
#' Michalowicz, Bryan S., James S. Hodges, Anthony J. DiAngelis, Virginia 
#' R. Lupo, M. John Novak, James E. Ferguson, William Buchanan, et al. 
#' 2006. "Treatment of Periodontal Disease and the Risk of Preterm Birth."
#' New England Journal of Medicine 355 (18): 1885–94. 
#' https://doi.org/10.1056/nejmoa062249. 
#' 
#' Higgins, Peter. 2022. Medicaldata: Data Package for Medical Datasets.
#' https://github.com/higgi13425/medicaldata.
#' 
#' @format ## `perio_pregnancy`
#' A data frame with 823 rows and 25 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{age_bl}{Mother's Age (BL)}
#' \item{education_bl}{Education (BL)}
#' \item{public_assistance_bl}{On Public Assistance (BL)}
#' \item{hypertension_bl}{Hypertension (BL)}
#' \item{diabetes_bl}{Any Diabetes (BL)}
#' \item{diabetes_type_bl}{Diabetes Type (BL)}
#' \item{bmi_bl}{Body Mass Index - kg/m^2 (BL)}
#' \item{tobacco_use_bl}{Tobacco Use (BL)}
#' \item{previous_pregnancy_bl}{Previous Pregnancy (BL)}
#' \item{previous_live_preterm_bl}{Previous Live Preterm Birth (BL)}
#' \item{previous_stillbirth_bl}{Previous Stillbirth (BL)}
#' \item{previous_spontaneous_abortion}{Previous Spontaneous Abortion (BL)}
#' \item{previous_induced_abortion}{Previous Induced Abortion (BL)}
#' \item{any_lptb_sb_sa_ia_bl}{Previous LPTB, SB, SA, or IA (BL)}
#' \item{site}{Study Site}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{birth_outcome}{Birth Outcome}
#' \item{birthweight}{Birthweight at Outcome}
#' \item{low_birthweight}{Low Birthweight (<2500 g)}
#' \item{birthweight_category}{Birthweight Category}
#' \item{gestational_age}{Gestational Age at Outcome}
#' \item{apgar_1_min}{Apgar (1m)}
#' \item{apgar_5_min}{Apgar (5m)}
#' }
#' @source <https://github.com/higgi13425/medicaldata>
"perio_pregnancy"




#' `colon_cancer`: 5-Fluorouracil for Colon Cancer
#' 
#' This is a randomized controlled trial, enrolling between 1984 to 1987, 
#' comparing survival and cancer recurrence among 929 participants 
#' randomized to 5-Fluorouracil + levamisole, levamisole alone, or 
#' observation (Laurie et al. 1989). 
#' 
#' This data was originally sourced from the `survival` package 
#' (Therneau 2026), and modified to be ready to use. Note that covariates 
#' have been imputed using Multiple Imputation with Chained Equations 
#' (MICE) using the `mice` package. This contains all experimental arms.
#' 
#' Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, 
#' G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. "Surgical 
#' Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole 
#' and the Combination of Levamisole and Fluorouracil. The North Central 
#' Cancer Treatment Group and the Mayo Clinic." Journal of Clinical 
#' Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. 
#' 
#' Therneau, Terry M. 2026. A Package for Survival Analysis in r. 
#' https://CRAN.R-project.org/package=survival. 
#' 
#' @format ## `colon_cancer`
#' A data frame with 929 rows and 19 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{arm}{Study Arm}
#' \item{age_bl}{Age (BL)}
#' \item{sex}{Sex (BL)}
#' \item{obstruction_bl}{Tumor Obstructs Colon (BL)}
#' \item{perforation_bl}{Tumor Perforates Colon (BL)}
#' \item{organ_adherence_bl}{Tumor Organ Adherence (BL)}
#' \item{positive_nodes_bl}{Lymph Nodes with Cancer (BL)}
#' \item{differentiation_bl}{Tumor Differentiation (BL)}
#' \item{local_spread_bl}{Extent of Tumor Spread (BL)}
#' \item{time_surgery_registration_bl}{Time: Surgery to Registration (BL)}
#' \item{event_death}{Death On Study}
#' \item{time_to_death}{Time to Death On Study (d)}
#' \item{event_recurrence}{Recurrence On Study}
#' \item{time_to_recurrence}{Time to Recurrence On Study (d)}
#' \item{tx}{Treatment Indicator}
#' \item{years_to_death}{Time to Death On Study (Y)}
#' \item{years_to_recurrence}{Time to Recurrence On Study (Y)}
#' \item{cox_expected_obs}{Participant ID}
#' }
#' @source <https://cran.r-project.org/web/packages/survival/index.html>
"colon_cancer"




#' `colon_cancer_original`: 5-Fluorouracil for Colon Cancer
#' 
#' This is a randomized controlled trial, enrolling between 1984 to 1987, 
#' comparing survival and cancer recurrence among 929 participants 
#' randomized to 5-Fluorouracil + levamisole, levamisole alone, or 
#' observation (Laurie et al. 1989). 
#' 
#' This data was originally sourced from the `survival` package 
#' (Therneau 2026), and modified to be ready to use. No missing data have 
#' been imputed in this dataset.
#' 
#' Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, 
#' G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. "Surgical 
#' Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole 
#' and the Combination of Levamisole and Fluorouracil. The North Central 
#' Cancer Treatment Group and the Mayo Clinic." Journal of Clinical 
#' Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. 
#' 
#' Therneau, Terry M. 2026. A Package for Survival Analysis in r. 
#' https://CRAN.R-project.org/package=survival. 
#' 
#' @format ## `colon_cancer_original`
#' A data frame with 929 rows and 18 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{arm}{Study Arm}
#' \item{age_bl}{Age (BL)}
#' \item{sex}{Sex (BL)}
#' \item{obstruction_bl}{Tumor Obstructs Colon (BL)}
#' \item{perforation_bl}{Tumor Perforates Colon (BL)}
#' \item{organ_adherence_bl}{Tumor Organ Adherence (BL)}
#' \item{positive_nodes_bl}{Lymph Nodes with Cancer (BL)}
#' \item{differentiation_bl}{Tumor Differentiation (BL)}
#' \item{local_spread_bl}{Extent of Tumor Spread (BL)}
#' \item{time_surgery_registration_bl}{Time: Surgery to Registration (BL)}
#' \item{event_death}{Death On Study}
#' \item{time_to_death}{Time to Death On Study (d)}
#' \item{event_recurrence}{Recurrence On Study}
#' \item{time_to_recurrence}{Time to Recurrence On Study (d)}
#' \item{tx}{Treatment Indicator}
#' \item{years_to_death}{Time to Death On Study (Y)}
#' \item{years_to_recurrence}{Time to Recurrence On Study (Y)}
#' }
#' @source <https://cran.r-project.org/web/packages/survival/index.html>
"colon_cancer_original"




#' `colon_cancer_active`: 5-Fluorouracil for Colon Cancer
#' 
#' This is a randomized controlled trial, enrolling between 1984 to 1987, 
#' comparing survival and cancer recurrence among 929 participants 
#' randomized to 5-Fluorouracil + levamisole, levamisole alone, or 
#' observation (Laurie et al. 1989). 
#' 
#' This data was originally sourced from the `survival` package 
#' (Therneau 2026), and modified to be ready to use. Note that covariates 
#' have been imputed using Multiple Imputation with Chained Equations 
#' (MICE) using the `mice` package. This contains only active treatment 
#' arms.
#' 
#' Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, 
#' G W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. "Surgical 
#' Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole 
#' and the Combination of Levamisole and Fluorouracil. The North Central 
#' Cancer Treatment Group and the Mayo Clinic." Journal of Clinical 
#' Oncology 7 (10): 1447–56. https://doi.org/10.1200/jco.1989.7.10.1447. 
#' 
#' Therneau, Terry M. 2026. A Package for Survival Analysis in r. 
#' https://CRAN.R-project.org/package=survival. 
#' 
#' @format ## `colon_cancer_active`
#' A data frame with 614 rows and 18 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{arm}{Study Arm}
#' \item{age_bl}{Age (BL)}
#' \item{sex}{Sex (BL)}
#' \item{obstruction_bl}{Tumor Obstructs Colon (BL)}
#' \item{perforation_bl}{Tumor Perforates Colon (BL)}
#' \item{organ_adherence_bl}{Tumor Organ Adherence (BL)}
#' \item{positive_nodes_bl}{Lymph Nodes with Cancer (BL)}
#' \item{differentiation_bl}{Tumor Differentiation (BL)}
#' \item{local_spread_bl}{Extent of Tumor Spread (BL)}
#' \item{time_surgery_registration_bl}{Time: Surgery to Registration (BL)}
#' \item{event_death}{Death On Study}
#' \item{time_to_death}{Time to Death On Study (d)}
#' \item{event_recurrence}{Recurrence On Study}
#' \item{time_to_recurrence}{Time to Recurrence On Study (d)}
#' \item{tx}{Treatment Indicator}
#' \item{years_to_death}{Time to Death On Study (Y)}
#' \item{years_to_recurrence}{Time to Recurrence On Study (Y)}
#' }
#' @source <https://cran.r-project.org/web/packages/survival/index.html>
"colon_cancer_active"




#' `lung_cancer`: Veteran’s Administration Lung Cancer Trial
#' 
#' This is a randomized controlled trial conducted by the Veteran’s 
#' Administration Lung Cancer group, comparing survival among 137 
#' participants randomized to two treatment regimens.
#' 
#' This data was originally sourced from the `survival` package 
#' (Therneau 2026), and modified to be ready to use.
#' 
#' Prentice, R. L. 1973. "Exponential Survivals with Censoring and 
#' Explanatory Variables." Biometrika 60 (2): 279–88. 
#' https://doi.org/10.1093/biomet/60.2.279. 
#' 
#' Kalbfleisch, John D., and Ross L. Prentice. 2002. The Statistical 
#' Analysis of Failure Time Data. Wiley Series in Probability and 
#' Statistics. Wiley. https://doi.org/10.1002/9781118032985. 
#' 
#' Therneau, Terry M. 2026. A Package for Survival Analysis in r. 
#' https://CRAN.R-project.org/package=survival. 
#' 
#' @format ## `lung_cancer`
#' A data frame with 137 rows and 9 columns: 
#' \describe{
#' \item{participant_id}{Participant ID}
#' \item{age_bl}{Age (BL)}
#' \item{cell_type_bl}{Tumor Cell Type (BL)}
#' \item{karnofsky_bl}{Karnofsky Performance Score (BL)}
#' \item{time_from_dx_bl}{Time: Diagnosis to Randomization (BL)}
#' \item{arm}{Study Arm}
#' \item{tx}{Treatment Indicator}
#' \item{time_to_event}{Time to Death On Study (d)}
#' \item{event}{Death On Study}
#' }
#' @source <https://cran.r-project.org/web/packages/survival/index.html>
"lung_cancer"
