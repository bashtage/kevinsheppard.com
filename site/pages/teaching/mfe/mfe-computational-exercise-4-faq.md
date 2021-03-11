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

# Out-of-sample forecasts from `arch` models

Out-of-sample forecasting is simpler in models from the `arch` package since you
can use the argument `last_obs` in a call to `fit` to set the final observation.

```python
from arch.data import sp500
from arch import arch_model

rets = 100 * sp500.load()["Adj Close"].pct_change().dropna()
mod = arch_model(rets)
tau = rets.shape[0]
res = mod.fit(last_obs=tau//2)

oos = res.forecast()
onestep_variance = oos.variance.dropna()["h.1"]
print(onestep_variance.head())
```

which produces

```
Date
2009-01-02    7.752248
2009-01-05    7.178808
2009-01-06    6.672307
2009-01-07    6.830862
2009-01-08    6.317631
Name: h.1, dtype: float64
```