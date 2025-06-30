# Profiling Matrix Multiplication
#### Profiling using NVTX library
Follow up commands to run the script
```bash
!nvcc -o nvtx_matmul nvtx_matmul.cu -lnvToolsExt
!nsys profile --stats=true ./nvtx_matmul
```
Report
```
Generating '/tmp/nsys-report-14a9.qdstrm'
[1/8] [========================100%] report2.nsys-rep
[2/8] [========================100%] report2.sqlite
[3/8] Executing 'nvtx_sum' stats report

 Time (%)  Total Time (ns)  Instances    Avg (ns)       Med (ns)      Min (ns)     Max (ns)    StdDev (ns)   Style            Range         
 --------  ---------------  ---------  -------------  -------------  -----------  -----------  -----------  -------  -----------------------
     50.0      646,906,078          1  646,906,078.0  646,906,078.0  646,906,078  646,906,078          0.0  PushPop  Matrix Multiplication  
     49.5      640,001,403          1  640,001,403.0  640,001,403.0  640,001,403  640,001,403          0.0  PushPop  Memory Allocation      
      0.3        4,013,949          1    4,013,949.0    4,013,949.0    4,013,949    4,013,949          0.0  PushPop  Memory Copy Device2Host
      0.2        1,965,161          1    1,965,161.0    1,965,161.0    1,965,161    1,965,161          0.0  PushPop  Memory Copy Host2Device
      0.0          632,900          1      632,900.0      632,900.0      632,900      632,900          0.0  PushPop  Memory Deallocation    
      0.0          286,681          1      286,681.0      286,681.0      286,681      286,681          0.0  PushPop  Kernel Execution       

[4/8] Executing 'osrt_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)     Med (ns)    Min (ns)   Max (ns)     StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  -----------  --------  -----------  -------------  ----------------------
     86.7      617,955,322         13  47,535,024.8  2,725,392.0     3,750  512,737,196  140,653,868.2  poll                  
     12.4       88,121,935        657     134,127.8     21,922.0     1,290   21,324,374    1,128,665.1  ioctl                 
      0.4        3,196,631         29     110,228.7     13,511.0     9,601    2,332,012      428,911.9  mmap64                
      0.1          587,742         54      10,884.1      9,926.5     5,002       26,554        4,301.6  open64                
      0.1          557,010         10      55,701.0     63,533.0    21,968       87,728       22,568.6  sem_timedwait         
      0.1          497,236         53       9,381.8      6,775.0     2,584       44,414        7,884.0  fopen                 
      0.0          264,015         15      17,601.0     10,089.0     2,530      103,944       24,652.9  mmap                  
      0.0          201,775          2     100,887.5    100,887.5    67,125      134,650       47,747.4  pthread_create        
      0.0          193,562          1     193,562.0    193,562.0   193,562      193,562            0.0  pthread_cond_wait     
      0.0          184,423         49       3,763.7      3,070.0     2,070       14,380        2,449.3  fclose                
      0.0          123,314        143         862.3         57.0        47       77,099        6,655.7  fgets                 
      0.0          104,963         71       1,478.4      1,347.0       940        5,308          555.2  fcntl                 
      0.0           88,760         12       7,396.7      7,360.0     3,027       10,775        2,140.3  write                 
      0.0           61,859          6      10,309.8      8,153.0     3,542       25,312        7,749.8  open                  
      0.0           46,698         15       3,113.2      2,648.0     1,294        5,781        1,418.8  read                  
      0.0           39,496          3      13,165.3     13,672.0    11,613       14,211        1,371.1  munmap                
      0.0           29,806          3       9,935.3      9,739.0     6,726       13,341        3,311.9  pipe2                 
      0.0           28,845          2      14,422.5     14,422.5    11,496       17,349        4,138.7  socket                
      0.0           23,037          3       7,679.0      7,841.0     4,820       10,376        2,781.5  fopen64               
      0.0           20,135          2      10,067.5     10,067.5     3,791       16,344        8,876.3  pthread_cond_broadcast
      0.0           18,068          5       3,613.6      4,378.0        63        8,124        3,390.0  fread                 
      0.0           11,527          1      11,527.0     11,527.0    11,527       11,527            0.0  connect               
      0.0           10,593          8       1,324.1      1,211.0     1,032        1,898          302.5  dup                   
      0.0            8,535          2       4,267.5      4,267.5     3,580        4,955          972.3  fwrite                
      0.0            2,549          1       2,549.0      2,549.0     2,549        2,549            0.0  bind                  
      0.0            1,963          1       1,963.0      1,963.0     1,963        1,963            0.0  listen                
      0.0              516         10          51.6         36.0        35          190           48.6  fflush                

[5/8] Executing 'cuda_api_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)    Med (ns)   Min (ns)   Max (ns)    StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  ---------  --------  -----------  ------------  ----------------------
     94.5      117,506,317          3  39,168,772.3  174,005.0   134,659  117,197,653  67,574,995.7  cudaMalloc            
      4.8        5,953,275          3   1,984,425.0  990,889.0   951,245    4,011,141   1,755,299.5  cudaMemcpy            
      0.5          629,346          3     209,782.0  227,573.0   171,937      229,836      32,794.3  cudaFree              
      0.2          266,012          1     266,012.0  266,012.0   266,012      266,012           0.0  cudaLaunchKernel      
      0.0           15,217          1      15,217.0   15,217.0    15,217       15,217           0.0  cudaDeviceSynchronize 
      0.0            1,697          1       1,697.0    1,697.0     1,697        1,697           0.0  cuModuleGetLoadingMode

[6/8] Executing 'cuda_gpu_kern_sum' stats report
SKIPPED: /kaggle/working/report2.sqlite does not contain CUDA kernel data.
[7/8] Executing 'cuda_gpu_mem_time_sum' stats report

 Time (%)  Total Time (ns)  Count   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)      Operation     
 --------  ---------------  -----  -----------  -----------  ---------  ---------  -----------  ------------------
     58.2        2,152,862      1  2,152,862.0  2,152,862.0  2,152,862  2,152,862          0.0  [CUDA memcpy DtoH]
     41.8        1,546,632      2    773,316.0    773,316.0    771,700    774,932      2,285.4  [CUDA memcpy HtoD]

[8/8] Executing 'cuda_gpu_mem_size_sum' stats report

 Total (MB)  Count  Avg (MB)  Med (MB)  Min (MB)  Max (MB)  StdDev (MB)      Operation     
 ----------  -----  --------  --------  --------  --------  -----------  ------------------
      8.389      2     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy HtoD]
      4.194      1     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy DtoH]

Generated:
    /kaggle/working/report2.nsys-rep
    /kaggle/working/report2.sqlite
```
#### Comparison between naive_matmul and tiled_matmul
Naive Matrix Multiplication
```bash
!nvcc -o naive_matmul naive_matmul.cu -lnvToolsExt
!nsys profile --stats=true ./naive_matmul
```
Report
```
Generating '/tmp/nsys-report-fc97.qdstrm'
[1/8] [========================100%] report4.nsys-rep
[2/8] [========================100%] report4.sqlite
[3/8] Executing 'nvtx_sum' stats report
SKIPPED: /kaggle/working/report4.sqlite does not contain NV Tools Extension (NVTX) data.
[4/8] Executing 'osrt_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)     Med (ns)    Min (ns)   Max (ns)     StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  -----------  --------  -----------  -------------  ----------------------
     86.7      648,098,240         13  49,853,710.8  4,508,002.0     2,839  529,472,115  144,841,244.2  poll                  
     12.2       91,011,840        657     138,526.4     25,238.0     1,839   24,018,667    1,032,613.1  ioctl                 
      0.6        4,525,869         29     156,064.4     15,914.0    10,302    3,490,971      643,002.9  mmap64                
      0.2        1,178,297          9     130,921.9     59,679.0    35,544      714,475      219,548.2  sem_timedwait         
      0.1          648,166         54      12,003.1     11,841.5     5,516       19,302        3,550.6  open64                
      0.1          551,758         53      10,410.5      7,005.0     3,582       61,133        9,834.0  fopen                 
      0.0          326,668         15      21,777.9     10,967.0     3,381      168,576       41,265.2  mmap                  
      0.0          205,738         49       4,198.7      3,269.0     2,150       33,130        4,398.6  fclose                
      0.0          192,200          2      96,100.0     96,100.0    69,642      122,558       37,417.3  pthread_create        
      0.0          158,819        143       1,110.6         92.0        51       90,776        7,902.3  fgets                 
      0.0          156,627          1     156,627.0    156,627.0   156,627      156,627            0.0  pthread_cond_wait     
      0.0          123,134         12      10,261.2      7,660.0     2,835       49,364       12,522.6  write                 
      0.0          118,943         71       1,675.3      1,567.0     1,042        5,354          566.4  fcntl                 
      0.0           58,216          6       9,702.7      9,708.5     4,291       13,635        3,288.6  open                  
      0.0           51,118          2      25,559.0     25,559.0    15,860       35,258       13,716.5  socket                
      0.0           47,993          4      11,998.3      9,839.0     7,705       20,610        5,928.0  munmap                
      0.0           43,118         15       2,874.5      2,512.0     2,047        5,063          880.7  read                  
      0.0           34,569          3      11,523.0     10,051.0     9,419       15,099        3,113.0  pipe2                 
      0.0           31,915          5       6,383.0      4,255.0       117       15,018        6,886.6  fread                 
      0.0           21,241          3       7,080.3      6,652.0     5,790        8,799        1,549.6  fopen64               
      0.0           16,293          2       8,146.5      8,146.5     3,516       12,777        6,548.5  pthread_cond_broadcast
      0.0           12,326          8       1,540.8      1,587.0     1,320        1,655          130.5  dup                   
      0.0           10,731          1      10,731.0     10,731.0    10,731       10,731            0.0  connect               
      0.0            8,838          2       4,419.0      4,419.0     3,787        5,051          893.8  fwrite                
      0.0            2,990          1       2,990.0      2,990.0     2,990        2,990            0.0  bind                  
      0.0            2,196          1       2,196.0      2,196.0     2,196        2,196            0.0  listen                
      0.0              451         10          45.1         41.0        40           81           12.6  fflush                

[5/8] Executing 'cuda_api_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)     Med (ns)    Min (ns)    Max (ns)    StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  -----------  ---------  -----------  ------------  ----------------------
     89.0      133,340,930          3  44,446,976.7    145,010.0    124,731  133,071,189  76,750,819.9  cudaMalloc            
      6.1        9,193,554          1   9,193,554.0  9,193,554.0  9,193,554    9,193,554           0.0  cudaDeviceSynchronize 
      4.3        6,390,628          3   2,130,209.3  1,009,535.0    997,743    4,383,350   1,951,286.0  cudaMemcpy            
      0.4          673,036          3     224,345.3    243,188.0    173,037      256,811      44,953.4  cudaFree              
      0.2          294,661          1     294,661.0    294,661.0    294,661      294,661           0.0  cudaLaunchKernel      
      0.0            1,620          1       1,620.0      1,620.0      1,620        1,620           0.0  cuModuleGetLoadingMode

[6/8] Executing 'cuda_gpu_kern_sum' stats report

 Time (%)  Total Time (ns)  Instances   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)                            Name                          
 --------  ---------------  ---------  -----------  -----------  ---------  ---------  -----------  --------------------------------------------------------
    100.0        9,185,934          1  9,185,934.0  9,185,934.0  9,185,934  9,185,934          0.0  matrixMultiply(float *, float *, float *, int, int, int)

[7/8] Executing 'cuda_gpu_mem_time_sum' stats report

 Time (%)  Total Time (ns)  Count   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)      Operation     
 --------  ---------------  -----  -----------  -----------  ---------  ---------  -----------  ------------------
     59.0        2,300,188      1  2,300,188.0  2,300,188.0  2,300,188  2,300,188          0.0  [CUDA memcpy DtoH]
     41.0        1,595,303      2    797,651.5    797,651.5    787,828    807,475     13,892.5  [CUDA memcpy HtoD]

[8/8] Executing 'cuda_gpu_mem_size_sum' stats report

 Total (MB)  Count  Avg (MB)  Med (MB)  Min (MB)  Max (MB)  StdDev (MB)      Operation     
 ----------  -----  --------  --------  --------  --------  -----------  ------------------
      8.389      2     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy HtoD]
      4.194      1     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy DtoH]

Generated:
    /kaggle/working/report4.nsys-rep
    /kaggle/working/report4.sqlite
```
---
Tiled Matrix Multiplication













