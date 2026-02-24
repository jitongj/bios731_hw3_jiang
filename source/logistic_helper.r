# Logistic
logistic <- function(eta) {
  eta <- as.numeric(eta)
  out <- numeric(length(eta))
  
  idx <- eta >= 0
  out[idx] <- 1 / (1 + exp(-eta[idx]))
  
  e <- exp(eta[!idx])
  out[!idx] <- e / (1 + e)
  
  out
}

# Log-likelihood
loglik_logistic <- function(beta, X, y) {
  eta <- as.vector(X %*% beta)
  log_term <- ifelse(
    eta > 0,
    eta + log1p(exp(-eta)),
    log1p(exp(eta))
  )
  
  sum(y * eta - log_term)
}


# Gradient
grad_logistic <- function(beta, X, y) {
  eta <- as.vector(X %*% beta)
  p <- logistic(eta)
  
  t(X) %*% (y - p)
}


# Hessian
hess_logistic <- function(beta, X, y) {
  eta <- as.vector(X %*% beta)
  p <- logistic(eta)
  
  w <- as.vector(p * (1 - p))
  W <- diag(w)
  
  - t(X) %*% W %*% X
}