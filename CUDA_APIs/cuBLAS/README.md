Series of command to run
---

Compile
```!nvcc -o cublasMatMul cublasMatMul.cu -lcublas```<br>
Run
```!./cublasMatMul```
```
Matrix A (3x4):
   1.000    2.000    3.000    4.000 
   5.000    6.000    7.000    8.000 
   9.000   10.000   11.000   12.000 

Matrix B (4x2):
   1.000    2.000 
   3.000    4.000 
   5.000    6.000 
   7.000    8.000 

CPU Result (3x2):
  50.000   60.000 
 114.000  140.000 
 178.000  220.000 

cuBLAS SGEMM Result (3x2):
  50.000   60.000 
 114.000  140.000 
 178.000  220.000 

cuBLAS HGEMM Result (3x2):
  50.000   60.000 
 114.000  140.000 
 178.000  220.000 
```

