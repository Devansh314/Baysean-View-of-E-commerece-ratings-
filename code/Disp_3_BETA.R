
x <- seq(0, 1, length = 10000)

y1 <- dbeta(x, shape1 = 11, shape2 = 1)

y2 <- dbeta(x, shape1 = 49, shape2 = 3)

y3 <- dbeta(x, shape1 = 187, shape2 = 15)

plot(x, y1, type = "l", col = "blue", lwd = 2, ylim = c(0, max(y1, y2, y3)),
     main = "Beta Distributions", xlab = "x", ylab = "Density")

lines(x, y2, col = "red", lwd = 2)

lines(x, y3, col = "violet", lwd = 2)

legend("topleft", legend = c("Beta(11,1)", "Beta(49,3)", "Beta(187,15)"), 
       col = c("blue", "red", "violet"), lwd = 2)






