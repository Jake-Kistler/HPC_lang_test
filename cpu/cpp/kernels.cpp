#include "kernels.hpp"

void baseline(const std::vector<float> &A,
               const std::vector<float> &B,
               std::vector<float> &C,
               size_t N)
{
    // a basic matrix-matrix multiplication with no optimization done
    // This will assume propper valid sizes so no checking for valid sizes
    // this will have two versions
    // 1 - this will be standard looping 
    // 2- iterators for the vectors 

    for(size_t i = 0; i < N; i++)
    {
        for(size_t j = 0; j < N; j++)
        {
            float sum = 0.0f;

            for(size_t k = 0; k < N; k++)
            {
                // row-major inexing: element (r,c) is r*N + c 
                sum += A[i * N + k] * B[k * N + j];
            }

            C[i * N + j] = sum;
        }
    }

    
}