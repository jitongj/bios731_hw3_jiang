source(here::here("source", "logistic_helper.R"))
source(here::here("source", "newton_logistic.R"))
source(here::here("source", "bfgs_logistic.R"))
source(here::here("source", "glm_logistic.R"))
source(here::here("source", "mm_logistic.R"))
source(here::here("source", "compute_ci.R"))


dat <- readRDS(here("data", "simulation_data.rds"))
X <- dat$X
y <- dat$y

beta_init <- rep(0.1, ncol(X))


# 4 Methods

t_newton <- system.time({
  fit_newton <- newton_logistic(X, y, beta_init = beta_init)
})

t_bfgs <- system.time({
  fit_bfgs <- bfgs_logistic(X, y, beta_init = beta_init)
})

t_glm <- system.time({
  fit_glm <- glm_logistic(X, y)
})

t_mm <- system.time({
  fit_mm <- mm_logistic(X, y, theta_init = beta_init)
})


# compute Wald CI
ci_newton <- compute_ci(fit_newton$beta_hat, X, y)$table
ci_bfgs   <- compute_ci(fit_bfgs$beta_hat,   X, y)$table
ci_glm    <- compute_ci(fit_glm$beta_hat,    X, y)$table
ci_mm     <- compute_ci(fit_mm$beta_hat,     X, y)$table

# summary
make_summary <- function(method, fit, timing, ci_tbl) {
  data.frame(
    method = method,
    term = ci_tbl$term,
    estimate = ci_tbl$estimate,
    se = ci_tbl$se,
    ci_lower = ci_tbl$ci_lower,
    ci_upper = ci_tbl$ci_upper,
    time_sec = as.numeric(timing[["elapsed"]]),
    iterations = fit$iterations,
    converged = fit$converged
  )
}

res_table <- rbind(
  make_summary("Newton", fit_newton, t_newton, ci_newton),
  make_summary("BFGS",   fit_bfgs,   t_bfgs,   ci_bfgs),
  make_summary("GLM",    fit_glm,    t_glm,    ci_glm),
  make_summary("MM",     fit_mm,     t_mm,     ci_mm)
)


saveRDS(
  res_table,
  file = here("data", "summary_results.rds")
)
