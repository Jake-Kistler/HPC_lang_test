#  **Multilingual CPU/GPU Matrix Multiplication Benchmark Suite**

This project implements a **multilingual performance benchmarking framework** for matrix–matrix multiplication (`C = A × B`) across multiple programming languages and execution models.

The goal is to compare:

- **C++ (CPU)**
- **Fortran (CPU)**
- **Rust (CPU)** *(optional, coming soon)*
- **CUDA C++ (GPU)** *(optional)*
- **CUDA Fortran (GPU)** *(optional)*

Performance results are written to CSV files and plotted using R to provide visual comparisons of language efficiency and scaling behavior.

---

##  **Project Features**

### Multilingual CPU baselines  
Each language has its own implementation of naive (O(N³)) matrix multiplication for direct comparison.

### Shared benchmarking harness  
All languages:
- Use identical matrix sizes
- Emit CSV in a unified format
- Are triggered by the same root Makefile

### Fully automated workflow  
One command benchmarks everything:

```
make all
```

### R-based plotting  
Generates:
- Standard linear plots
- Log–log scaling plots
- Combined cross-language comparison plots

### Expandable  
Designed to seamlessly add GPU backends, BLAS-optimized versions, tiling variants, or additional languages.

---

# **Repository Structure**

```
lang_test/
│
├── cpu/
│   ├── cpp/
│   │   ├── main.cpp
│   │   ├── kernels.cpp
│   │   ├── kernels.hpp
│   │   ├── util.hpp
│   │   └── Makefile
│   │
│   ├── fortran/
│   │   ├── main.f90
│   │   ├── matmul.f90
│   │   ├── util.f90
│   │   └── Makefile
│   │
│   └── rust/
│
├── gpu/
│   ├── cpp/
│   ├── fortran/
│   └── rust/
│
├── results/
│   ├── results_cpu_baseline.csv
│   ├── results_fortran_cpu_baseline.csv
│   ├── results_cpu_verify.csv
│   ├── results_fortran_cpu_verify.csv
│   ├── combined_cpu_plot.png
│   ├── combined_cpu_plot_log.png
│   ├── plot_all.R
│   └── plot_all_log.R
│
├── Makefile
└── README.md
```

---

# **Building & Running**

## **1. Full benchmark + plots**

```
make all
```

Runs C++ + Fortran + combined plots.

---

## **2. C++ Only**

```
make cpp
```

## **3. Fortran Only**

```
make fortran
```

---

## **4. Generate Plots Only**

Linear-scale:

```
make plot
```

Log–log:

```
make plot-log
```

---

# **Output Plots**

- `combined_cpu_plot.png`
- `combined_cpu_plot_log.png`

---

# **CSV Format**

```
N,time_ms
64,0.12
128,2.05
256,15.9
512,330.5
1024,5900.1
```

---

# **Benchmark Methodology**

Every language:
1. Allocates A, B, C
2. Fills A/B with deterministic random
3. Computes a reference
4. Times the test implementation
5. Writes results → CSV
6. Validates correctness

Algorithm:

```
for i in 1..N
  for j in 1..N
    for k in 1..N
        C[i,j] += A[i,k] * B[k,j]
```

---

# **Future Work**

- Rust support
- CUDA versions
- OpenMP variants
- BLAS/MKL comparison
- Tiled/blocked algorithms
- Roofline performance plots
