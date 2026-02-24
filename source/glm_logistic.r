glm_logistic <- function(X, y) {
  dat <- as.data.frame(X)
  dat$y <- as.numeric(y)
  
  x_names <- colnames(X)
  rhs <- paste(x_names, collapse = " + ")
  form <- as.formula(paste("y ~", rhs, "- 1"))
  fit <- glm(form, family = binomial(), data = dat)
  
  list(
    beta_hat = as.numeric(coef(fit)),
    iterations = fit$iter,
    converged = fit$converged,
    fit_obj = fit
  )
}