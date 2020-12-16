"""
This is a mock of the format that is expected for the
demo-autograder-pw2. The autograder will import this file and
then run the function. Your file should import anything
that is needed to run.

Your file can have any legal python file name. For example

my_solutions.py
mfe_computational_assignment-2.py
autograder-submiission.py

are all reasonable names.

It should not have your actual name in it anywhere.

The functions names must match **exactly** including _ and capitalization.
Input variable names should also match, so that the autograder could
call

summary_statistics(returns=x)

or just

summary_statistics(x)
"""

# Any imports your code needs must be imported in your solutions file
import numpy as np
import pandas as pd
from pandas import Series, DataFrame


# The funny returns: Series is how we can tell smart editors like PyCharm
# or VS Code that returns is a pandas Series. These editors can then help
# us to autocomplete available methods. This is optional, and
# def summary_statistics(prices):
# will work just as well
def oos_rsquared(y: Series, yhat: Series, mu: float):
    """
    Compute the out-of-sample R2

    Parameters
    ----------
    y : Series
        Series containing out-of-sample realizations of a time series
    yhat : Series
        Series containing out-of-sample forecasts of the time series
    mu : Series
        The in-sample mean of y

    Returns
    -------
    r2 : float
        The out-of-sample R2
    """
    # Your code goes here.
    r2 = 0.0

    return r2


def oos_residuals(y: Series, x: DataFrame, beta: Series, first: str, last: str):
    """
    Computes residuals for a fixed period of time given data and regression coeff.

    Parameters
    ----------
    y : Series
        DataFrame containing the left-hand-side variable
    x : DataFrame
        DataFrame containing regressors.  Shape is n by k.
    beta : Series
        Series with shape k containing regression coefficients.
    first : Series
        String date compatible with pandas DatetimeIndex.  Always before last.
    last : Series
        String date compatible with pandas DatetimeIndex.  Always after first.

    Returns
    -------
    resid : Series
        A Series with shape n. The shape is determined by first and last.
    """
    # Your code goes here.
    # Be sure to replace mle and moment with the correct code
    resid = y[first:last] - 0.0
    return resid
