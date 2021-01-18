#!/usr/bin/env python
# coding: utf-8

# # Demo Autograder
# 
# This file can be run against your code to understand the basics of how the autograder works.  The autograder:
# 
# * loads your file as a Python module
# * runs each function
# * checks the output of each function
# 
# The formal tests are not included. The tests included in this file are sanity checks.
# 
# To run this on your code, please the notebook in the same folder as your `.py` file. Then set `FILENAME` to the name of your file.  You should then be able to run it.  If you see an `AssertionError` then your code isn't passing a sanity check.

# In[ ]:


from importlib.machinery import SourceFileLoader
import pandas as pd
import os
import glob
import pandas as pd
import numpy as np

ROOT = os.getcwd()
FILENAME = "solutions-pw3.py"
FILE = os.path.join(ROOT, FILENAME)
mod = SourceFileLoader(FILENAME.split(".py")[0], FILE).load_module()


# In[ ]:


rg = np.random.default_rng(38218301830131)
index = pd.bdate_range("2020-01-01", periods=500, freq="D")
realization = pd.Series(rg.standard_normal(500), index=index)
forecast = pd.Series(rg.standard_normal(500), index=index)

parameters, indiv_stats, joint_stat = mod.mincer_zarnowitz(realization, forecast)
assert isinstance(parameters, pd.Series)
assert isinstance(indiv_stats, pd.Series)
assert isinstance(joint_stat, float)
assert list(parameters.index) == ["alpha", "beta"]
assert list(indiv_stats.index) == ["alpha", "beta"]
assert joint_stat >= 0.0


# In[ ]:


index = pd.bdate_range("1950-01-01", periods=250, freq="M")
loss_a = pd.Series(rg.standard_normal(250)** 2, index=index)
loss_b = pd.Series(rg.standard_normal(250)** 2, index=index)
nw_bandwidth = 7

avg_diff, std_err, dm_stat, concl = mod.diebold_mariano(loss_a, loss_b, nw_bandwidth)
assert isinstance(avg_diff, float)
assert isinstance(std_err, float)
assert isinstance(dm_stat, float)
assert isinstance(concl, int)
assert np.sign(avg_diff) == np.sign(dm_stat)
assert std_err >= 0.0
assert concl in (-1, 0, 1)

