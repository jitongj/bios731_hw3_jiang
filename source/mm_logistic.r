mm_logistic <- function(X,
                        y,
                        theta_init = NULL,
                        tol = 1e-6,
                        max_iter = 200,
                        bracket_init = 2,
                        bracket_max = 1e6,
                        max_bracket_expand = 60) {
  
  n <- nrow(X)
  P <- ncol(X)
  
  if (is.null(theta_init)) {
    theta <- rep(0, P)
  } else {
    if (length(theta_init) != P) stop("theta_init length must equal ncol(X).")
    theta <- as.numeric(theta_init)
  }
  
  iter <- 0
  converged <- FALSE
  
  solve_root_uniroot <- function(f, x0) {
    step <- bracket_init
    lo <- x0 - step
    hi <- x0 + step
    
    f_lo <- f(lo)
    f_hi <- f(hi)
    
    expand <- 0
    while (!is.finite(f_lo) || !is.finite(f_hi) || f_lo * f_hi > 0) {
      expand <- expand + 1
      if (expand > max_bracket_expand || step > bracket_max) return(NA_real_)
      step <- step * 2
      lo <- x0 - step
      hi <- x0 + step
      f_lo <- f(lo)
      f_hi <- f(hi)
    }
    
    out <- tryCatch(
      uniroot(f, lower = lo, upper = hi, tol = 1e-12)$root,
      error = function(e) NA_real_
    )
    out
  }
  
  while (iter < max_iter) {
    iter <- iter + 1
    theta_old <- theta
    
    # a_i^(k) = logistic(eta_i^(k))
    eta_k <- as.vector(X %*% theta_old)
    a_k <- logistic(eta_k)
    
    for (j in seq_len(P)) {
      xj <- X[, j]
      
      if (all(xj == 0)) next
      
      if (all(xj == 1)) {
        denom <- sum(a_k)
        num <- sum(y)
        if (denom > 0 && num > 0) {
          theta[j] <- theta_old[j] + (1 / P) * log(num / denom)
        }
        next
      }
      
      # f_j(t) = - sum_i a_k[i] * x_ij * exp( P * x_ij * (t - theta_j^k) ) + sum_i y_i x_ij
      theta_jk <- theta_old[j]
      s_y <- sum(y * xj)
      
      f_j <- function(t) {
        -sum(a_k * xj * exp(P * xj * (t - theta_jk))) + s_y
      }
      
      root <- solve_root_uniroot(f_j, x0 = theta_jk)
      
      if (is.finite(root)) theta[j] <- root
    }
    
    if (sqrt(sum((theta - theta_old)^2)) < tol) {
      converged <- TRUE
      break
    }
  }
  
  list(
    beta_hat = theta,
    iterations = iter,
    converged = converged
  )
}