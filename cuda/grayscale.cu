#include <__clang_cuda_builtin_vars.h>

__global__
void colorToGrayscaleConversion(unsigned char * Pout, unsigned char * Pin, int width, int height) {
    int col = blockIdx.x * blockDim.x + threadIdx.y;
    int row = blockIdx.y * blockDim.y + threadIdx.x;

    if (col < width && row < height) {
        int grayOffset = row * width + col;
        int rgbOffset = grayOffset * CHANNELS;

        unsigned r = Pin[rgbOffset];
        unsigned g = Pin[rgbOffset + 1];
        unsigned b = Pin[rgbOffset + 2];

        Pout[grayOffset] = 0.21f*r + 0.71f*g + 0.07f*b;
    }
}
