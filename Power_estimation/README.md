# DyNAMiC-study-statistical-power-simulations
This projects provides code for power calculations in DyNAMiC project.

["initialize_parameters.r"](initialize_parameters.R) sets the values of the parameters in latent change model

["generate_data.r"](generate_data.R) provides a function for data generation according to latent change model and parameters from initialize_parameters.r

["specify_LCM_model.r"](specify_LCM_model.R) specifies a latent change model according to Kievit et al., 2018 with autoregressive parameter representing the correlation between baseline latent and change.

["run_simulations.r"](run_simulations.R) provides the code to run this simulation study.

["analyze_results"](analyze_results.Rmd) analyzes the results of the simulation study.

["results20201019.csv"](results20201019.csv) is a table of results.

References:
Kievit RA, Brandmaier AM, Ziegler G, Van Harmelen AL, de Mooij SM, Moutoussis M, Goodyer IM, Bullmore E, Jones PB, Fonagy P, Lindenberger U. 
Developmental cognitive neuroscience using latent change score models: A tutorial and applications. Developmental cognitive neuroscience. 2018. 1;33:99-117.