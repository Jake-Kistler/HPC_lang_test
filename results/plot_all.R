library(ggplot2)
library(readr)
library(dplyr)

# ---- Load CSVs ----
cpu_cpp <- read_csv("results/results_cpu_baseline.csv")
cpu_fortran <- read_csv("results/results_fortran_cpu_baseline.csv")

# Add labels
cpu_cpp$language <- "C++"
cpu_fortran$language <- "Fortran"

# Combine
df <- bind_rows(cpu_cpp, cpu_fortran)

# ---- Plot ----
p <- ggplot(df, aes(x = N, y = time_ms, color = language)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  theme_minimal(base_size = 16) +
  labs(
    title = "CPU Matrix-Matrix Multiply Performance",
    x = "Matrix Size (N)",
    y = "Execution Time (ms)",
    color = "Language"
  ) +
  scale_x_continuous(breaks = df$N) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)
  )

# ---- OPTIONAL: Enable log–log scaling ----
# p <- p + scale_x_log10() + scale_y_log10()

ggsave("results/combined_cpu_plot.png", p, width = 9, height = 5)

print("Combined CPU plot saved to: results/combined_cpu_plot.png")
