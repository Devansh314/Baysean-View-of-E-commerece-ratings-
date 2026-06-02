# Load necessary library
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Set alpha and beta parameters
alpha1 <- 91  
beta1 <- 11
alpha2 <- 8
beta2 <- 2

# Generate a sequence of values from 0 to 1
x <- seq(0, 1, length.out = 100)

# Compute the Beta density function for each value of x
y <- dbeta(x, shape1 = alpha, shape2 = beta)

# Create a data frame for plotting
beta_data <- data.frame(x = x, y = y)

# Plot the Beta distribution using ggplot2
ggplot(beta_data, aes(x = x, y = y)) +
  geom_line(color = "blue", size = 1) +
  labs(title = paste("Beta Distribution (alpha =", alpha1, ", beta =", beta1, ")"),
       x = "x",
       y = "Density") +
  theme_minimal()

ggplot(beta_data, aes(x = x, y = y)) +
  geom_line(color = "green", size = 1) +
  labs(title = paste("Beta Distribution (alpha =", alpha2, ", beta =", beta2, ")"),
       x = "x",
       y = "Density") +
  theme_minimal()

