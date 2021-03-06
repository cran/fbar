% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convenience_wrappers.R
\name{find_flux_variability_df}
\alias{find_flux_variability_df}
\title{Given a metabolic model as a data frame, return a new data frame with fluxes and variability}
\usage{
find_flux_variability_df(reaction_table, folds = 10, do_minimization = TRUE)
}
\arguments{
\item{reaction_table}{a data frame representing the metabolic model}

\item{folds}{number of times to calculate fluxes}

\item{do_minimization}{toggle to uniformly minimize all non-objective fluxes after finding the objective}
}
\value{
reaction_table with two added columns: sd (the standard deviation of fluxes found) and flux (a typical flux) from this distribution
}
\description{
This function calculates fluxes \code{folds} times with shuffled versions of the metabolic model.
This is designed to detect and quantify underdetermined fluxes.
}
\details{
This function uses ROI, so to solve models, you will need a solver plugin for ROI. Probably the easiest one to install is ROI.plugin.glpk.
To install this in Linux, run \code{sudo apt-get install libglpk-dev} in a terminal, and then run \code{install.packages('ROI.plugin.glpk')} in R.
}
