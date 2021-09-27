<!--
.. title: MFE Toolbox
.. slug: mfe-toolbox
.. date: 2019-09-11 09:39:56 UTC+01:00
.. tags: 
.. category: 
.. link: 
.. description: Download the MFE tool box for MATLAB which contains many common estimators used in financial econometrics
.. type: text
-->

The Oxford MFE Toolbox is the follow on to the [UCSD\_GARCH](/code/matlab/ucsd-garch/)
toolbox. It has been widely used by students here at Oxford, and represents a
substantial improvement in robustness over the original UCSD GARCH code,
although in its current form it only contains univariate routines.

[TOC]


## Current Version

The latest version, including any work in progress, can be downloaded on
the [GitHub repository for the MFE Toolbox](https://github.com/bashtage/mfe-toolbox/)
([Direct link to zip](https://github.com/bashtage/mfe-toolbox/archive/main.zip)).

### Last Updated 

June 7, 2013

### Update News

Many changes have occurred since the last release. The most notable are:

-   A major rework of the subsampling in the Realized code
-   Modern versions of BEKK (Scalar, Diagonal and Full) and RARCH, a
    recent model by Diaa Noureldin, Neil Sheppard and me.
-   DCC, BEKK and HEAVY are all finally available in this toolbox, and
    so the retirement of the UCSD GARCH toolbox is almost ready.
-   OGARCH and GOGARCH have been added.
-   RCC, an alternative to DCC, is also available (by Diaa Noureldin,
    Neil Sheppard and Kevin Sheppard).

The next developments should include the TODO include:

-   SARIMA
-   Clean up of unused files and more coherent naming

## Code

[Oxford MFE Toolbox](https://github.com/bashtage/mfe-toolbox/archive/main.zip)

## Documentation

[Oxford MFE Toolbox Documentation](/files/code/matlab/mfe-toolbox-documentation.pdf)


## High Level List of Functions 

-   Regression
-   ARMA Simulation
-   ARMA Estimation
    -   Heterogeneous Autoregression
    -   Information Criteria
-   ARMA Forecasting
-   Sample autocorrelation and partial autocorrelation
-   Theoretical autocorrelation and partial autocorrelation
-   Testing for serial correlation
    -   Ljung-BoxQ Statistic
    -   LM Serial Correlation Test
-   Filtering
    -   Baxter-King Filtering
    -   Hodrick-Prescott Filtering
-   Regression with Time Series Data
-   Long-run Covariance Estimation
    -   Newey-West covariance estimation
    -   Den Hann-Levin covariance estimation
-   Nonstationary Time Series
-   Unit Root Testing
    -   Augmented Dickey-Fuller testing
    -   Augmented Dickey-Fuller testing with automated lag selection
-   Vector Autoregressions
    -   Granger Causality Testing: grangercause
    -   Impulse Response function calculation
-   Volatility Modeling
    -   ARCH/GARCH/AVARCH/TARCH/ZARCH Simulation
    -   EGARCH Simulation
    -   APARCH Simulation
    -   FIGARCH Simulation
-   GARCH Model Estimation
    -   ARCH/GARCH/GJR-GARCH/TARCH/AVGARCH/ZARCH Estimation
    -   EGARCH Estimation
    -   APARCH Estimation
    -   AGARCH and NAGARCH estimation
    -   IGARCH estimation
    -   FIGARCH estimation
    -   HEAVY models
-   Density Estimation
    -   Kernel Density Estimation
-   Distributional Fit Testing
    -   Jarque-Bera Test
    -   Kolmogorov-Smirnov Test
    -   Berkowitz Test
-   Bootstraps
    -   Block Bootstrap
    -   Stationary Bootstrap
-   Multiple Hypothesis Tests
    -   Reality Check and Test for Superior Predictive Accuracy
    -   Model Confidence Set
-   Multaivariate GARCH
    -   CCC MVGARCH
    -   Scalar Variance Targetting VECH
    -   MATRIX GARCH
    -   DCC and ADCC
    -   OGARCH
    -   GOGARCH
    -   RARCH
-   Realized Measures
    -   Realized Variance
    -   Realized Covariance
    -   Realized Kernels
    -   Multivariate Realized Kernels
    -   Realized Quantile Variance
    -   Two-scale Realized Variance
    -   Multi-scale Realized Variance
    -   Realized Range
    -   QMLE Realized Variance
    -   Min Realized Variance, Median Realized Variance (MinRV, MedRV)
    -   Integrated Quarticity Estimation

### Functions Missing from Previous UCSD GARCH Toolbox

The following list of function have not been updated and so if needed,
you should continue to use the [UCSD GARCH](/code/matlab/ucsd-garch/) code.

-   GARCH in mean
-   IDCC MVGARCH
-   Shapirowilks
-   Shapirofrancia
