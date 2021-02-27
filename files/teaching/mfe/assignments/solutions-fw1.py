"""
This is a mock of the format that is expected for the
demo-autograder-pw4. The autograder will import this file and
then run the function. Your file should import anything
that is needed to run.

Your file can have any legal python file name. For example

my_solutions.py
mfe_computational_assignment-4.py
autograder-submiission.py

are all reasonable names.

It should not have your actual name in it anywhere.

The functions names must match **exactly** including _ and capitalization.
Input variable names should also match, so that the autograder could
call

weighted_hs(p=0.975, lam=0.9, rets=rets, sample_size=120)

or

weighted_hs(rets, 0.9, 120, 0.975)
"""

# Any imports your code needs must be imported in your solutions file
import numpy as np
import pandas as pd
from pandas import Series


# The funny returns: Series is how we can tell smart editors like PyCharm
# or VS Code that returns is a pandas Series. These editors can then help
# us to autocomplete available methods. This is optional, and
# def weighted_hs(rets, lam, window)
# will work just as well
def weighted_hs(rets: Series, lam: float, window: int, p: float):
    """
    Weighted Historical Simulation

    Parameters
    ----------
    rets : Series
        The returns
    lam : float
        The corresponding forecast for each realization
    window: int
        The size of the sample to use in the weighted VaR
    p : float
        The level of the VaR (e.g., 95%)

    Returns
    -------
    value_at_risk : Series
        The VaR forecast. Must have the same shape as rets with the
        VaR computed using observations up to and including observation t
        in position t. The first window - 1 should be NaN-filled.
    """

    value_at_risk = rets.copy()
    value_at_risk.iloc[:window - 1] = np.nan
    return value_at_risk


def ar1_simulate(rho: float, errors: np.ndarray, y0: float):
    """
    Simulate an AR(1)
    
    Parameters
    ----------
    rho : float
        The AR(1) coefficient
    errors : ndarray
        t-element array of shocks
    y0 : float
        The initial value

    Returns
    -------
    y : ndarray
        The simulated AR(1) as a t-element ndarray
    """

    return errors.copy()


def subsampled_rv(rets, k):
    """
    Subsampled RV

    Parameters
    ----------
    rets : Series
        High-frequency returns
    k : int
        The number of periods to subsample

    Returns
    -------
    rv_ss : float
        The subsampled RV.
    """

    return 1.0
