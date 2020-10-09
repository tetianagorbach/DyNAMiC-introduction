GenerateDataFromLatentChangeModel <- function(sample_size, attrition_rate,
                                              intercept_t1, intercept_change,
                                              var_t1, var_change, reliability,  self_feedback) {
  # generates data according to the latent change model
  require(mvtnorm)
  # reliability = var_true/(var_true + var_error) ->
   var_error_domaini_t1 =    (1 - reliability) /reliability * var_t1 #, for all i = 1,...,3.
   var_error_domaini_testj_t1 = (1 - reliability) /reliability * (var_t1 + var_error_domaini_t1) # for all i=1,...,3, j=1,...,3.
   var_cog_t2 = var_t1 + var_change + 2 * self_feedback * sqrt(var_t1 * var_change)
   var_error_domaini_t2 = (1 - reliability) / reliability * var_cog_t2 # for all i = 1,...,3
   var_error_domaini_testj_t2 = (1 - reliability) /reliability * (var_cog_t2 + var_error_domaini_t2) # for all i = 1,...,3
        
  var_matrix <- diag(26) * c(var_t1, var_change,  # matrix of covariances
                             rep(var_error_domaini_t1, 3), rep(var_error_domaini_testj_t1, 9),  # baseline
                             rep(var_error_domaini_t2, 3), rep(var_error_domaini_testj_t2, 9))
  
  var_matrix[1, 2] <- var_matrix[2, 1] <-  self_feedback * sqrt(var_change * var_t1) # add covariance between t1 and change
  errors <- rmvnorm(sample_size, rep(0, 26), var_matrix)
  
  cog_t1 <- intercept_t1 + errors[, 1]  # baseline
  dcog <- intercept_change + errors[, 2] # cognitive change
  cog_t2 <- cog_t1 + dcog
  
 # T1:
  domain1_t1 <- 1 * cog_t1 + errors[, 4]
  domain2_t1 <- 1 * cog_t1 + errors[, 5]
  domain3_t1 <- 1 * cog_t1 + errors[, 6]
  
  domain1_test1_t1 <- 1 * domain1_t1 + errors[, 7]
  domain1_test2_t1 <- 1 * domain1_t1 + errors[, 8]
  domain1_test3_t1 <- 1 * domain1_t1 + errors[, 9]
  
  domain2_test1_t1 <- 1 * domain2_t1 + errors[, 10]
  domain2_test2_t1 <- 1 * domain2_t1 + errors[, 11]
  domain2_test3_t1 <- 1 * domain2_t1 + errors[, 12]
  
  domain3_test1_t1 <- 1 * domain3_t1 + errors[, 13]
  domain3_test2_t1 <- 1 * domain3_t1 + errors[, 14]
  domain3_test3_t1 <- 1 * domain3_t1 + errors[, 15]
  
  # T2:
  domain1_t2 <- 1 * cog_t2 + errors[, 15]
  domain2_t2 <- 1 * cog_t2 + errors[, 16]
  domain3_t2 <- 1 * cog_t2 + errors[, 17]

  domain1_test1_t2 <- 1 * domain1_t2 + errors[, 18]
  domain1_test2_t2 <- 1 * domain1_t2 + errors[, 19]
  domain1_test3_t2 <- 1 * domain1_t2 + errors[, 20]

  domain2_test1_t2 <- 1 * domain2_t2 + errors[, 21]
  domain2_test2_t2 <- 1 * domain2_t2 + errors[, 22]
  domain2_test3_t2 <- 1 * domain2_t2 + errors[, 23]

  domain3_test1_t2 <- 1 * domain3_t2 + errors[, 24]
  domain3_test2_t2 <- 1 * domain3_t2 + errors[, 25]
  domain3_test3_t2 <- 1 * domain3_t2 + errors[, 26]
  
  data_lcm <- data.frame(
          domain1_test1_t1, domain1_test2_t1, domain1_test3_t1, 
          domain2_test1_t1, domain2_test2_t1, domain2_test3_t1,
          domain3_test1_t1, domain3_test2_t1, domain3_test3_t1,
          domain1_test1_t2, domain1_test2_t2, domain1_test3_t2, 
          domain2_test1_t2, domain2_test2_t2, domain2_test3_t2,
          domain3_test1_t2, domain3_test2_t2, domain3_test3_t2
  )
  data_lcm[1:round(attrition_rate * sample_size), grepl("_t2", names(data_lcm))] <- NA # introduce missing data at T2

  return(data_lcm) 
}