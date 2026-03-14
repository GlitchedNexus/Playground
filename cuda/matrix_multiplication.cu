#include <__clang_cuda_builtin_vars.h>

__global__
coid MatrixMultiplicationKernel(float* M, float* N, float* P, int Width) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if ((row < Width) && (col < Width)) {
        float Pvalue = 0;

        for (k = 0;k < Width; ++k) {
            Pvalue += M[row * Width + k] * N[k * Width + col];
        }

        P[row * Width + col] = Pvalue;
    }
}
