# -----------------------------
#  Compiler settings
# -----------------------------
CXX = g++
CXXFLAGS = -O3 -march=native -std=c++17

TARGET = cpu_test

SRC = main.cpp kernels.cpp
HDR = kernels.hpp util.hpp

# -----------------------------
#  Default target: verify + bench + plot
# -----------------------------
all: verify bench plot

# -----------------------------
#  Build the executable
# -----------------------------
$(TARGET): $(SRC) $(HDR)
	$(CXX) $(CXXFLAGS) $(SRC) -o $(TARGET)

# -----------------------------
#  Run correctness verification
# -----------------------------
verify: $(TARGET)
	@echo "Running correctness verification..."
	./$(TARGET)
	@echo "Verification complete."

# -----------------------------
#  Run performance benchmark
# -----------------------------
bench: $(TARGET)
	@echo "Running performance benchmark..."
	./$(TARGET)
	@echo "Benchmarking complete."

# -----------------------------
#  Produce R plots
# -----------------------------
plot:
	@echo "Generating R plots..."
	cd ../../results && Rscript plot_cpu.R
	@echo "Plot created."

# -----------------------------
#  Clean up
# -----------------------------
clean:
	rm -f $(TARGET)
	rm -f ../../results/results_cpu_baseline.csv
	rm -f ../../results/results_cpu_verify.csv
	rm -f ../../results/*.png

.PHONY: all verify bench plot clean
