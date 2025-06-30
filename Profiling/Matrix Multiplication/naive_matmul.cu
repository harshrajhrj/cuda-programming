#include <bits/stdc++.h>
using namespace std;

#define BLOCK_SIZE 16

__global__ void matrixMultiply(float* A, float* B, float* C, int M, int N, int K) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    
    if (row < M && col < N) {
        float sum = 0.0f;
        for (int i = 0; i < K; ++i) {
            sum += A[row * K + i] * B[i * N + col];
        }
        C[row * N + col] = sum;
    }
}

// Initialize matrix with random values
void init_matrix(float *mat, int rows, int cols) {
    for (int i = 0; i < rows * cols; i++) {
        mat[i] = (float)rand() / RAND_MAX;
    }
}

int main() {

    // Define matrix dimensions
    const int M = 1024; // Number of rows in A and C
    const int N = 1024; // Number of columns in B and C
    const int K = 1024; // Number of columns in A and rows in B

    // Calculate matrix sizes in bytes
    size_t size_A = M * K * sizeof(float);
    size_t size_B = K * N * sizeof(float);
    size_t size_C = M * N * sizeof(float);

    // Declare host pointers
    float *h_a, *h_b, *h_c;

    // Declare device pointers
    float *d_A, *d_B, *d_C;

    // Allocate host memory
    h_a = new float[size_A];
    h_b = new float[size_B];
    h_c = new float[size_C];

    // Initialize matrices
    srand(time(NULL));
    init_matrix(h_a, M, K);
    init_matrix(h_b, K, N);

    // Allocate device memory
    cudaMalloc(&d_A, size_A);
    cudaMalloc(&d_B, size_B);
    cudaMalloc(&d_C, size_C);

    // Copy host to device
    cudaMemcpy(d_A, h_a, size_A, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_b, size_B, cudaMemcpyHostToDevice);
        
    // Kernel launch code
    dim3 blockDim(BLOCK_SIZE, BLOCK_SIZE);
    dim3 gridDim((N + blockDim.x - 1) / blockDim.x, (M + blockDim.y - 1) / blockDim.y);
    matrixMultiply<<<gridDim, blockDim>>>(d_A, d_B, d_C, M, N, K);

    // Synchronize device
    cudaDeviceSynchronize();

    // Copy device to host
    cudaMemcpy(h_c, d_C, size_C, cudaMemcpyDeviceToHost);

    // Free host memory
    delete[] h_a;
    delete[] h_b;
    delete[] h_c;
    
    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    // Check for any CUDA errors
    cudaError_t error = cudaGetLastError();
    if (error != cudaSuccess) {
        std::cerr << "CUDA error: " << cudaGetErrorString(error) << std::endl;
        return -1;
    }

    return 0;

}
