compute_ci <- function(beta_hat,
                       X,
                       y = NULL,
                       alpha = 0.05) {
  beta_hat <- as.numeric(beta_hat)
  if (length(beta_hat) != ncol(X)) stop("beta_hat length must equal ncol(X).")
  
  eta <- as.vector(X %*% beta_hat)
  p <- logistic(eta)
  w <- p * (1 - p)
  
  I <- crossprod(X, X * w)
  
  V <- solve(I)
  se <- sqrt(diag(V))
  
  z <- qnorm(1 - alpha / 2)
  ci_lower <- beta_hat - z * se
  ci_upper <- beta_hat + z * se
  
  out <- data.frame(
    term = colnames(X),
    estimate = beta_hat,
    se = as.numeric(se),
    ci_lower = as.numeric(ci_lower),
    ci_upper = as.numeric(ci_upper)
  )
  
  list(
    table = out,
    vcov = V
  )
}