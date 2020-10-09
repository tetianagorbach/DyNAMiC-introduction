# this file runs analyses of the results
results <-  read.csv("results.csv", row.names = NULL)
results <- results%>%filter(var_change>0.05)

library(tidyverse)

theme_set(
        theme_bw() +
                theme(legend.position = "top")
)
results %>%
        gather(key = "variable", value = "value",
               -c(power, sample_size, var_t1, intercept_t1, intercept_change, sum_converge, sum_occured_neg_var))%>%
        ggplot() +
        geom_point(aes(x = value, y = power)) +
        facet_grid(~variable, scales="free_x")


# compare groups: 
anova(lm(power~attrition_rate, data=results))
anova(lm(power~self_feedback, data=results))
anova(lm(power~var_change, data=results)) #affects
anova(lm(power~reliability, data=results)) #affects
anova(lm(power~sum_occured_neg_var, data=results)) #affects
summary(lm(power~var_change + reliability, data=results))


results%>%
        group_by( var_change)%>%
        summarise(m = mean(power))

results%>%
        group_by( reliability)%>%
        summarise(m = mean(power))

# when did the errors occur:
results %>%
        gather(key = "variable", value = "value",
               -c(sum_converge, sum_occured_neg_var, intercept_t1, power, sample_size))%>%
        ggplot() +
        geom_point(aes(x = value, y = sum_occured_neg_var)) +
        facet_grid(~variable, scales="free_x")

# compare what affects the occurence of negative variances:
anova(lm(sum_occured_neg_var~attrition_rate, data=results))
anova(lm(sum_occured_neg_var~self_feedback, data=results))
anova(lm(sum_occured_neg_var~var_change, data=results)) # affected
anova(lm(sum_occured_neg_var~reliability, data=results)) # affected
summary(lm(sum_occured_neg_var~var_change + reliability, data=results))

results%>%
        group_by( reliability, var_change)%>%
        summarise(m = mean(sum_occured_neg_var))

results%>%
        group_by(reliability, var_change, attrition_rate)%>%
        summarise(m = mean(power))%>%
        arrange(reliability, var_change, attrition_rate)

