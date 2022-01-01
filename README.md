# rQPCR

The rQPCR package provide three functions listed as below. 
- **import_data**:	Import the raw data file and infer the replicates and the ct range.(Now only support Applied Biosystems™ 7500 Real-Time PCR System) 
- **qview_data**:	Create an overview of the Ct value of all samples
- **Calculate_relative_exp**:	Calculate the relative expression using delta delta Ct method

The main motivation of this package is to combine ggplot and plotly to visualize the Ct value of all samples in one figure, which can help me quickly identify the wells that the technical replicates don't work well.

## How to install?

```r
library(devtools)
devtools::install_github("whzemuch/rqpcr/")
```
