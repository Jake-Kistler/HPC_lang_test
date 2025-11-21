library(ggplot2)

df <- read.csv("results_cpu_baseline.csv")


ggplot(df, aes(x = N, y = time_ms)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  theme_minimal(base_size = 16) +
  labs(
    title = "Baseline CPU Matrix-Matrix Multiplication Performance",
    x = "Matrix size (N)",
    y = "Execution time (ms)"
  )
