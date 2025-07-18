# cudNN
[Convolution Visualizer](https://ezyang.github.io/convolution-visualizer/)

---
Compile
```!nvcc -o Tanh Tanh.cu -lcudnn```<br>
Run
```!./Tanh```
```
Tensor size: 256 x 32 x 224 x 224
Average Naive CUDA kernel time: 13.213 ms
Average cuDNN activation time: 13.535 ms
Speedup: 0.98x
Naive kernel results correct: Yes
cuDNN results correct: Yes
```
