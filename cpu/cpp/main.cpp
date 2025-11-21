#include <iostream>
#include <fstream>
#include <vector>
#include <string>

#include "kernels.hpp"
#include "util.hpp"

int main(int argc, char** argv)
{
    // Matrix sizes to test
    std::vector<size_t> sizes = {
        64,
        128,
        256,
        512,
        1024
    };

    // ---- CSV outputs ----
    std::ofstream csv_time("results_cpu_baseline.csv");
    std::ofstream csv_verify("results_cpu_verify.csv");

    csv_time   << "N,time_ms\n";
    csv_verify << "N,correct\n";

    std::cout << "Running CPU baseline tests...\n";

    for (size_t N : sizes)
    {
        std::cout << "N = " << N << "..." << std::endl;

        // Allocate matrices
        std::vector<float> A(N * N);
        std::vector<float> B(N * N);
        std::vector<float> C(N * N);
        std::vector<float> ref(N * N);

        // Fill A and B with fixed random values for repeatability
        fill_random(A);
        fill_random(B);

        // ---- correctness check ----
        reference_matmul(A, B, ref, N);

        double t0 = now();
        baseline(A, B, C, N);
        double t1 = now();

        bool ok = approx_equal(C, ref);

        // Write correctness result (1 = correct, 0 = incorrect)
        csv_verify << N << "," << (ok ? 1 : 0) << "\n";

        if (!ok)
        {
            std::cerr << "ERROR: baseline result incorrect for N = " << N << "\n";
            std::cerr << "Stopping.\n";
            return 1;
        }

        double elapsed_ms = (t1 - t0) * 1000.0;

        // Write timing result
        csv_time << N << "," << elapsed_ms << "\n";

        std::cout << "   OK (" << elapsed_ms << " ms)\n";
    }

    std::cout << "\nAll tests complete.\n";
    std::cout << "Results written to:\n";
    std::cout << "  results_cpu_baseline.csv\n";
    std::cout << "  results_cpu_verify.csv\n";

    return 0;
}
