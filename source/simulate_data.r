simulate_logistic_data <- function(n = 200,
                                   beta = c(1, 0.3),
                                   x_mean = 0,
                                   x_sd = 1) {
  x <- rnorm(n, mean = x_mean, sd = x_sd)
  X <- cbind(Intercept = 1, x = x)
  
  eta <- as.vector(X %*% beta)
  p <- 1 / (1 + exp(-eta))
  y <- rbinom(n, size = 1, prob = p)
  
  list(
    X = X,
    x = x,
    y = y,
    beta_true = beta,
    eta = eta,
    p = p,
    n = n
  )
}