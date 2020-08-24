# this file runs analyses of the results
results <-  read.csv("results.csv", row.names = NULL)

library(tidyverse)

theme_set(
        theme_bw() +
                theme(legend.position = "top")
)
results %>%
        gather(key = "variable", value = "value",
               -c(power, sample_size, var_t1, intercept_t1, sum_converge, sum_occured_neg_var))%>%
        ggplot() +
        geom_point(aes(x = value, y = power)) +
        facet_grid(~variable, scales="free_x")


# compare groups: 
anova(lm(power~attrition_rate, data=results))
anova(lm(power~intercept_change, data=results))
anova(lm(power~self_feedback, data=results))
anova(lm(power~var_change, data=results)) #affects
anova(lm(power~var_errors, data=results)) #affects
anova(lm(power~sum_occured_neg_var, data=results)) #affects
summary(lm(power~var_change + var_errors, data=results))

# when did the errors occur:
results %>%
        gather(key = "variable", value = "value",
               -c(sum_converge, sum_occured_neg_var, intercept_t1, power, sample_size))%>%
        ggplot() +
        geom_point(aes(x = value, y = sum_occured_neg_var)) +
        facet_grid(~variable, scales="free_x")

# compare what affects the occurence of negative variances:
anova(lm(sum_occured_neg_var~attrition_rate, data=results))
anova(lm(sum_occured_neg_var~intercept_change, data=results))
anova(lm(sum_occured_neg_var~self_feedback, data=results))
anova(lm(sum_occured_neg_var~var_change, data=results)) # affected
anova(lm(sum_occured_neg_var~var_errors, data=results)) # affected
summary(lm(sum_occured_neg_var~var_change + var_errors, data=results))

results%>%
        group_by( var_change)%>%
        summarise(m = mean(power))

# reliability calcualte from errors: 
var_errors = c(0.05, 0.1, 0.3)
sapply(var_errors, function(var_err){3/2*(1 - (3* (1+var_err) + 3*var_err)/(9+9*var_err + 3*var_err))})

