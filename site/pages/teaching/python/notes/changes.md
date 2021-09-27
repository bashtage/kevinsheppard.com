<!--
.. title: Changes Log
.. slug: changes
.. hidetitle: True 
.. date: 2019-09-02 11:27:39 UTC+01:00
.. tags: python
.. category: teaching
.. link: 
.. description: Changes to Introduction to Python for Econometrics, Statistics and Numerical Analysis  
.. type: text
-->

# Changes to _Introduction to Python for Econometrics, Statistics and Numerical Analysis_

## Fifth Edition

- Python 3.8 or 3.9 are the recommended versions.
- Added a chapter on code style.
- Expanded coverage of random number generation and added coverage of the preferred method to generate random variates, numpy.random.Generator..
- Verified that all code and examples work correctly against 2021 versions of modules.
- Added coverage of context managers (`with` _method_ `as` _variable_) as the preferred way to open and close files.
- Changed examples to use context managers where appropriate.

## Fourth edition

- Python 3.8 is the recommended version. The notes require Python 3.6 or later, and all references to Python 2.7 have been removed.
- Removed references to NumPy's matrix class and clarified that it should not be used.
- Verified that all code and examples work correctly against 2020 versions of modules. The notable packages and their versions are:
   -  Python 3.8 (Preferred version), 3.6 (Minimum version)
   -  NumPy: 1.19.1
   -  SciPy: 1.5.2
   -  pandas: 1.1.1
   -  matplotlib: 3.3.1
- Introduced f-Strings in Section [subsec:f-Strings] as the preferred way to format strings using modern Python. The notes use f-String where possible instead of format.
- Added coverage of Windowing function – rolling, expanding and ewm – to the pandas chapter.
- Expanded the list of packages of interest to researchers working in statistics, econometrics and machine learning.
- Expanded description of model classes and statistical tests in statsmodels that are most relevant for econometrics. Added section detailing formula support. This list represents on a small function of the statsmodels API. 
- Added minimize as the preferred interface for non-linear function optimization in Chapter [chap:Non-linear-Function-Optimization].
- Python 2.7 support has been officially dropped, although most examples continue to work with 2.7. Do not Python 2.7 for numerical code.
- Small typo fixes, thanks to Marton Huebler.
- Fixed direct download of FRED data due to API changes, thanks to Jesper Termansen.
- Thanks for Bill Tubbs for a detailed read and multiple typo reports.
- Updated to changes in line profiler (see Ch. [chap:performance-and-optimization])
- Updated deprecations in pandas.
- Removed hold from plotting chapter since this is no longer required.
- Thanks for Gen Li for multiple typo reports.

## Third edition, Update 1
-  Verified that all code and examples work correctly against 2019 versions of modules. The
   notable packages and their versions are:
   -  Python 3.7 (Preferred version)
   -  NumPy: 1.16
   -  SciPy: 1.3
   -  pandas: 0.25
   -  matplotlib: 3.1
-  Python 2.7 support has been officially dropped, although most examples continue to work with 2.7.
   **Do not Python 2.7 in 2019 for numerical code**.

## Third edition update

-   Rewritten installation section focused exclusively on using
    Continuum\'s Anaconda.
-   Python 3.5 is the default version of Python instead of 2.7. Python
    3.5 (or newer) is well supported by the Python packages required to
    analyze data and perform statistical analysis, and bring some new
    useful features, such as a new operator for matrix multiplication
    (@).
-   Removed distinction between integers and longs in built-in data
    types chapter. This distinction is only relevant for Python 2.7.
-   dot has been removed from most examples and replaced with @ to
    produce more readable code.
-   Split Cython and Numba into separate chapters to highlight the
    improved capabilities of Numba.
-   Verified all code working on current versions of core libraries
    using Python 3.5.
-   pandas
    -   Updated syntax of pandas functions such as resample.
    -   Added pandas Categorical.
    -   Expanded coverage of pandas groupby.
    -   Expanded coverage of date and time data types and functions.
-   New chapter introducing statsmodels, a package that facilitates
    statistical analysis of data. statsmodels includes regression
    analysis, Generalized Linear Models (GLM) and time-series analysis
    using ARIMA models.

## Second edition update

-   Improved Cython and Numba sections
-   Added sections discussing interfacing with C code
-   Added sections to the chapter on running code in Parallel covering
    IPython\'s cluster server and joblib
-   Further improvements in the installation based on feedback from the
    [Python Course]()
-   Updated Anaconda to 1.9
-   Added information about using Spyder as an initial IDE.
-   Added packages for Spyder to the installation instructions.

### New in second edition

-   The preferred installation method is now Continuum Analytics\'
    Anaconda. Anaconda is a complete scientific stack and is available
    for all major platforms.
-   New chapter on pandas. pandas provides a simple but powerful tool to
    manage data and perform basic analysis. It also greatly simplifies
    importing and exporting data.
-   New chapter on advanced selection of elements from an array.
-   Numba provides just-in-time compilation for numeric Python code
    which often produces large performance gains when pure NumPy
    solutions are not available (e.g. looping code).
-   Addition to performance section covering line_profiler for
    profiling code.
-   Dictionary, set and tuple comprehensions.
-   Numerous typos fixed.
-   All code has been verified working against Anaconda 1.7.0.
