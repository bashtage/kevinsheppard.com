<!--
.. title: MFE Computational Assignment 4 FAQ
.. slug: mfe-computational-exercise-4-faq
.. date: 2021-03-11 09:01:25 UTC
.. tags: 
.. category: 
.. link: 
.. description: 
.. type: text
-->

## Using `AutoReg` to generate out-of-sample predictions

`AutoReg` can be used twice to produce out-of-sample predictions. The first
uses the data that is used to estimate parameters. The second uses all of the
data and then calls `predict` using the parameters estimated on the in-sample
data.

```python
import numpy as np
from statsmodels.tsa.api import AutoReg

# Simulate some data
tau = 100
y = np.random.standard_normal(tau)

# Fit using first half, tau//2
mod = AutoReg(y[:tau//2], lags=1, trend="c", old_names=False)
res = mod.fit()

# Full-sample model
oos_mod = AutoReg(y, lags=1, trend="c", old_names=False)
# One-step predictions
oos_1step = oos_mod.predict(res.params)
# OOS Random Walk predictions
oos_rw = oos_mod.predict([0, 1])

# Get second half of both
# Use -tau//2: to get second half
oos_1step = oos_1step[-tau//2:]
oos_rw = oos_rw[-tau//2:]
```
