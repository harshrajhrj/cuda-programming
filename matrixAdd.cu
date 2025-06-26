#include <bits/stdc++.h>

using namespace std;

const int N = 2;
// Kernel definition
__global__ void MatAdd(float A[N][N], float B[N][N], float C[N][N])
{
    int i = threadIdx.x;
    int j = threadIdx.y;
    C[i][j] = A[i][j] + B[i][j];
}

int main()
{
    // Kernel invocation with one block of N * N * 1 threads
    int numBlocks = 1;
    float A[N][N] = {
        {2, 2},
        {2, 2}
    };
    float B[N][N] = {
        {2, 2},
        {2, 2}
    };
    float C[N][N];
    dim3 threadsPerBlock(N, N);
    MatAdd<<<numBlocks, threadsPerBlock>>>(A, B, C);

    cout<<"";

    for(int i = 0; i < N; i++) {
        for(int j = 0; j < N; j++)
            cout<<C[i][j]<<" ";
        cout<<endl;
    }
}