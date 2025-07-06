Series of command to run
---

Compile
```!nvcc -o cublasltMatMul cublasMatMul.cu -lcublas -lcublasLt```<br>
Run
```!./cublasltMatMul```
```
Matrix A:
    1.00     2.00     3.00     4.00 
    5.00     6.00     7.00     8.00 
    9.00    10.00    11.00    12.00 
   13.00    14.00    15.00    16.00 

Matrix B:
    1.00     2.00     4.00     4.00 
    5.00     6.00     7.00     8.00 
    9.00    10.00    11.00    12.00 
   17.00    18.00    19.00    20.00 

Matrix C (CPU):
  106.00   116.00   127.00   136.00 
  234.00   260.00   291.00   312.00 
  362.00   404.00   455.00   488.00 
  490.00   548.00   619.00   664.00 

Matrix C (GPU FP32):
  106.00   116.00   127.00   136.00 
  234.00   260.00   291.00   312.00 
  362.00   404.00   455.00   488.00 
  490.00   548.00   619.00   664.00 

Matrix C (GPU FP16):
  106.00   116.00   127.00   136.00 
  234.00   260.00   291.00   312.00 
  362.00   404.00   455.00   488.00 
  490.00   548.00   619.00   664.00 

FP32 Results match
FP16 Results match
```
---

Compile
```!nvcc -o cublasltCompareMatMul cublasltCompareMatMul.cu -lcublas -lcublasLt```<br>
Run
```!./cublasltCompareMatMul```
```
matrix size: 4096x1024 * 1024x4096
cuBLAS FP32 average time: 9.84935 ms
cuBLASLt FP32 average time: 8.08445 ms
cuBLAS FP16 average time: 0.766322 ms
cuBLASLt FP16 average time: 0.747424 ms
Naive CUDA kernel average time: 58.3644 ms
max error fp16 cublas: 0.0650377
max error fp16 cublasLt: 0.0650377
cuBLAS FP32 results match the naive kernel results within tolerance of 1e-2.
cuBLASLt FP32 results match the naive kernel results within tolerance of 1e-2.
cuBLAS FP16 results match the naive kernel results within tolerance of 5e-1.
cuBLASLt FP16 results match the naive kernel results within tolerance of 5e-1.
```
