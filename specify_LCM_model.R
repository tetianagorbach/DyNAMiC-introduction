# model specification -----------------------------------------------------
LCM <- '
#####     The following lines specify the core assumptions of the LCS 
#####     and should not generally be modified

cog_t2 ~ 1*cog_t1     # Fixed regression of COG_T2 on COG_T1
dcog =~ 1*cog_t2    # Fixed regression of dcog_t1 on COG_T2
cog_t2 ~ 0*1          # This line constrains the intercept of COG_T2 to 0
cog_t2 ~~ 0*cog_t2    # This fixes the variance of the COG_T2 to 0  


###### The following five parameters will be estimated in the model. 
###### Values can be modified manually to examine the effect on the model

dcog ~ 1        # Estimate the intercept of the change score. 
cog_t1 ~ 1       # Estimate the intercept of COG_T1. 

dcog ~~ dcog    # Estimate the variance of the change scores. 
cog_t1 ~~ cog_t1  # Estimate the variance of the COG_T1. 

dcog ~~ cog_t1   # Estimate the self-feedback parameter. 

###### Measurement model
cog_t1 =~  domain1_t1 +  domain2_t1 +  domain3_t1
cog_t2 =~  domain1_t2 +  domain2_t2 +  domain3_t2

domain1_t1 =~ domain1_test1_t1  + domain1_test2_t1  + domain1_test3_t1 
domain2_t1 =~ domain2_test1_t1  + domain2_test2_t1  + domain2_test3_t1
domain3_t1 =~ domain3_test1_t1  + domain3_test2_t1  + domain3_test3_t1

domain1_t2 =~ domain1_test1_t2  + domain1_test2_t2  + domain1_test3_t2 
domain2_t2 =~ domain2_test1_t2  + domain2_test2_t2  + domain2_test3_t2
domain3_t2 =~ domain3_test1_t2  + domain3_test2_t2  + domain3_test3_t2
'