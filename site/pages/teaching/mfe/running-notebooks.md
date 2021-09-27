<!--
.. title: Installing the MFE package
.. slug: running-notebooks
.. date: 2020-11-27 17:51:05 UTC
.. tags: teaching, mfe
.. category: teaching 
.. link: 
.. description: Instructions for installing the mfe package
.. type: text
.. jumbotron_color: #002147
.. jumbotron_light: True
.. jumbotron: Running Notebooks
.. jumbotron_text: Installing the required package to run most notebook code
-->

The mfe package is one I use to prepare the slides.  It is not polished, but I am happy to
share it so that you can install it on your computer.  This is not a requirement, but is necessary
if you want to run the notebook code I have shared.

1. Download the [MFE package](/files/teaching/mfe/mfe-1.0.tar.gz) to your computer and make note of the download location.
2. Install the package using `pip`.  You can do this inside IPython or Jupyter by entering the command

```
%pip install <full-path-to>/mfe-1.0.tag.gz
```

`<full-path-to>` should be the path to the gzip. Windows users should usually place `mfe-1.0.tag.gz` in the same directory
as the Jupyter notebook so that the package can be installed using 

```
%pip install mfe-1.0.tag.gz
```
