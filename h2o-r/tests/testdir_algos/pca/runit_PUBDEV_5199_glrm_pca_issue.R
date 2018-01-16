setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../../scripts/h2o-r-test-setup.R")

check.pca.glrm <- function() {
  my_data <- iris
  my_h2o_data <- as.h2o(my_data)
  
  # Confirm number of columns in dataset ()
  ncol(my_h2o_data)
  
  # Example GLRM Code - my_h2o_data includes a categorical variable
  my_pca <-
    h2o.glrm(
      training_frame = my_h2o_data,
      k = 2,
      loss = "Quadratic",
      transform = "STANDARDIZE",
      regularization_x = "None",
      max_iterations = 1000,
      seed = 21,
      recover_svd=T
    )
  
  print(my_pca@model$importance)
  
  
  # Example GLRM Code - my_h2o_data_subset does not include a categorical variable (Species) and this is no longer an issue
  my_h2o_data_subset <- my_h2o_data[, -5]
  
  my_pca_nocat <-
    h2o.glrm(
      training_frame = my_h2o_data_subset,
      k = 2,
      loss = "Quadratic",
      transform = "STANDARDIZE",
      regularization_x = "None",
      max_iterations = 1000,
      seed = 21,
      recover_svd=T
    )
  
  print(my_pca_nocat@model$importance)
}

doTest("PCA glrm", check.pca.glrm)