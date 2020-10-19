# this code runs the simulations for power calculations
require(doRNG)
source("initialize_parameters.r")
source("generate_data.r")
source("specify_LCM_model.r")


parOut <- foreach(i=1:nrow(parameters)) %dorng% {
        require(lavaan)
        require(tidyverse)
        p_values = converged = neg_var <- numeric(n_sim)
        for (k in 1:n_sim) {
                  simulated_data_lcm <- GenerateDataFromLatentChangeModel(
                        sample_size = parameters[i, "sample_size"],
                        attrition_rate = parameters[i, "attrition_rate"],
                        intercept_t1 = parameters[i, "intercept_t1"],
                        intercept_change = parameters[i, "intercept_change"],
                        var_t1 = parameters[i, "var_t1"],
                        var_change = parameters[i, "var_change"],
                        reliability= parameters[i, "reliability"],
                        self_feedback = parameters[i, "self_feedback"]
                )
                fit_lcm <- lavaan(LCM, data = simulated_data_lcm, int.ov.free = F, int.lv.free = F, auto.fix.first = T, auto.var = T, missing = "fiml")
                par_estimates <- parameterestimates(fit_lcm)
                neg_var[k] <- any(par_estimates%>%filter(lhs==rhs)%>%select(est)< 0) ==T # if there is a variance that was estimated as negative
                converged[k] <- attr(fit_lcm,"optim")$converged # if estimation converged
                p_values[k] <-  par_estimates[ par_estimates$lhs == "dcog" &  par_estimates$rhs == "dcog", "pvalue"] # p-value for the estimate of variance of change
        }
        c(sum(neg_var),  sum(converged), sum(p_values < 0.05))
}

results <- cbind(parameters, matrix(unlist(parOut), nrow=length(parOut), byrow=T))
names(results)[9:11] <- c("sum_occured_neg_var", "sum_converge", "power")

write.csv(results, "results20201019.csv", row.names=F)
      