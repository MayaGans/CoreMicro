CoreMicro
=========

<!-- badges: start -->
<!-- badges: end -->

The goal of CoreMicro is to …

Installation
------------

You can install the released version of CoreMicro from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("CoreMicro")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(CoreMicro)

arabidopsis %>% # use built in dataset
  core_methods() %>% # create taxa presence absence table per core method
  core_plots() # plot using hexbins
```

![](man/figures/plot.png)
