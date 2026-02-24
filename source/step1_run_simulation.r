source(here::here("source", "simulate_data.R"))

set.seed(2026)

n <- 200
beta_true <- c(1, 0.3)
x_mean <- 0
x_sd <- 1

dat <- simulate_logistic_data(
  n = n,
  beta = beta_true,
  x_mean = x_mean,
  x_sd = x_sd
)


saveRDS(dat, file = here::here("data", "simulation_data.rds"))

