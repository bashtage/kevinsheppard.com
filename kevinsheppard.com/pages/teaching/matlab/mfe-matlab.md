<!--
.. title: MFE MATLAB
.. hidetitle: True
.. slug: mfe-matlab
.. date: 2019-09-10 15:48:35 UTC+01:00
.. tags: matlab, mfe
.. category: teaching 
.. link: 
.. description: A complete course for learning MATLAB from novice to expert. 
.. type: text
.. masthead: /images/teaching/mfe-financial-econometrics-logo.svg
.. jumbotron: MFE Financial Econometrics
.. jumbotron_text: Notes, assignment and solutions for the MATLAB companion course the accompanies Financial Econometrics I & II.
.. masthead_height: 15  
-->


Solutions are posted after the class that covers the assignment has completed.  Solutions are available both as
MATLAB Live Scripts, which provide an integrated view of code, text and mathematics and generic m-file scripts.
Live Scripts are only usable in recent versions of MATLAB.

[TOC]

# MATLAB Notes

A [complete set of notes](/teaching/matlab/notes/) covering the core aspects of MATLAB used in
econometric analysis serves as a reference for the companion course.

# Introduction

[MATLAB Introduction Course](/files/teaching/matlab/course/mfe_matlab_introductory_course_2019.pdf)

[MATLAB Introduction Course Data](/files/teaching/matlab/course/mfe_matlab_introduction_data.zip)

## Introduction Solutions
   
| MATLAB Live Script (mlx)                                                               | MATLAB Script (m)                                                                    |
| :------------------------------------------------------------------------------------- | :------------------------------------------------------------------------------------|
| [Importing Data into MATLAB](/files/teaching/matlab/course/importing_data.mlx)         | [Importing Data into MATLAB](/files/teaching/matlab/course/importing_data.m)         |
| [Using functions](/files/teaching/matlab/course/using_functions.mlx)                   | [Using functions](/files/teaching/matlab/course/using_functions.m)                   |
| [Accessing elements in matrices](/files/teaching/matlab/course/accessing_elements.mlx) | [Accessing elements in matrices](/files/teaching/matlab/course/accessing_elements.m) |
| [Program flow](/files/teaching/matlab/course/program_flow.mlx)                         | [Program flow](/files/teaching/matlab/course/program_flow.m)                         |
| [Logical statements](/files/teaching/matlab/course/logical_statements.mlx)             | [Logical statements](/files/teaching/matlab/course/logical_statements.m)             |
| [Tables](/files/teaching/matlab/course/tables.mlx)                                     | [Tables](/files/teaching/matlab/course/tables.m)                                     | 
| [Graphics](/files/teaching/matlab/course/graphics.mlx)                                 | [Graphics](/files/teaching/matlab/course/graphics.m)                                 |


# Companion Course
[MATLAB Companion Course (Complete)](/files/teaching/matlab/course/mfe_matlab_course_outline_2019.pdf)


#### Solutions

!!! primary "Solution Availability" 
    Solutions are provided in the week when a module is taught.

<!--
##### Data and Simulation
* [Data Set Construction](/files/teaching/matlab/course/data_set_construction.mlx)
* [Simulation](/files/teaching/matlab/course/simulation.mlx)
* [Expectations](/files/teaching/matlab/course/expectations.mlx)
##### Estimation and Inference
* [Method of Moments](/files/teaching/matlab/course/method_of_moments.mlx)
* [Maximum Likelihood](/files/teaching/matlab/course/maximum_likelihood.mlx)
* [Bias and Standard Errors](/files/teaching/matlab/course/standard_errors.mlx)
##### Linear Regression
* [Basic Linear Regression](/files/teaching/matlab/course/basic_linear_regression.mlx)
* [Rolling Regressions](/files/teaching/matlab/course/rolling_and_recursive_ols.mlx)
* [Cross-validation and Model Selection](/files/teaching/matlab/course/cross_validation.mlx)
* [Model Selection and Out-of-Sample R2](/files/teaching/matlab/course/model_selection_and_out_of_sample_r2.mlx)

#### Support Files
* [Specific-to-General](/files/teaching/matlab/course/stg.m)
* [General-to-Specific](/files/teaching/matlab/course/gts.m)
* [K-fold Cross Validation](/files/teaching/matlab/course/kfold_cross_val.m)
* [Simulated Data Generation](/files/teaching/matlab/course/generate_data.m)
* [Information Criteria Calculation](/files/teaching/matlab/course/compute_ic.m)


