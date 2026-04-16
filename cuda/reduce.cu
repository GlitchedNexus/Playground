__global__ void shitty_reduce(uint n, float *data) {
    int myIdx = blockDim.x * blockIdx.x + threadIdx.x;

    for (int stride = 1; stride < n; stride += stride) {
       if ((myIdx & (stride - 1)) == 0) {
            data[2 * myIdx] += data[2 * myIdx + stride];
        }
        __syncthreads();
    }
}

__global__ void reduce(uint n, float *data) {
    int myIdx = blockDim.x * blockIdx.x + threadIdx.x;

    for (int stride = n/2; stride >0; stride >>= 1) {
        if (myIdx < string) {
            data[myIdx] += data[myIdx + stride];
        }
        __syncthreads();
    }
}

int main() {
    uint n = atoi(argv[1]);

}
