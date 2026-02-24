newton_logistic <- function(X,
                            y,
                            beta_init = NULL,
                            tol = 1e-6,
                            max_iter = 100) {
  
  n <- nrow(X)
  p <- ncol(X)
  
  if (is.null(beta_init)) {
    beta <- rep(0, p)
  } else {
    beta <- beta_init
  }
  
  iter <- 0
  converged <- FALSE
  
  while (iter < max_iter) {
    
    iter <- iter + 1
    
    grad <- grad_logistic(beta, X, y)
    hess <- hess_logistic(beta, X, y)
    
    # beta_new = beta - H^{-1} * grad
    step <- solve(hess, grad)
    beta_new <- beta - step
    
    if (sqrt(sum((beta_new - beta)^2)) < tol) {
      converged <- TRUE
      beta <- beta_new
      break
    }
    
    beta <- beta_new
  }
  
  list(
    beta_hat = beta,
    iterations = iter,
    converged = converged
  )
}