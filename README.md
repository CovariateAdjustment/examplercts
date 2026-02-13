
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `examplercts`: Analysis-Ready Example Data from Randomized Controlled Trials

<!-- badges: start -->

[![R-CMD-check](https://github.com/CovariateAdjustment/example_rcts/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CovariateAdjustment/example_rcts/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of `examplercts` is to facilitate teaching by providing
annotated, labelled, and documented datasets from randomized controlled
trials. These datasets have been sourced from existing R packages. This
repo is meant to provide both analysis-ready data and the code used to
produce that data.

## Installation

You can install the development version of examplercts from
[GitHub](https://github.com/) with:

``` r
## Method 1: Using `pak`
# install.packages("pak")
pak::pak("CovariateAdjustment/example_rcts")

## Method 2: Using `devtools`
# install.packages("devtools")
devtools::install_github(repo ="CovariateAdjustment/example_rcts")
```

Once installed, load the package, and the datasets are available for
use:

``` r
library(examplercts)
```

## Datasets:

### `strep_tb`: Streptomycin for Tuberculosis

This is a randomized controlled trial of 107 individuals, evaluating the
efficacy of streptomycin for pulmonary tuberculosis, conducted in 1947
(Medical Research Council 1998). Participants were randomized to receive
streptomycin and bed rest (treatment) or bed rest alone (control), and
followed up after six months. This data was sourced from the
[medicaldata package](https://github.com/higgi13425/medicaldata)
(Higgins 2022).

This dataset contains binary and ordinal outcome variables.

### `indo_rct`: Indomethicin vs. Placebo for Post-ERCP Pancreatitis (PEP)

This is a randomized controlled trial conducted from 2009 to 2011 of 602
individuals, evaluating the efficacy of indomethicin for prevention of
Post-ERCP Pancreatitis (Elmunzer et al. 2012). This data was sourced
from the [medicaldata
package](https://github.com/higgi13425/medicaldata) (Higgins 2022).

This dataset contains a binary outcome variable.

### `botox_dystonia`: Botulinium Toxin B vs. Placebo for Cervical Dystonia

This is a randomized controlled trial conducted from 2009 to 2011 of 545
individuals, evaluating the efficacy of botulinium toxin B for cervical
dystonia (Brashear et al. 1999). This data was sourced from the
[medicaldata package](https://github.com/higgi13425/medicaldata)
(Higgins 2022).

### `laryngoscope`: Macintosh vs. Pentax Laryngoscope for Orotracheal Intubation

This is a randomized controlled trial of 99 individuals, evaluating the
relative efficacy of two laryngoscope models for orotracheal intubation
in obese patients (Abdallah et al. 2011). This data was sourced from the
[medicaldata package](https://github.com/higgi13425/medicaldata)
(Higgins 2022).

### `licorice_gargle`: Licorice Gargle vs. Sucrose for Endotracheal Intubation

This is a randomized controlled trial, conducted from 2010 to 2011,
evaluating whether a licorice or sucrose gargle provided better
management of endotracheal tube extubation symptoms in 235 participants
(Ruetzler et al. 2013). This data was sourced from the [medicaldata
package](https://github.com/higgi13425/medicaldata) (Higgins 2022).

### `supraclavicular`: Combined vs. Sequential Administration of Supraclavicular Anaesthesia

This is a randomized controlled trial evaluating whether sequential or
combined anesthesia provided superior onset and duration of anaesthesia
in 103 participants (Roberman et al. 2011). This data was sourced from
the [medicaldata package](https://github.com/higgi13425/medicaldata)
(Higgins 2022).

### `perio_pregnancy`: Maternal Periodontal Therapy vs. Oral Exams for Preterm Birth

This is a randomized controlled trial, conducted from 1984 to 2005,
evaluating whether maternal periodontic treatment 823 participants
(Michalowicz et al. 2006). This data was sourced from the [medicaldata
package](https://github.com/higgi13425/medicaldata) (Higgins 2022).

### `colon_cancer`: 5-FU vs. Levamisole for Colon Cancer

This is a randomized controlled trial, enrolling between 1984 to 1987,
comparing survival and cancer recurrence among 929 participants
randomized to 5-Fluorouracil + levamisole, levamisole alone, or
observation (Laurie et al. 1989). This data was sourced from the
[survival
package](https://cran.r-project.org/web/packages/survival/index.html)
(Therneau 2026).

### `lung_cancer`: Veteran’s Administration Lung Cancer Trial

This is a randomized controlled trial conducted by the Veteran’s
Administration Lung Cancer group, comparing survival among 137
participants randomized to two treatment regimens. This data was sourced
from the [survival
package](https://cran.r-project.org/web/packages/survival/index.html)
(Therneau 2026), and is referenced in statistical publications and books
(Kalbfleisch and Prentice 2002; Prentice 1973), however there is no
reference listed to the primary publication of this trial.

<div id="refs" class="references csl-bib-body hanging-indent"
entry-spacing="0">

<div id="ref-laryngoscope" class="csl-entry">

Abdallah, Rania, Ursula Galway, Jing You, Andrea Kurz, Daniel I.
Sessler, and D. John Doyle. 2011. “A Randomized Comparison Between the
Pentax AWS Video Laryngoscope and the Macintosh Laryngoscope in Morbidly
Obese Patients.” *Anesthesia & Analgesia* 113 (5): 1082–87.
<https://doi.org/10.1213/ane.0b013e31822cf47d>.

</div>

<div id="ref-cdystonia" class="csl-entry">

Brashear, A., M. F. Lew, D. D. Dykstra, C. L. Comella, S. A. Factor, R.
L. Rodnitzky, R. Trosch, et al. 1999. “Safety and Efficacy of NeuroBloc
(Botulinum Toxin Type b) in Type a–Responsive Cervical Dystonia.”
*Neurology* 53 (7): 1439–39. <https://doi.org/10.1212/wnl.53.7.1439>.

</div>

<div id="ref-indo-rct" class="csl-entry">

Elmunzer, B. Joseph, James M. Scheiman, Glen A. Lehman, Amitabh Chak,
Patrick Mosler, Peter D. R. Higgins, Rodney A. Hayward, et al. 2012. “A
Randomized Trial of Rectal Indomethacin to Prevent Post-ERCP
Pancreatitis.” *New England Journal of Medicine* 366 (15): 1414–22.
<https://doi.org/10.1056/nejmoa1111103>.

</div>

<div id="ref-medicaldata" class="csl-entry">

Higgins, Peter. 2022. *Medicaldata: Data Package for Medical Datasets*.
<https://github.com/higgi13425/medicaldata>.

</div>

<div id="ref-Kalbfleisch2002" class="csl-entry">

Kalbfleisch, John D., and Ross L. Prentice. 2002. *The Statistical
Analysis of Failure Time Data*. *Wiley Series in Probability and
Statistics*. Wiley. <https://doi.org/10.1002/9781118032985>.

</div>

<div id="ref-colon-cancer" class="csl-entry">

Laurie, J A, C G Moertel, T R Fleming, H S Wieand, J E Leigh, J Rubin, G
W McCormack, J B Gerstner, J E Krook, and J Malliard. 1989. “Surgical
Adjuvant Therapy of Large-Bowel Carcinoma: An Evaluation of Levamisole
and the Combination of Levamisole and Fluorouracil. The North Central
Cancer Treatment Group and the Mayo Clinic.” *Journal of Clinical
Oncology* 7 (10): 1447–56. <https://doi.org/10.1200/jco.1989.7.10.1447>.

</div>

<div id="ref-strep-tb" class="csl-entry">

Medical Research Council. 1998. “Streptomycin Treatment of Pulmonary
Tuberculosis.” Edited by British Medical Journal Publishing Group. *BMJ*
317 (7167): 1248. <https://doi.org/10.1136/bmj.317.7167.1248b>.

</div>

<div id="ref-perio-pregnancy" class="csl-entry">

Michalowicz, Bryan S., James S. Hodges, Anthony J. DiAngelis, Virginia
R. Lupo, M. John Novak, James E. Ferguson, William Buchanan, et al.
2006. “Treatment of Periodontal Disease and the Risk of Preterm Birth.”
*New England Journal of Medicine* 355 (18): 1885–94.
<https://doi.org/10.1056/nejmoa062249>.

</div>

<div id="ref-Prentice1973" class="csl-entry">

Prentice, R. L. 1973. “Exponential Survivals with Censoring and
Explanatory Variables.” *Biometrika* 60 (2): 279–88.
<https://doi.org/10.1093/biomet/60.2.279>.

</div>

<div id="ref-supraclavicular" class="csl-entry">

Roberman, Dmitry, Harendra Arora, Daniel I. Sessler, Michael Ritchey,
Jing You, and Priya Kumar. 2011. “Combined Versus Sequential Injection
of Mepivacaine and Ropivacaine for Supraclavicular Nerve Blocks.”
*Regional Anesthesia and Pain Medicine* 36 (2): 145–50.
<https://doi.org/10.1097/aap.0b013e31820d4235>.

</div>

<div id="ref-licorice-gargle" class="csl-entry">

Ruetzler, Kurt, Michael Fleck, Sabine Nabecker, Kristina Pinter, Gordian
Landskron, Andrea Lassnigg, Jing You, and Daniel I. Sessler. 2013. “A
Randomized, Double-Blind Comparison of Licorice Versus Sugar-Water
Gargle for Prevention of Postoperative Sore Throat and Postextubation
Coughing.” *Anesthesia & Analgesia* 117 (3): 614–21.
<https://doi.org/10.1213/ane.0b013e318299a650>.

</div>

<div id="ref-survival" class="csl-entry">

Therneau, Terry M. 2026. *A Package for Survival Analysis in r*.
<https://CRAN.R-project.org/package=survival>.

</div>

</div>
