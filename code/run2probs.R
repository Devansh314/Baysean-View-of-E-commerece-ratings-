
P_X_beats_Y <- function(aX, bX, aY, bY) {
  total <- 0.0
  for (i in 0:(aY - 1)) {
    total <- total + exp(lbeta(aX + i, bX + bY)
                         - log(bY + i)
                         - lbeta(1 + i, bY)
                         - lbeta(aX, bX))
  }
  return (total)
}
run_probabilities <- function() {
  
  a1 <- 50
  b1 <- 50
  a2 <- 98
  b2 <- 2
  
  P_d1_beats_d2 <- P_X_beats_Y(a1, b1, a2, b2)
  
  P_d2_beats_d1 <- P_X_beats_Y(a2, b2, a1, b1)
  
  cat(sprintf("Probability that d1 beats d2: %.4f\n", P_d1_beats_d2))
  cat(sprintf("Probability that d2 beats d1: %.4f\n", P_d2_beats_d1))
  
}

run_probabilities()
  









