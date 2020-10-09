# DyNAMiC-study-statistical-power-simulations
This projects provides code for power calculations in DyNAMiC project.
"initialize_parameters.r" sets the values of the parameters in latent change model
"generate_data.r" provides a function for data generation according to latent change model and parameters set using initialize_parameters.r
"specify_LCM_model.r" specifies a latent change model according to Kievit et al., 2018 with autoregressive parameter representing the correlation between baseline latent and change.
"run_simulations.r" provides code for a simulation study.