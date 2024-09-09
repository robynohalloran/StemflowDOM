
#------------------------------------------------------------------------------

# READ THIS FIRST
# This script is intended to take a set of exported .dat files from an Aqualog Horiba
# of stemflow EEMs as descrbid in O'Halloran et al., 2024 along with the EEMs
# provided in that manuscript as the modeled data set in order to use for 
# multivariate regression models for the estimation of ligning, TMY, and S/G ratios
# in stemflow from trees. To use this script, you need to have R installed with the following
# packages: staRdom and dplyr. If they are not already installed, use install.packages("staRdom") and then install.packages("dyplr")
# Also make sure your working directory in R is in an appropriate place for where files will be exported. 
# To use: 
# Highlight, copy and paste each section between comments one at a time into the R Console.
# This will help ensure that each step is being completed successfully. 
#------------------------------------------------------------------------------

# This loads the libraries in R that you need:
rm(list=ls())
library("staRdom")
library("dplyr") 
#------------------------------------------------------------------------------

# This section loads your dataset and your metatable prepared as described in the tutorial in O'Halloran et al., 2024
# You need to change working directory for each of hte files here to match your computer and their filenames:
eem_list <- eem_read("C:\\Users\\robynoh\\Desktop\\Research\\PARAFAC PAPER\\PARAFAC\\data", recursive = FALSE, import_function = "aqualog")
meta <- read.csv("C:\\Users\\robynoh\\Desktop\\Research\\PARAFAC PAPER\\PARAFAC\\metadata.csv", header = TRUE, sep = ",", dec=".", row.names = 1)
problem<-eem_checkdata(eem_list,absorbance,meta,metacolumns=c("dilution","raman"),error=FALSE)
#-------------------------------------------------------------------------------

# This section removes the rayleigh scatters and crops the EEMs to the regions to be modeled, along with the PARAFAC variables needed for analysis. 
# DO NOT CHANGE
eem_list<-eem_raman_normalisation2(eem_list,meta['raman'])
remove_scatter<-c(TRUE,TRUE,TRUE,TRUE)
remove_scatter_width<-c(30,0,25,40)# default is all 15's - most likely will do 30,0,25,40
eem_list2 <- eem_rem_scat(eem_list, remove_scatter = remove_scatter, remove_scatter_width = remove_scatter_width)
eem_list2<-eem_list2%>%eem_range(ex=c(256,Inf),em=c(0,580))
eem_list3<-eem_interp(eem_list2, type=1,extend=FALSE)
eem_list4<-eem_list3
dim_min <-3 #minimum number of components
dim_max<-6 #maximum number of components
nstart<-25 # number of similar models from which best is chosen
maxit = 5000 #maximum number of iterations in PARAFAC analysis
ctol <- 10^-6
ctol1<-10^-8
nstart1=50
maxit1=10000
#-------------------------------------------------------------------------------

# This section is for adding in your samples. You will add in the name of each of your samples into the exclude list below :
exclude1<-list("ex"=c(),"em"=c(),"sample"=c("F1June2222","B3Apr1822","F1Apr1822"))
eem_list4_ex<-eem_exclude(eem_list4,exclude1)
#-------------------------------------------------------------------------------

# This section generates the PARAFAC model described in O'Halloran et al., 2024 that your stemflow EEMs will be modeled agains
# DO NOT CHANGE.
pf4n <- eem_parafac(eem_list4_ex, comps = 4, normalise = TRUE, const = c("nonneg", "nonneg", "nonneg"), maxit = maxit1, nstart = nstart1, ctol = ctol1,output="all", strictly_converging = TRUE)
#-------------------------------------------------------------------------------

# This section will fit the PARAFAC model to the EEMs in your dataset.
# DO NOT CHANGE
pf4n<-lapply(pf4n,eempf_rescaleBC,newscale="Fmax")
eempf_comp_names(pf4n) <- c("C1","C2","C3","C4")
pf4n[[1]] %>%
  ggeem(contour = TRUE)
pf4_wOutliers <- A_missing(eem_list4, pfmodel = pf4n[[1]])
#-------------------------------------------------------------------------------

# This section will export the loadings of your EEMs and those from the original dataset in O'Halloran et al (2024)
# Refer to the tutorial in O'Halloran et al. 2024 to obtain percent contributions for use with multivariate fitted models
eempf_export(pf4_wOutliers, export = "parafac_export.txt", Fmax=TRUE)

