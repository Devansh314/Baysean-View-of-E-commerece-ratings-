x <- seq(0, 1, length = 100000)

a1 <- 5
b1 <- 5
y1 <- dbeta(x, shape1 = a1, shape2 = b1)

a2 <- 20
b2 <- 6
y2 <- dbeta(x, shape1 = a2, shape2 = b2)
mean1 <- a1 / (a1 + b1)  

mean2 <- a2 / (a2 + b2)  

plot(x, y1, type = "l", col = "blue", lwd = 2, ylim = c(0, max(y1, y2)),
     main = "Beta Distributions with Expectation Values", xlab = "x", ylab = "Density")

lines(x, y2, col = "red", lwd = 2)

abline(v = mean1, col = "blue", lty = 2) 
 abline(v = mean2, col = "red", lty = 2)  
 
text(mean1, 1, labels = paste0("E(X) = ", round(mean1, 3)), pos = 3, col = "blue")
text(mean2, 2, labels = paste0("E(X) = ", round(mean2, 3)), pos = 3, col = "red")

legend("topleft", 
       legend = c(paste("Beta (", a2, ",", b2, ")", sep = " "), 
                  paste("Beta (", a1, ",", b1, ")", sep = " ")),
       col = c("red", "blue"), lwd = 2)