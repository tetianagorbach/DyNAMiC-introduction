# This file initializes the parameters for the simulation study
n_sim <- 100 # number of replicates in simulations
set.seed(0) # seed for random number generation, current R version 3.5.2 (2018-12-20), MAC OS x86_64-apple-darwin15.6.0 
parameters <- expand.grid(
        sample_size  = 180,
        attrition_rate = c(0.1,  0.4),
        intercept_t1 =  50,
        intercept_change = c(5, 10),
        var_t1 =  1,
        var_change = c(0.05, 0.1, 0.2),
        var_errors = c(0.1, 0.3),
        # reliability = c(0.7, 0.8, 0.9, 0.97), # Cronbach's alpha for sum of individual test that defines variance of measurement errors:
        # var_errors = 3*(1-alpha)/alpha*var_t1 assuming variances of errors are the same
        self_feedback = c(-0.05,  -0.2) # correlation between change and T1
)
