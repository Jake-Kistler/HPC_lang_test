.PHONY: all cpp fortran plot clean

# -------------------------------------------------------------------
#  MASTER WORKFLOW
# -------------------------------------------------------------------
all: cpp fortran plot

# -------------------------------------------------------------------
#  C++ CPU BASELINE
# -------------------------------------------------------------------
cpp:
	@echo "=== Building & running C++ baseline ==="
	$(MAKE) -C cpu/cpp all

# -------------------------------------------------------------------
#  FORTRAN CPU BASELINE
# -------------------------------------------------------------------
fortran:
	@echo "=== Building & running Fortran baseline ==="
	$(MAKE) -C cpu/fortran all

# -------------------------------------------------------------------
#  COMBINED PLOT
# -------------------------------------------------------------------
plot:
	@echo "=== Plotting combined CPU results (C++ vs Fortran) ==="
	Rscript results/plot_all.R

# -------------------------------------------------------------------
#  LOG-SCALED PLOT ONLY (no rebuild, no rerun)
# -------------------------------------------------------------------
plot-log:
	@echo "=== Generating log-scaled CPU comparison plot ==="
	Rscript results/plot_all_log.R
	@echo "Log-scaled plot saved to results/combined_cpu_plot_log.png"


# -------------------------------------------------------------------
#  CLEAN
# -------------------------------------------------------------------
clean:
	$(MAKE) -C cpu/cpp clean
	$(MAKE) -C cpu/fortran clean
	rm -f results/*.csv
	rm -f results/*.png
	rm -f results/*.pdf
