"""
This is a mock of the format that is expected for the
demo-autograder-pw3. The autograder will import this file and
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

diebold_mariano(loss_a=loss_a, loss_b=loss_b, nw_bandwidth=nw_bandwidth)

or just

diebold_mariano(loss_a, loss_b, nw_bandwidth)
"""

# Any imports your code needs must be imported in your solutions file
import numpy as np
import pandas as pd
from pandas import Series


# The funny returns: Series is how we can tell smart editors like PyCharm
# or VS Code that returns is a pandas Series. These editors can then help
# us to autocomplete available methods. This is optional, and
# def mincer_zarnowitz(realization, forecast)
# will work just as well
def mincer_zarnowitz(realization: Series, forecast: Series):
    """
    Mincer-Zarnowitz regression

    Parameters
    ----------
    realization : Series
        The realization of the data
    forecast : Series
        The corresponding forecast for each realization

    Returns
    -------
    parameters : Series
        Pandas Series with the two MZ regression parameters "alpha" and "beta"
    indiv_stats : Series
        Pandas Series with test statistics for the two MZ regression parameters
        H_0:"alpha"=0 and H_0:"beta"=1
    joint_stat : float
        A joint hypothesis test that the null of a correctly specified model is satisfied
    """

    parameters = pd.Series([-0.1, np.pi], index=["alpha", "beta"])
    indiv_stats = pd.Series([-1.0, 3.0], index=["alpha", "beta"])
    joint_stat = 1.0

    return parameters, indiv_stats, joint_stat


def diebold_mariano(loss_a: Series, loss_b: Series, nw_bandwidth: int):
    """
    Parameters
    ----------
    loss_a : Series
        The losses from forecast A
    loss_b : Series
        The losses from forecast B
    nw_bandwidth : int
        The Newey-West bandwidth to use

    Returns
    -------
    avg_diff : float
        The average difference of the losses
    std_err : float
        The standard error of the mean difference of the losses
    dm_stat : float
        The Diebold-Mariano test statistic
    concl : int
        The conclusion of the test. -1 if A is preferred, 0 if the
        null is not rejected and 1 if B is preferred.
    """
    avg_diff = -3.1
    std_err = 1.7
    dm_stat = -4.3
    concl = 0
    return avg_diff, std_err, dm_stat, concl
