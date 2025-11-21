#pragma once
#include <vector>
#include <random>
#include <chrono>
#include <cmath>

inline double now()
{
    using clock = std::chrono::high_resolution_clock;
    return std::chrono::duration<double>(clock::now().time_since_epoch()).count();
}

inline void fill_random(std::vector<float> &v)
{
    std::mt19937 gen(42);
    std::uniform_real_distribution<float> dist(0.0f, 1.0f);

    for (auto &x : v)
        x = dist(gen);
}

// Simple reference matmul for correctness check
inline void reference_matmul(const std::vector<float> &A,
                             const std::vector<float> &B,
                             std::vector<float> &C,
                             size_t N)
{
    for (size_t i = 0; i < N; i++)
        for (size_t j = 0; j < N; j++)
        {
            float sum = 0;
            for (size_t k = 0; k < N; k++)
                sum += A[i * N + k] * B[k * N + j];

            C[i * N + j] = sum;
        }
}

inline bool approx_equal(const std::vector<float> &x,
                         const std::vector<float> &y,
                         float tol = 1e-3f)
{
    for (size_t i = 0; i < x.size(); i++)
        if (std::fabs(x[i] - y[i]) > tol)
            return false;

    return true;
}
