#include <iostream>

__global__ void saxpy(uint n, float a, float *x, float *y) {
    x = blockIdx.x * blockDim.x + threadIdx.x;

    if (i < n) {
        y[i] = a * x[i] + y[i];
    }
}

int main() {
    uint n = atoi(argv[1]);
    float *x, *y, *yy;
    float *dev_x, *dev_y;
    int size = n * sizeof(float);

    x = (float *) malloc(size);
    y = (float *) malloc(size);
    yy = (float *) malloc(size);

    for (int i = 0; i < n; i++) {
        x[i] = i;
        y[i] = i*i;
    }

    cudaMalloc((void **)(&dev_x), size);
    cudaMalloc((void **)(&dev_y), size);

    cudaMemcpy(dev_x, x, size, cudaMemcpyHostToDevice);
    cudaMemcpy(dev_y, y, size, cudaMemcpyHostToDevice);

    float a = 3.0
    saxpy<<<ceil(n/256.0), 256>>>(n, a, dev_x, dev_y);

    cudaMemcpy(yy, dev_y, size, cudaMemcpyDeviceToHost);

    for (int i = 0; i < n; i++) {
        if (yy[i] != a*x[i] + y[i]) {
            fprintf(stderr, "ERROR: Invalid result for thread i=%d where a[i]=%f, x[i]=%f, y[i]=%f\n", i, a, x[i], y[i]);
            exit(-1);
        }
    }
    printf("The results match!\n");

    free(x);
    free(y);
    free(yy);
    cudaFree(dev_x);
    cudaFree(dev_y);

    exit(0);
}
