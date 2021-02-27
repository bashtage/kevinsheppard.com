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


import glob
import os
from importlib.machinery import SourceFileLoader

import numpy as np
import pandas as pd

ROOT = os.getcwd()
FILENAME = "solutions-fw1.py"
FILE = os.path.join(ROOT, FILENAME)
mod = SourceFileLoader(FILENAME.split(".py")[0], FILE).load_module()


# In[ ]:


rg = np.random.default_rng(38218301830131)
index = pd.bdate_range("2020-01-01", periods=500, freq="D")
rets = pd.Series(rg.standard_normal(500), index=index)
lam = 0.9
window = 120
p = 0.95

var_forecast = mod.weighted_hs(rets, lam, window, p)
t = rets.shape[0]
assert isinstance(var_forecast, pd.Series)
assert var_forecast.shape == rets.shape
assert np.all(var_forecast.index == rets.index)
assert np.all(np.isnan(var_forecast.iloc[:window - 1]))


# In[ ]:


import datetime as dt

initial = dt.datetime(2021, 2, 1, 9, 30, 0)
delta = dt.timedelta(minutes=1)
index = [initial + dt.timedelta(minutes=i) for i in range(390)]
rets = pd.Series(rg.standard_normal(390), index=index)
k = 10
rv = mod.subsampled_rv(rets, k)

assert isinstance(rv, float)
assert rv >= 0.0


# In[ ]:


rho = 0.75
y0 = 1 / np.sqrt(1 - 0.75 ** 2) * rg.standard_normal()
errors = rg.standard_normal(1000)
y = mod.ar1_simulate(rho, errors, y0)

assert isinstance(y, np.ndarray)
assert y.shape == errors.shape

