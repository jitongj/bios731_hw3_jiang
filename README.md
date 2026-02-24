# Project Structure

```
project/
├── data/
│   ├── simulation_data.rds
│   ├── summary_results.rds
│
├── source/
│   ├── logistic_helper.R
│   ├── newton_logistic.R
│   ├── bfgs_logistic.R
│   ├── mm_logistic.R
│   ├── compute_ci.R
│   ├── em_exp_censored.R
│
├── analysis/
│   ├── run_simulation.R
│   ├── run_problem3.R
│   ├── run_problem4.R
│   ├── Final_Report.Rmd
│
└── README.md
```
------------------------------------------------------------------------

# Folder Description

## data

Stores intermediate and final saved results.

-   simulation_data.rds\
    Simulated dataset used for logistic regression experiments.

-   summary_results.rds\
    Model comparison results including estimates, standard errors,
    confidence intervals, computation time, and iteration counts.

------------------------------------------------------------------------

## source

Contains reusable functions and executable run scripts.

Core functions:

-   logistic_helper.r\
    Logistic utilities: logistic mean function, log-likelihood, gradient, and Hessian.

-   newton_logistic.r\
    Newton–Raphson optimizer for logistic regression.

-   bfgs_logistic.r\
    BFGS optimization for logistic regression.

-   mm_logistic.r\
    MM algorithm for logistic regression.

-   glm_logistic.r\
    Baseline fit using glm for comparison.

-   compute_ci.r\
    Wald confidence intervals (based on the fitted Hessian / information).

-   simulate_data.r\
    Data simulation for logistic regression experiments.

-   em_exp_censored.r\
    EM algorithm for right-censored exponential model.

Run scripts (main entry points):

-   step1_run_simulation.r\
    Generates simulation data and saves outputs into the data folder.

-   step2_run_methods.r\
    Loads the saved simulation data, runs all methods (Newton/BFGS/MM/GLM), computes CIs, measures time/iterations, and saves a summary table into the data folder.

## analysis

-   final report.rmd\
    Final report source. It loads saved results from the data folder and produces tables/figures.

-   final-report.pdf\
    Knitted output from the Rmd file.

------------------------------------------------------------------------

# How to Reproduce (Run Order)

From the project root:
1)  Open the R project:

    731_HW3.Rproj

2)  Run simulation and save data/results:

    step1_run_simulation.r

3)  Run all logistic methods and save summary results:

    step2_run_methods.r

4)  Knit the report

    Open analysis/final report.rmd and knit.

------------------------------------------------------------------------

# Software Requirements

R (\>= 4.0)

Suggested packages:

-   survival
-   ggplot2
-   dplyr
-   here

