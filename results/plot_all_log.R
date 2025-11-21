library(ggplot2)
library(readr)
library(dplyr)

# Load CSVs (already generated)
cpu_cpp <- read_csv("results/results_cpu_baseline.csv")
cpu_fortran <- read_csv("results/results_fortran_cpu_baseline.csv")


cpu_cpp$language <- "C++"
cpu_fortran$language <- "Fortran"

df <- bind_rows(cpu_cpp, cpu_fortran)

p <- ggplot(df, aes(x = N, y = time_ms, color = language)) +
  geom_line(linewidth = 1.2) +
  geom_point(size = 3) +
  theme_minimal(base_size = 16) +
  scale_x_log10() +
  scale_y_log10() +
  labs(
    title = "CPU Matrix-Matrix Multiply Performance (log–log)",
    x = "Matrix Size (N, log scale)",
    y = "Execution Time (ms, log scale)",
    color = "Language"
  ) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(hjust = 0.5)
  )

ggsave("combined_cpu_plot_log.png", p, width = 9, height = 5)

print("Saved to: results/combined_cpu_plot_log.png")
