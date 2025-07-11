#include <bits/stdc++.h>
#include <nvtx3/nvToolsExt.h>
using namespace std;

#define BLOCK_SIZE 16

__global__ void matrixMulKernel(float* A, float* B, float* C, int N) {
    int row = blockIdx.y * blockDim.y + threadIdx.y;
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    float sum = 0.0f;
    
    if (row < N && col < N) {
        for (int i = 0; i < N; i++) {
            sum += A[row * N + i] * B[i * N + col];
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

void matrixMul(float* A, float* B, float* C, int N) {
    nvtxRangePush("Matrix Multiplication");
    
    float *d_A, *d_B, *d_C;
    int size = N * N * sizeof(float);

    nvtxRangePush("Memory Allocation");
    cudaMalloc(&d_A, size);
    cudaMalloc(&d_B, size);
    cudaMalloc(&d_C, size);
    nvtxRangePop();

    nvtxRangePush("Memory Copy Host2Device");
    cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice);
    nvtxRangePop();

    dim3 threadsPerBlock(BLOCK_SIZE, BLOCK_SIZE);
    dim3 numBlocks((N + BLOCK_SIZE - 1) / BLOCK_SIZE, (N + BLOCK_SIZE - 1) / BLOCK_SIZE);

    nvtxRangePush("Kernel Execution");
    matrixMulKernel<<<numBlocks, threadsPerBlock>>>(d_A, d_B, d_C, N);
    cudaDeviceSynchronize();
    nvtxRangePop();

    nvtxRangePush("Memory Copy Device2Host");
    cudaMemcpy(C, d_C, size, cudaMemcpyDeviceToHost);
    nvtxRangePop();

    nvtxRangePush("Memory Deallocation");
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    nvtxRangePop();

    nvtxRangePop();  // End of Matrix Multiplication
}

int main() {
    const int N = 1024;
    float *A = new float[N*N];
    float *B = new float[N*N];
    float *C = new float[N*N];

    // Initialize matrices A and B here...
    srand(time(NULL));
    init_matrix(A, N, N);
    init_matrix(B, N, N);

    matrixMul(A, B, C, N);

    // Use result in C...
    //for(int i = 0; i < N; i++) {
    //    for(int j = 0; j < N; j++)
    //        cout<<C[i * N + j]<<" ";
    //    cout<<endl;
    //}

    delete[] A;
    delete[] B;
    delete[] C;

    return 0;
}
