liberalmin <- function(a1, a2){
  if(is.na(a1) && is.na(a2)){
    return(NA)
  }else{
    min(a1, a2, na.rm=TRUE)
  }
}
liberalmax <- function(a1, a2){
  if(is.na(a1) && is.na(a2)){
    return(NA)
  }else{
    max(a1, a2, na.rm=TRUE)
  }
}

#' @import assertthat
multi_subs <- function(names, presences){
  assert_that(is.character(names))
  assert_that(are_equal(length(names), length(presences)))
  
  e <- new.env(parent=emptyenv())
  assign('unmapped', TRUE, e)
  
  for(i in 1:length(names)){
    assign(names[i], presences[i], pos=e)
  }
  
  return(e)
}

#' Function to estimate the expression levels of gene sets
#' 
#' @param gene_sets A list of gene set strings: names of genes punctuated with \code{&}, \code{|} and brackets.
#' @param genes A list of gene names
#' @param presences A list of gene presences, the same length as \code{genes}
#' 
#' @return a vector the same length as \code{gene_sets}, with the the calculated combined gene expression levels.
#' 
#' This function evaluates the gene sets in the context of the gene presences. 
#' It can take booleans, or numbers, in which case it associates \code{&} with finding the minimum, and \code{|} with finding the maximum.
#' 
#' @section Warning:
#' This function uses \code{\link{eval}} to evaluate gene expression sets. 
#' This gives flexibility, but means that malicious code in the \code{gene_sets} argument could get evaluated.
#' \code{gene_sets} is evaluated in a restricted environment, but there might be a way around this, so you might want to check for anything suspicious in this argument manually.
#' For more information, read the code.
#' 
#' @seealso gene_associate
#' @export
gene_eval <- function(gene_sets, genes, presences){
  gene_sets[gene_sets=='' | is.na(gene_sets)] <- NA
  e <- multi_subs(genes, presences)
  
  assign('&', liberalmin, e)
  assign('|', liberalmax, e)
  assign('(', `(`, e)
  
  purrr::map_dbl(gene_sets, function(x){
    eval(parse(text=x),e)
  })
}