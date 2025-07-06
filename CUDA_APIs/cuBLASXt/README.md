Series of command to run
---

Compile
```!nvcc -o cublasXtMatMul cublasXtMatMul.cu -lcublas```<br>
Run
```!./cublasXtMatMul```
```
Maximum difference between CPU and GPU results: 0.0001
```
---

Compile
```!nvcc -o cublasxtCompareMatMul cublasxtCompareMatMul.cu -lcublas```<br>
Run
```!./cublasxtCompareMatMul```
```
CUBLAS run 1 time: 2.15036 seconds
CUBLAS run 2 time: 2.1552 seconds
CUBLAS run 3 time: 1.99884 seconds
CUBLAS run 4 time: 2.17824 seconds
CUBLAS run 5 time: 2.16943 seconds
CUBLAS-XT run 1 time: 8.16707 seconds
CUBLAS-XT run 2 time: 8.18727 seconds
CUBLAS-XT run 3 time: 8.20114 seconds
CUBLAS-XT run 4 time: 8.18995 seconds
CUBLAS-XT run 5 time: 8.17995 seconds
Average CUBLAS time: 2.13041 seconds
Average CUBLAS-XT time: 8.18507 seconds
Results match within tolerance.
```
