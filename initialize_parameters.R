# This file initializes the parameters for the simulation study
n_sim <- 100 # number of replicates
set.seed(0) # seed for random number generation, current R version 3.5.2 (2018-12-20), MAC OS x86_64-apple-darwin15.6.0 
parameters <- expand.grid(
        sample_size  = 180,
        attrition_rate = c(0.1, 0.2, 0.4),
        intercept_t1 =  50,
        intercept_change = 5,
        var_t1 =  1,
        var_change = c(0.1, 0.2, 0.3, 0.4, 0.5),
        reliability = c(0.7, 0.8, 0.9, 0.95), # =var(latents)/var(observed tests)=var(overall cognition)/var(cognitive domains)
        self_feedback = c(-0.05,  -0.2) # correlation between change and T1
)

