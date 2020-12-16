<!--
.. title: UCSD Garch
.. slug: ucsd-garch
.. date: 2019-09-12 15:04:43 UTC+01:00
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
-->

!!! warning "DEPRECATED"
    **The UCSD GARCH has been deprecated and will receive no further 
    updates. Recent changes in MATLAB have broken many of the functions in 
    the UCSD GARCH toolbox. Please use the [MFE Toolbox](/code/matlab/mfe-toolbox/) which is the 
    successor to the UCSD GARCH toolbox.**


# Legacy UCSD Toolbox 

[TOC]

Before reporting bugs, please be sure you have the
latest version, have downloaded the [JPL toolbox](http://www.spatial-econometrics.com/), and ARE NOT using the
ucsd\_garch code from the JPL toolbox (and don't have that directory on
your path)

The UCSD\_Garch toolbox is a toolbox for Matlab that is useful in
estimating and diagnosing univariate and multivariate heteroskedasticity
in a Time Series models. The toolbox contains C-Mex files for the
necessary loops in the univariate models. It is being released under a
BSD style [license]. This means you can do pretty much what ever you
want to including make money by selling it.

[Download](/files/code/matlab/ucsd_garch.zip)

### Updates

2.0.14: Thanks for Mark Flood who pointed out an old bug in fattailed
garch. Even more reason to **move to the [MFE Toolbox](/code/matlab/mfe-toolbox/) if possible**.

2.0.13: Thanks for Mark Flood who pointed out an initialization bug in
full\_bekk\_simulate.

2.0.12: Thanks to Dennis Turk who pointed out a bug in garchcore.m.

2.0.11: I have updated the mex files to work with more modern versions
of MATLAB and removed the 5.3 binaries. I also replaced the missing
tarchcore.m so that all functions in the toolbox run with or without
using the binary files.

2.0.10: New versions of bsds, bsds\_studentized, block\_bootstrap and
stationary\_bootstrap that use the latest version of Hansen's SPA paper

2.0.9.: Quite a few bug/inconsistencies squashed thanks to Paul Koufalas
and Lance Young

2.0.8: 2 bugs in dcc\_mvgarch and one in egarch squashed

2.0.7: A few more bugs squashed thanks to Hansen Chen

2.0.6: Fixed a couple of typos in the skewt garch functions

2.0.5: Fixed a bug in vech()

2.0.4: There is a Matlab limitation on filename length of 31 characters
on some versions. dagonal\_bekk\_mvgarch\_likelihood was 1 character too
long. It has been renamed diagonalBekkMVgarchLikelihood.

2.0.4: A bug was found in GARCHINMEAN. It is now fixed.

2.0.3: A huge bug was found in EGARCH. The original file was using
variances, not std devs. This is now fixed. Not\> I am unable to build
the 5.3 binary as I am out of the country. For now, egarchcore.dll is
only available for 6 and above.

Note: A few last minute bugs have been caught and the toolbox has been
fixed(Again!). Please fell free to contact ma about any errors you get
at <kevin.sheppard@economics.ox.ac.uk>.

## Help and Documentation
**UCSD_GARCH Toolbox, Version 2.0.10 21-APR-2007** 

* `ucsd_garch_demo` - A demo of the garch toolbox

#### Main Univariate Mean Functions
* `armaxfilter` - Univariate ARMAX estimation
* `mafilter` - Univariate MA estimation
* `garchinmean` - Univariate Garch-In-Mean estimation

#### Main Univariate GARCH Functions
* `garchpq_eviews` - Univariare GARCH estimation without lower bound constraints; uses a penalty funcion(similar to eviews)
* `skewt_garch` - Univariat GARCH estimation with skew-t residuals(Hansen)
* `tarch` - Univariate TARCH and GJR estimation
* `garchpq` - Univariate garch estimation with analytic derivatives
* `fattailed_garch` - Univariate GARCH estimation with normal, Students T and Generalized Error Distribution
* `multi_garch` - Univariate GARCH proceeedure to estimate a variety of GARCH specifications including AP GARCH
* `egarch` - Exponential garch estimation with normal, Students T and Generalized Error Distribution

#### Main Multivariate Functions
* `cc_mvgarch` - Estimates Bollerslev's Constant Correlation MV Garch
* `dcc_mvgarch` - Estimates Engle and Sheppard's Dynamic Correlation MV Garch
* `o_mvgarch` - Estimates Orthogonal or Factor MV Garch
* `scalar_bekk_mvgarch` - Estimates Engle and Kroner's Scalar Bekk MV Garch
* `diagonal_bekk_mvgarch` - Estimates Engle and Kroner's Diagonal Bekk MV Garch
* `full_bekk_mvgarch` - Estimates Engle and Kroner's Bekk MV Garch
* `Idcc_mvgarch` - Estimates Engle and Sheppards Integrated DCC MV Garch
* `scalar_bekk_T_mvgarch` - Estimates Scalar Bekk MV Garch with Multivariate T disturbances
* `diagonal_bekk_T_mvgarch` - Estimates Diagonal Bekk MV Garch with Multivariate T disturbances
* `full_bekk_T_mvgarch` - Estimates Full Bekk MV Garch with Multivariate T disturbances

#### Univariate Mean and GARCH Simulation
* `armaxsimulate` - Simulate an ARMAX model
* `garchsimulate` - Sumilate Univariate GARCH series with normal innovations
* `fattailed_garchsimulate` - Simulate Univariate GARCH series with Normal, Students T, or GED innovations
* `garcheviewssimulate` - Simulate a GARCH process with (some)negative smoothing terms
* `garchinmeansimulate` - Simulate a garch in mean model
* `egarchsimulate` - Simulate an EGARCH model
* `multigarchSimulate` - Simulate one of 8 different forms of GARCH
* `dcc_univariate_simulate` - likelihood function called from dcc_univariate_simulate

#### Multivaraite GARCH Simulation
* `scalar_bekk_simulate` - Simulate a scalar BEKK
* `diagonal_bekk_simulate` - Simulate a diagonal BEKK
* `full_bekk_simulate` - Simulate a full BEKK model
* `cc_mvgarch_simulate` - Simulates Bollerslev's Constant Correlation MV Garch
* `dcc_simulate` - Simulates Engle and Sheppard's Dynamic Correlation MV Garch

#### Univariate Mean Likelihood functions
* `garchinmeanlikelihood` - Likelihood funtion for garch in mean estimation
* `maxfilter_likelihood` - Likelihood function for MA estimation
* `armaxfilter_likelihood.m` - likelihood function called from armaxfilter

#### Univariate GARCH Likelihood Functions
* `garcheviewslikelihood` - likelihood function called from garchpq_eviews
* `skewt_garchlikelihood` - likelihood function called from skewt_garch
* `skewtdis_LL` - Log likelihod of a skew T distribution(helper)
* `garchlikelihood` - likelihood function called from garchpq
* `fattailed_garchlikelihood` - likelihood function called from fattailed_garch
* `multi_garchlikelihood` - likelihood function called from multi_garch
* `egarchlikelihood` - likelihood function called from egarch
* `tarchlikelihood


#### Multivariate GARCH Likelihood Functions
* `cc_mvgarch_full_likelihood` - likelihood function called from cc_mvgarch_full_likelihood
* `dcc_mvgarch_full_likelihood` - likelihood function called from dcc_mvgarch_full_likelihood(correct)
* `dcc_mvgarch_likelihood` - likelihood function called from dcc_mvgarch_likelihood(restricted)
* `diagonal_bekk_mvgarch_likelihood` - likelihood function called from diagonal_bekk_mvgarch_likelihood
* `full_bekk_mvgarch_likelihood` - likelihood function called from full_bekk_mvgarch_likelihood
* `scalar_bekk_mvgarch_likelihood` - likelihood function called from scalar_bekk_mvgarch_likelihood
* `Idcc_mvgarch_full_likelihood` - likelihood function called from IDCC_mvgarch_likelihood(correct)
* `Idcc_mvgarch_likelihood` - likelihood function called from IDCC_mvgarch_likelihood(used in estimation)
* `scalar_bekk_T_est_likelihood` - likelihood function called from scalar_T_bekk_mvgarch_likelihood(used in estimation)
* `diagonal_bekk_T_est_likelihood` - likelihood function called from diagonal_T_bekk_mvgarch_likelihood(used in estimation)
* `full_bekk_T_est_likelihood` - likelihood function called from full_T_bekk_mvgarch_likelihood(used in estimation)
* `scalar_bekk_T_likelihood` - likelihood function called from scalar_T_bekk_mvgarch_likelihood(correct)
* `diagonal_bekk_T_likelihood` - likelihood function called from diagonal_T_bekk_mvgarch_likelihood(correct)
* `full_bekk_T_likelihood` - likelihood function called from full_T_bekk_mvgarch_likelihood(correct)

#### Diagnostics
* `dcc_mvgarch_test` - Engle and Sheppards test for dynamic correlation
* `lilliefors` - Lillifors test for normality
* `ljq2` - Ljung-Box Q Test
* `lmtest1` - Lagrange Multiplier Test for autocorrelation
* `lmtest2` - Lagrange Multiplier Test for autocorrelation in the squarred residuals, an ARCH test
* `jarquebera` - Jarque-Bera test for normality
* `shapirowilks` - Shapiro-Wilks Test for normality
* `shapirofrancia` - Shapiro-Francia Test for normality
* `kolmogorov` - Kolmorogov-Shmirnov non-parametric test
* `berkowitz` - The berkowitz transform of the KS test

#### Kernel Smoothing Routines
* `cosinus` - Cosinus kernel
* `epanechnikov` - Epanechnikov kernel
* `kern_dens_contour` - Bivariate kernel density plot of a density contour
* `kern_dens_plot` - Univariate kernel density plot
* `kern_dens_plot2` - 3d bivariate kernel density plot
* `normal` - Normal kernel
* `quartic` - Quaritc kernel
* `triangular` - Triangular kernel
* `triweight` - Triweight kernel
* `uniform` - Uniform kernel

#### Bootstrap Routines
* `block_bootstrap` - Block time series bootstrap
* `bsds` - Bootstrap Data Snooper(White 2000, Hansen 2001) with upper, lower and consistent pvals
* `bsds_studentized` - Bootstrap Data Snooper, using studentized bootstraps(Hansen 2001)
* `cont_bootstrap` - Continuous Bootstrap for unit root data
* `stationary_bootstrap` - Stationary Bootstrap(Politis and Romano(1994)) for time series

#### Univariate Density Functions
* `exppowcdf` - Exponential Power Cumulative Density Function
* `exppowrnd` - Exponential Power Random number generator
* `exppowpdf` - Exponential Power Random Probability Density Function
* `gedcdf` - Generalized Error Distribution Cumulative Density Function
* `gedinv` - Generalized Error Distribution Inverse CDF
* `gedpdf` - Generalized Error Distribution Probability Density Function
* `gedrnd` - Generalized Error Distribution Random Number Generator
* `skewtdis_cdf` - Skew-T Cumulative Density Function
* `skewtdis_inv` - Skew-T Inverse CDF
* `skewtdis_pdf` - Skew-T Probability Density Function
* `skewtdis_rnd` - Skew-T Random Number Generator
* `stdtdis_cdf` - Standardized T distribution(unit variance for all nu) Cumulative Density Function
* `stdtdis_pdf` - Standardized T distribution(unit variance for all nu) Probability Density Function
* `stdtdis_rnd` - Standardized T distribution(unit variance for all nu) Random Number Generator

#### Helper Functions
* `kscritical` - Lookup table for KS critical values
* `cc_ivech` - Specialized ivech for correlation matrices
* `fx.mat` - a data set for foreign exchange return used by the demos
* `multi_garch_paramsetup` - helper function for multi_garch
* `multi_garch_constraints` - helper function for multi_garch
* `dcc_hessian` - A modified version of HESSIAN for use in with CC_MVGARCH and DCC_MVGARCH
* `ivech` - Creates a square lower triangular matrix, inverse of vech
* `vech` - Takes teh half-vec of a square matrix, inverse of ivech
* `lagmatrix` - Returns a matrix of lags of a dependant variable
* `pca` - Performs Principal Componet Analysis


C-MEX functions(should be compilable using any C compiler, binaries for Win32 provided)
NOTE: WHILE .M FILESARE AVAILABLE FOR ALL OF THESE, YOU SHOULD COMPILE THESE OR USE THE PROVIDED BINARIES
BINARIES END IN .DLL, MATLAB FUNCTIONS END IN .M, AND SOURCE ENDS IN .C

* `armaxcore` - Core routine for ARMAX
* `egarchcore` - Core routine for EGARCH
* `garchcore` - Core routine for GARCH and FATTAILED_GARCH
* `garchgrad` - Core routine for GARCH derivative estimation
* `garchinmeancore` - Core routine for Garch in mean estimation
* `multigarchcore` - Core routine for MULTIGARCH
* `ivech` - C version of ivech
* `vech` - C version of vech
* `maxcore` - Core routing for MA estimation
* `recserarcore` - C core for recserar
* `tarchcore` - Core routine for TARCH estimation
* `multigarchcore` - Core routine for MULTIGARCH

**NOTE**: This toolbox requires both MATLAB optimization toolbox and the excellent J.P.LeSage Library
available from www.spatial-econometrics.com

Copyright (c) 2001-2007 Kevin Sheppard All Rights Reserved.

# License

All of the documentation and software included in the UCSD_Garch toolbox for Matlab is copyrighted by Kevin Sheppard.

Copyright 2001-2007 Kevin Sheppard

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution. All advertising materials mentioning features or use of this software must display the following acknowledgement: This product includes software developed by the Kevin Sheppard. Neither the name of the University of California at San Diego nor Kevin Sheppard may be used to endorse or promote products derived from this software without specific prior written permission. THIS SOFTWARE IS PROVIDED BY KEVIN SHEPPARD ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL KEVIN SHEPPARD OR UCSD OR THE REGENTS OF THE UNIVERSITY OF CALIFORNIA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the authors and should not be interpreted as representing official policies, either expressed or implied, of the Regents of the University of California or UCSD.

Please feel free to contact the author at kevin.k.sheppard with comments, suggestions, or bugfixes.
