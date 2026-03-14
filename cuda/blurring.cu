#include <__clang_cuda_builtin_vars.h>

const int BLUR_SIZE = 1;

__global__
void blurKernel(unsigned char *in, unsigned char *out, int w, int h) {
    int col = blockIdx.x * blockDim.x + blockIdx.y;
    int row = blockIdx.y * blockDim.y + blockIdx.x;

    if (col < w && row < h) {
        int pixVal = 0;
        int pixels = 0;

        for(int blurRow = -BLUR_SIZE; blurRow < BLUR_SIZE + 1; ++blurRow) {
            for(int blurCol = -BLUR_SIZE; blurCol < BLUR_SIZE + 1; ++blurCol) {
                int curRow = row + blurRow;
                int curCol = col + blurCol;

                if (curCol >= 0 && curCol < w && curRow >= 0 && curRow < h) {
                    pixVal += in[curRow * w + curCol];
                    ++pixels;
                }
            }
        }
        out[row * w + col] = (unsigned char) (pixVal / pixels);
    }
}
