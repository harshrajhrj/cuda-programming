# Profiling Matrix Multiplication
#### Profiling using NVTX library
Follow up commands to run the script
```bash
!nvcc -o nvtx_matmul nvtx_matmul.cu -lnvToolsExt
!nsys profile --stats=true ./nvtx_matmul
```
Report
```
Generating '/tmp/nsys-report-e103.qdstrm'
[1/8] [========================100%] report6.nsys-rep
[2/8] [========================100%] report6.sqlite
[3/8] Executing 'nvtx_sum' stats report

 Time (%)  Total Time (ns)  Instances    Avg (ns)       Med (ns)      Min (ns)     Max (ns)    StdDev (ns)   Style            Range         
 --------  ---------------  ---------  -------------  -------------  -----------  -----------  -----------  -------  -----------------------
     50.0      653,152,055          1  653,152,055.0  653,152,055.0  653,152,055  653,152,055          0.0  PushPop  Matrix Multiplication  
     47.1      614,957,243          1  614,957,243.0  614,957,243.0  614,957,243  614,957,243          0.0  PushPop  Memory Allocation      
      2.4       31,660,737          1   31,660,737.0   31,660,737.0   31,660,737   31,660,737          0.0  PushPop  Kernel Execution       
      0.3        3,970,313          1    3,970,313.0    3,970,313.0    3,970,313    3,970,313          0.0  PushPop  Memory Copy Device2Host
      0.1        1,941,978          1    1,941,978.0    1,941,978.0    1,941,978    1,941,978          0.0  PushPop  Memory Copy Host2Device
      0.0          615,749          1      615,749.0      615,749.0      615,749      615,749          0.0  PushPop  Memory Deallocation    

[4/8] Executing 'osrt_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)     Med (ns)    Min (ns)   Max (ns)     StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  -----------  --------  -----------  -------------  ----------------------
     87.6      599,869,069         13  46,143,774.5  3,748,390.0     3,518  499,291,116  136,919,396.5  poll                  
     11.5       78,508,289        657     119,495.1     20,481.0     1,274   21,142,938      982,011.6  ioctl                 
      0.5        3,361,319         29     115,907.6     12,226.0    10,001    2,572,023      473,505.8  mmap64                
      0.1          779,587         10      77,958.7     70,454.5    54,990      114,687       21,801.2  sem_timedwait         
      0.1          519,139         54       9,613.7      9,499.5     4,455       19,343        3,006.0  open64                
      0.1          508,808         55       9,251.1      5,850.0     2,287       42,549        8,708.5  fopen                 
      0.0          240,328         15      16,021.9      8,410.0     1,966      103,470       24,971.4  mmap                  
      0.0          190,231          1     190,231.0    190,231.0   190,231      190,231            0.0  pthread_cond_wait     
      0.0          158,760          2      79,380.0     79,380.0    58,212      100,548       29,936.1  pthread_create        
      0.0          152,235         50       3,044.7      2,375.0     1,820       10,415        1,581.6  fclose                
      0.0          119,108        143         832.9         54.0        44       73,849        6,386.6  fgets                 
      0.0          104,869         73       1,436.6      1,295.0       896        5,311          739.3  fcntl                 
      0.0           81,055         12       6,754.6      7,180.5     2,721        9,173        1,955.7  write                 
      0.0           45,989         15       3,065.9      2,718.0     1,864        6,418        1,263.7  read                  
      0.0           44,987          6       7,497.8      6,589.5     3,166       13,014        3,576.8  open                  
      0.0           35,900          3      11,966.7     13,912.0     7,717       14,271        3,684.7  pipe2                 
      0.0           31,606          6       5,267.7      3,782.0       135       19,294        7,107.6  fwrite                
      0.0           29,409          3       9,803.0      9,405.0     8,248       11,756        1,787.5  munmap                
      0.0           28,526          2      14,263.0     14,263.0     9,080       19,446        7,329.9  socket                
      0.0           18,839          2       9,419.5      9,419.5     3,557       15,282        8,290.8  pthread_cond_broadcast
      0.0           18,263          4       4,565.8      2,514.5        86       13,148        6,161.6  fread                 
      0.0           16,166          3       5,388.7      4,228.0     4,047        7,891        2,169.0  fopen64               
      0.0           11,228          1      11,228.0     11,228.0    11,228       11,228            0.0  connect               
      0.0            9,027          8       1,128.4      1,133.5       969        1,366          140.8  dup                   
      0.0            8,074         11         734.0         36.0        35        7,568        2,267.0  fflush                
      0.0            2,707          1       2,707.0      2,707.0     2,707        2,707            0.0  bind                  
      0.0            1,920          1       1,920.0      1,920.0     1,920        1,920            0.0  listen                

[5/8] Executing 'cuda_api_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)      Med (ns)     Min (ns)    Max (ns)    StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  ------------  ----------  -----------  ------------  ----------------------
     74.0      108,367,729          3  36,122,576.3     150,124.0     130,921  108,086,684  62,322,746.1  cudaMalloc            
     15.3       22,455,165          1  22,455,165.0  22,455,165.0  22,455,165   22,455,165           0.0  cudaLaunchKernel      
      6.3        9,198,427          1   9,198,427.0   9,198,427.0   9,198,427    9,198,427           0.0  cudaDeviceSynchronize 
      4.0        5,897,463          3   1,965,821.0     982,021.0     947,661    3,967,781   1,733,833.3  cudaMemcpy            
      0.4          612,197          3     204,065.7     216,844.0     171,000      224,353      28,880.8  cudaFree              
      0.0            2,350          1       2,350.0       2,350.0       2,350        2,350           0.0  cuModuleGetLoadingMode

[6/8] Executing 'cuda_gpu_kern_sum' stats report

 Time (%)  Total Time (ns)  Instances   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)                       Name                      
 --------  ---------------  ---------  -----------  -----------  ---------  ---------  -----------  -----------------------------------------------
    100.0        9,194,847          1  9,194,847.0  9,194,847.0  9,194,847  9,194,847          0.0  matrixMulKernel(float *, float *, float *, int)

[7/8] Executing 'cuda_gpu_mem_time_sum' stats report

 Time (%)  Total Time (ns)  Count   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)      Operation     
 --------  ---------------  -----  -----------  -----------  ---------  ---------  -----------  ------------------
     57.5        2,052,565      1  2,052,565.0  2,052,565.0  2,052,565  2,052,565          0.0  [CUDA memcpy DtoH]
     42.5        1,516,961      2    758,480.5    758,480.5    757,137    759,824      1,900.0  [CUDA memcpy HtoD]

[8/8] Executing 'cuda_gpu_mem_size_sum' stats report

 Total (MB)  Count  Avg (MB)  Med (MB)  Min (MB)  Max (MB)  StdDev (MB)      Operation     
 ----------  -----  --------  --------  --------  --------  -----------  ------------------
      8.389      2     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy HtoD]
      4.194      1     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy DtoH]

Generated:
    /kaggle/working/report6.nsys-rep
    /kaggle/working/report6.sqlite
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
[Tiled Matrix Multiplication](https://penny-xu.github.io/blog/tiled-matrix-multiplication)
```bash
!nvcc -o tiled_matmul tiled_matmul.cu -lnvToolsExt
!nsys profile --stats=true ./tiled_matmul
```
Report
```
Generating '/tmp/nsys-report-f10d.qdstrm'
[1/8] [========================100%] report5.nsys-rep
[2/8] [========================100%] report5.sqlite
[3/8] Executing 'nvtx_sum' stats report
SKIPPED: /kaggle/working/report5.sqlite does not contain NV Tools Extension (NVTX) data.
[4/8] Executing 'osrt_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)     Med (ns)    Min (ns)   Max (ns)     StdDev (ns)            Name         
 --------  ---------------  ---------  ------------  -----------  --------  -----------  -------------  ----------------------
     89.0      715,318,622         15  47,687,908.1  4,458,848.0     4,020  414,489,982  106,017,804.8  poll                  
     10.2       81,907,463        657     124,668.9     21,163.0     1,228   22,010,283    1,003,653.7  ioctl                 
      0.4        3,182,111         29     109,728.0     12,829.0    10,549    2,379,307      437,589.2  mmap64                
      0.1          677,291         10      67,729.1     69,420.0    43,279       92,491       14,719.1  sem_timedwait         
      0.1          611,653         56      10,922.4      5,902.0     2,262       78,250       13,159.7  fopen                 
      0.1          592,878         54      10,979.2     10,269.0     3,906       33,009        4,662.2  open64                
      0.0          280,990         15      18,732.7     14,504.0     2,042       98,365       24,084.6  mmap                  
      0.0          236,123          1     236,123.0    236,123.0   236,123      236,123            0.0  pthread_cond_wait     
      0.0          182,281         50       3,645.6      3,012.0     2,023       19,875        2,966.2  fclose                
      0.0          177,455          2      88,727.5     88,727.5    69,633      107,822       27,003.7  pthread_create        
      0.0          124,442        143         870.2         53.0        45       82,036        7,024.4  fgets                 
      0.0          113,758         73       1,558.3      1,345.0       914        9,733        1,141.3  fcntl                 
      0.0           81,235         12       6,769.6      7,070.0     2,603       10,900        2,112.1  write                 
      0.0           48,931          6       8,155.2      7,876.5     3,258       14,589        4,037.7  open                  
      0.0           41,258         15       2,750.5      2,479.0     1,616        5,245        1,020.8  read                  
      0.0           33,115          3      11,038.3     13,423.0     6,031       13,661        4,338.1  pipe2                 
      0.0           32,070          6       5,345.0      4,790.5       133       13,300        4,445.7  fwrite                
      0.0           27,581          2      13,790.5     13,790.5    10,225       17,356        5,042.4  socket                
      0.0           25,631          2      12,815.5     12,815.5     3,279       22,352       13,486.6  fread                 
      0.0           23,716          3       7,905.3      7,515.0     6,565        9,636        1,572.3  munmap                
      0.0           18,996          2       9,498.0      9,498.0     3,309       15,687        8,752.6  pthread_cond_broadcast
      0.0           15,225          3       5,075.0      4,266.0     4,039        6,920        1,601.8  fopen64               
      0.0           11,255          1      11,255.0     11,255.0    11,255       11,255            0.0  connect               
      0.0            9,330          8       1,166.3      1,147.5       999        1,453          145.5  dup                   
      0.0            6,026         11         547.8         81.0        38        5,085        1,506.1  fflush                
      0.0            2,512          1       2,512.0      2,512.0     2,512        2,512            0.0  bind                  
      0.0            1,949          1       1,949.0      1,949.0     1,949        1,949            0.0  listen                

