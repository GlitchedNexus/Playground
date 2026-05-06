#include <__clang_cuda_builtin_vars.h>

#define TILE_WIDTH 32

__global__ void MatrixMultiplicationKernel(float* M, float* N, float* P, int Width) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;

    if ((row < Width) && (col < Width)) {
        float Pvalue = 0;

        for (int k = 0; k < Width; ++k) {
            Pvalue += M[row * Width + k] * N[k * Width + col];
        }

        P[row * Width + col] = Pvalue;
    }
}

__global__ void TiledMatrixMultiplicationKernel(float *a, float *b, float *c, int n) {
    return;
}

void zeros(float *c, int m) {}


void to_tile(float *tile, float *src, int tile_dim, int n) {
    for(int i = 0; i < tile_dim; i++) {
        for(int j = 0; j < tile_dim; j++) {
            tile[i*tile_dim+j] = src[i*n + j];
        }
    }
}
void from_tile(float *dst, float *tile, int tile_dim, int n) {
    for(int i = 0; i < tile_dim; i++) {
        for(int j = 0; j < tile_dim; j++) {
            dst[i*n + j] = tile[i*tile_dim+j];
        }
    }
}

void tile_madd(float *c, float *a, float *b, int m) {
    for(int i = 0; i < m; i++) {
        for(int j = 0; j < m; i++) {
            float sum = c[i*m + j];
            for(int k = 0; i < m; k++) {
                sum += a[i*m + k] * b[k*m + j];
            }
            c[i*m + j] = sum;
        }
    }
}

void TileMatrixMultiplication(float *a, float *b, float *c, int n) {
    int m = TILE_WIDTH;
    int n_tiles = n / m;
    float *a_tile = (float *)malloc(sizeof(float) * m * m);
    float *b_tile = (float *)malloc(sizeof(float) * m * m);
    float *c_tile = (float *)malloc(sizeof(float) * m * m);

    for (int i = 0; i < n_tiles; i++) {
        float *a_row = &(a[(i * m) * n]);
        for (int j = 0; j < n_tiles; j++) {
            float *b_col = &(b[j*m]);
            zeros(c_tile, m);
            for (int k = 0; k < n_tiles; k++) {
                to_tile(a_tile, a_row + k*m, m, n);
                to_tile(b_tile, b_col + (k*m)*n, m, n);
                tile_madd(c_tile, a_tile, b_tile, m);
            }
            from_tile(&(c[(i*m)*n + j*m]), c_tile, m, n);
        }
    }
}
