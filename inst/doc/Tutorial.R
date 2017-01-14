## ---- eval=FALSE---------------------------------------------------------
#  install.packages('fbar)

## ---- eval=FALSE---------------------------------------------------------
#  devtools::install('maxconway/fbar')

## ---- eval=FALSE---------------------------------------------------------
#  ROI::ROI_registered_solvers()
#  install.packages('ROI.plugin.ecos')
#  library('ROI.plugin.ecos') # This line is necessary to register the plugin with ROI the first time
#  ROI::ROI_registered_solvers()

## ------------------------------------------------------------------------
data(ecoli_core)

## ------------------------------------------------------------------------
ecoli_fluxes <- ecoli_core %>% 
  reactiontbl_to_expanded() %>% 
  expanded_to_ROI() %>% 
  ROI::ROI_solve() %>% 
  ROI::solution()

ecoli_core_evaluated <- ecoli_core %>%
  mutate(flux = ecoli_fluxes)

## ------------------------------------------------------------------------
evaluated <- find_fluxes_df(ecoli_core)

