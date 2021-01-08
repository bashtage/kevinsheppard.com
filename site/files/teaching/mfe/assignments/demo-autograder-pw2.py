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
FILENAME = "solutions-pw2.py"
FILE = os.path.join(ROOT, FILENAME)
mod = SourceFileLoader(FILENAME.split(".py")[0], FILE).load_module()


# In[ ]:


rg = np.random.default_rng(38218301830131)
index = pd.bdate_range("2020-01-01", periods=500, freq="D")
y = pd.Series(rg.standard_normal(500), index=index)
yhat = pd.Series(rg.standard_normal(500), index=index)
mu = 0.0


output = mod.oos_rsquared(y, yhat, mu)
assert isinstance(output, float)
assert output >= -1000.0


# In[ ]:


index = pd.bdate_range("1950-01-01", periods=250, freq="M")
y = pd.Series(rg.standard_normal(250), index=index)
k_max = 7
columns = [f"x{i}" for i in range(1, k_max + 1)]
x = pd.DataFrame(rg.standard_normal((250, k_max)), columns=columns, index=index)
beta = pd.Series(np.ones(k_max), index=columns)
first = "1955"
last = "1965"
resid = mod.oos_residuals(y, x, beta, first, last)
isinstance(resid, pd.Series)
assert resid.shape == y[first:last].shape

