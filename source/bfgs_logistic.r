bfgs_logistic <- function(X,
                          y,
                          beta_init = NULL,
                          tol = 1e-8,
                          max_iter = 1000) {
  
  p <- ncol(X)
  if (is.null(beta_init)) beta_init <- rep(0, p)
  
  fn <- function(beta) -loglik_logistic(beta, X, y)
  gr <- function(beta) -as.vector(grad_logistic(beta, X, y))
  
  fit <- optim(
    par = beta_init,
    fn = fn,
    gr = gr,
    method = "BFGS",
    control = list(reltol = tol, maxit = max_iter)
  )
  
  counts <- fit$counts
  n_fn <- if (!is.null(counts) && length(counts) >= 1) unname(counts[1]) else NA_integer_
  n_gr <- if (!is.null(counts) && length(counts) >= 2) unname(counts[2]) else NA_integer_
  
  list(
    beta_hat = fit$par,
    iterations = n_fn,             
    grad_evals = n_gr,             
    converged = (fit$convergence == 0),
    value = fit$value
  )
}
