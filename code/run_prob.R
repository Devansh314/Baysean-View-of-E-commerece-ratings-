install.packages("VGAM")

library(VGAM)  

P_X_beats_Y_and_Z <- function(aX, bX, aY, bY, aZ, bZ) {
  total <- 0.0
  for (i in 0:(aY - 1)) {
    for (j in 0:(aZ - 1)) {
      total <- total + exp(lbeta(aX + i + j, bX + bY + bZ)
                           - log(bY + i) - log(bZ + j)
                           - lbeta(1 + i, bY) - lbeta(1 + j, bZ)
                           - lbeta(aX, bX))
    }
  }
  
  return (1 - P_X_beats_Y(aX, bX, aY, bY)
          - P_X_beats_Y(aX, bX, aZ, bZ) + total)
}

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
  
  a1 <- 11
  b1 <- 1
  a2 <- 49
  b2 <- 3
  a3 <- 187
  b3<- 15
  
  P_d3_beats_d1_and_d2 <- P_X_beats_Y_and_Z(a3, b3, a1, b1, a2, b2)

  P_d2_beats_d1_and_d3 <- P_X_beats_Y_and_Z(a2, b2, a1, b1, a3, b3)
  
  P_d1_beats_d2_and_d3 <- P_X_beats_Y_and_Z(a1, b1, a2, b2, a3, b3)
  
  cat(sprintf("Probability that d3 beats both d1 and d2: %.4f\n", P_d3_beats_d1_and_d2))
  cat(sprintf("Probability that d2 beats both d1 and d3: %.4f\n", P_d2_beats_d1_and_d3))
  cat(sprintf("Probability that d1 beats both d2 and d3: %.4f\n", P_d1_beats_d2_and_d3))
}

run_probabilities()


