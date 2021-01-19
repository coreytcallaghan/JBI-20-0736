# JBI-20-0736
This repository contains code and data for: Callaghan et al. 2021. Urban tolerance of birds changes throughout the full annual cycle. Journal of Biogeography.

Please note that the entirety of the analysis can not be contained here due to excessive file sizes. eBird was downloaded from here (https://ebird.org/data/download) and stored in Google BigQuery in a private account. The summarized portions of these data are available in this repository, providing the monthly summaries. If other data or code not contained in this repository are sought, please email me at callaghan.corey.t@gmail.com.

Here, you will find code and data to conduct the main analyses. First, you will need to download the phylogenetic tree from here (https://birdtree.org/) and add it to the "Data/phylo" folder as "phy.tre". After this, the scripts will work to reproduce the analysis. The main scripts are contained in the "R/analysis" folder.

This code works under the following package and R versions:

R version 4.0.3 (2020-10-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows Server x64 (build 17763)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.1252  LC_CTYPE=English_United States.1252    LC_MONETARY=English_United States.1252 LC_NUMERIC=C                          
[5] LC_TIME=English_United States.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] RColorBrewer_1.1-2 forcats_0.5.0      lemon_0.4.5        wesanderson_0.3.6  ggrepel_0.8.2      scales_1.1.1       patchwork_1.1.0    phytools_0.7-70    maps_3.3.0        
[10] phylobase_0.8.10   phylosignal_1.3    phylolm_2.6.2      ape_5.4-1          MuMIn_1.43.17      snow_0.4-3         arm_1.11-2         lme4_1.1-25        Matrix_1.2-18     
[19] MASS_7.3-53        tibble_3.0.4       broom_0.7.2        tidyr_1.1.2        GGally_2.0.0       ggcorrplot_0.1.3   car_3.0-10         carData_3.0-4      ggplot2_3.3.2     
[28] readr_1.4.0        dplyr_1.0.2       

loaded via a namespace (and not attached):
  [1] readxl_1.3.1            uuid_0.1-4              backports_1.2.0         fastmatch_1.1-0         Hmisc_4.4-1             plyr_1.8.6              igraph_1.2.6           
  [8] lazyeval_0.2.2          sp_1.4-4                splines_4.0.3           listenv_0.8.0           rncl_0.8.4              digest_0.6.27           htmltools_0.5.0        
 [15] gdata_2.18.0            magrittr_1.5            checkmate_2.0.0         cluster_2.1.0           openxlsx_4.2.3          globals_0.13.1          gmodels_2.18.1         
 [22] prettyunits_1.1.1       jpeg_0.1-8.1            colorspace_1.4-1        haven_2.3.1             xfun_0.19               crayon_1.3.4            phangorn_2.5.5         
 [29] survival_3.2-7          glue_1.4.2              gtable_0.3.0            seqinr_4.2-4            future.apply_1.6.0      abind_1.4-5             DBI_1.1.0              
 [36] Rcpp_1.0.5              plotrix_3.7-8           xtable_1.8-4            progress_1.2.2          spData_0.3.8            htmlTable_2.1.0         tmvnsim_1.0-2          
 [43] units_0.6-7             foreign_0.8-80          spdep_1.1-5             Formula_1.2-4           stats4_4.0.3            htmlwidgets_1.5.2       httr_1.4.2             
 [50] ellipsis_0.3.1          pkgconfig_2.0.3         reshape_0.8.8           XML_3.99-0.5            nnet_7.3-14             deldir_0.2-2            tidyselect_1.1.0       
 [57] rlang_0.4.8             reshape2_1.4.4          later_1.1.0.1           munsell_0.5.0           adephylo_1.1-11         cellranger_1.1.0        tools_4.0.3            
 [64] generics_0.1.0          ade4_1.7-16             stringr_1.4.0           fastmap_1.0.1           knitr_1.30              zip_2.1.1               purrr_0.3.4            
 [71] future_1.20.1           nlme_3.1-149            mime_0.9                adegenet_2.1.3          xml2_1.3.2              compiler_4.0.3          rstudioapi_0.11        
 [78] curl_4.3                png_0.1-7               e1071_1.7-4             clusterGeneration_1.3.5 statmod_1.4.35          RNeXML_2.4.5            stringi_1.5.3          
 [85] lattice_0.20-41         classInt_0.4-3          nloptr_1.2.2.2          vegan_2.5-6             permute_0.9-5           vctrs_0.3.4             pillar_1.4.6           
 [92] LearnBayes_2.15.1       lifecycle_0.2.0         combinat_0.0-8          data.table_1.13.2       raster_3.3-13           httpuv_1.5.4            R6_2.5.0               
 [99] latticeExtra_0.6-29     promises_1.1.1          KernSmooth_2.23-17      gridExtra_2.3           rio_0.5.16              parallelly_1.21.0       codetools_0.2-16       
[106] boot_1.3-25             gtools_3.8.2            withr_2.3.0             mnormt_2.0.2            mgcv_1.8-33             expm_0.999-5            parallel_4.0.3         
[113] hms_0.5.3               quadprog_1.5-8          grid_4.0.3              rpart_4.1-15            coda_0.19-4             class_7.3-17            minqa_1.2.4            
[120] sf_0.9-6                scatterplot3d_0.3-41    numDeriv_2016.8-1.1     shiny_1.5.0             base64enc_0.1-3