### Hilary Solutions
#### Data
* [Data Set Construction](/files/teaching/matlab/course/time_series_data.mlx)
#### ARMA Models
* [ARMA Model Estimation](/files/teaching/matlab/course/arma_estimation.mlx)
* [ARMA Model Selection](/files/teaching/matlab/course/arma_model_selection.mlx)
* [ARMA Diagnostics](/files/teaching/matlab/course/arma_residual_diagnostics.mlx)
* [ARMA Forecasting](/files/teaching/matlab/course/arma_forecasting.mlx)
* [Unit Root Testing](/files/teaching/matlab/course/arma_unit_roots.mlx)
#### ARCH Models
* [ARCH Model Estimation](/files/teaching/matlab/course/arch_model_estimation.mlx)
* [ARCH Model Selection](/files/teaching/matlab/course/arch_model_selection.mlx)
* [ARCH Model Forecasting](/files/teaching/matlab/course/arch_model_forecasting.mlx)
#### Value-at-Risk
* [Value-at-Risk using Historical Simulation](/files/teaching/matlab/course/VaR_historical_simulation.mlx)
* [Value-at-Risk using Filtered HS](/files/teaching/matlab/course/VaR_filtered_historical_simulation.mlx)
* [Value-at-Risk Evaluation](/files/teaching/matlab/course/VaR_forecast_evaluation.mlx)
#### Vector Autoregressions
* [Vector Autoregression Estimation](/files/teaching/matlab/course/VectorAR_estimation.mlx)
* [Vector Autoregression Order Selection](/files/teaching/matlab/course/VectorAR_order_selection.mlx)
* [Vector Autoregression Granger Causality](/files/teaching/matlab/course/VectorAR_granger_causality.mlx)
* [Vector Autoregression Impulse Responses](/files/teaching/matlab/course/VectorAR_impulse_response.mlx)
* [Vector Autoregression: Engle-Granger Cointegration Testing](/files/teaching/matlab/course/VectorAR_engle_granger.mlx)

## Helper Function
##### Data Set Construction
* [Compute Month End Prices](/files/teaching/matlab/course/month_end_prices.m)
##### Expectations
* [Lognormal Quadrature Target](/files/teaching/matlab/course/lognormal_quad_target.m)
* [Expected Utility](/files/teaching/matlab/course/expected_utility.m)
##### Maximum Likelihood
* [Standardized T Log-likelihood (degree of freedom only)](/files/teaching/matlab/course/std_studentst_loglike.m)
* [Standardized T Log-likelihood for unconstrained optimization](/files/teaching/matlab/course/std_studentst_loglike_mean_var.m)
* [Standardized T Log-likelihood with mean and variance for unconstrained optimization](/files/teaching/matlab/course/std_studentst_loglike_mean_var_notrans.m)
* [Probit Log-likelihood](/files/teaching/matlab/course/probit_loglike.m)
* [OLS Function](/files/teaching/matlab/course/ols.m)

### Data Files (Raw)
* [Raw Data Files (Zipped)](/files/teaching/matlab/course/raw_data_files.zip)

### Data Files (mat)
#### Hilary
* [S&P 500 (FRED)](/files/teaching/matlab/course/sp500.mat)
* [USD/EUR Rate (FRED)](/files/teaching/matlab/course/usdeur.mat)
* [Core CPI (FRED)](/files/teaching/matlab/course/cpi.mat)
* [Term Premium (FRED)](/files/teaching/matlab/course/term.mat)
* [Default Premium (FRED)](/files/teaching/matlab/course/def.mat)
* [Government yields and GDF Deflator Data](/files/teaching/matlab/course/VAR_data.mat)
* [CAY cointegration data](/files/teaching/matlab/course/cay.mat)

#### Michaelmas
##### Equity Index Data
* [S&P 500 and FTSE 100 data](/files/teaching/matlab/course/SP_FTSE.mat)

##### Ken French Data
* [Ken French's Data](/files/teaching/matlab/course/FF_data.mat)

##### FX Rates
* [GBP-USD Exchange Rate](/files/teaching/matlab/course/GBPUSD.mat)
* [EUR-USD Exchange Rate](/files/teaching/matlab/course/EURUSD.mat)
* [AUD-USD Exchange Rate](/files/teaching/matlab/course/AUDUSD.mat)
* [JPY-USD Exchange Rate](/files/teaching/matlab/course/JPYUSD.mat)
-->