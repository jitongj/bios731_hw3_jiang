em_exp_censored <- function(y,
                            delta,
                            lambda_init,
                            tol = 1e-8,
                            max_iter = 1000) {
  
  n <- length(y)
  lambda <- lambda_init
  
  lambda_path <- lambda
  iter <- 0
  
  while (iter < max_iter) {
    
    iter <- iter + 1
    
    # E-step
    S_k <- sum(y[delta == 1]) +
      sum(y[delta == 0] + 1 / lambda)
    
    # M-step
    lambda_new <- n / S_k
    
    lambda_path <- c(lambda_path, lambda_new)
    
    # convergence
    if (abs(lambda_new - lambda) < tol) {
      return(list(
        lambda_hat = lambda_new,
        iterations = iter,
        converged = TRUE,
        lambda_path = lambda_path
      ))
    }
    
    lambda <- lambda_new
  }
  
  list(
    lambda_hat = lambda,
    iterations = max_iter,
    converged = FALSE,
    lambda_path = lambda_path
  )
}