[5/8] Executing 'cuda_api_sum' stats report

 Time (%)  Total Time (ns)  Num Calls    Avg (ns)       Med (ns)      Min (ns)     Max (ns)    StdDev (ns)            Name         
 --------  ---------------  ---------  -------------  -------------  -----------  -----------  ------------  ----------------------
     49.9      163,016,679          1  163,016,679.0  163,016,679.0  163,016,679  163,016,679           0.0  cudaLaunchKernel      
     45.3      148,102,081          3   49,367,360.3      240,509.0      179,445  147,682,127  85,143,091.0  cudaMalloc            
      2.7        8,976,802          3    2,992,267.3    2,130,634.0    1,362,013    5,484,155   2,191,990.6  cudaMemcpy            
      1.8        5,803,365          1    5,803,365.0    5,803,365.0    5,803,365    5,803,365           0.0  cudaDeviceSynchronize 
      0.2          814,538          3      271,512.7      274,100.0      260,708      279,730       9,771.4  cudaFree              
      0.0            1,420          1        1,420.0        1,420.0        1,420        1,420           0.0  cuModuleGetLoadingMode

[6/8] Executing 'cuda_gpu_kern_sum' stats report

 Time (%)  Total Time (ns)  Instances   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)                                Name                               
 --------  ---------------  ---------  -----------  -----------  ---------  ---------  -----------  -----------------------------------------------------------------
    100.0        5,794,919          1  5,794,919.0  5,794,919.0  5,794,919  5,794,919          0.0  matrixMultiplyOptimized(float *, float *, float *, int, int, int)

[7/8] Executing 'cuda_gpu_mem_time_sum' stats report

 Time (%)  Total Time (ns)  Count   Avg (ns)     Med (ns)    Min (ns)   Max (ns)   StdDev (ns)      Operation     
 --------  ---------------  -----  -----------  -----------  ---------  ---------  -----------  ------------------
     58.7        3,044,096      1  3,044,096.0  3,044,096.0  3,044,096  3,044,096          0.0  [CUDA memcpy DtoH]
     41.3        2,137,460      2  1,068,730.0  1,068,730.0  1,052,938  1,084,522     22,333.3  [CUDA memcpy HtoD]

[8/8] Executing 'cuda_gpu_mem_size_sum' stats report

 Total (MB)  Count  Avg (MB)  Med (MB)  Min (MB)  Max (MB)  StdDev (MB)      Operation     
 ----------  -----  --------  --------  --------  --------  -----------  ------------------
      8.389      2     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy HtoD]
      4.194      1     4.194     4.194     4.194     4.194        0.000  [CUDA memcpy DtoH]

Generated:
    /kaggle/working/report5.nsys-rep
    /kaggle/working/report5.sqlite
```




















