all: 
        gcc -g matrixGenerator.c -o a.out
        mpicc -g cpu_mult.c -o cpu.o
        mpixlc -g gpu_mult.c -c -o main.o
        nvcc -g -G test.cu -c -o test.o
        mpixlc -g main.o test.o -o test-exe -L/usr/local/cuda-11.2/lib64/ -lcudadevrt -lcudart -lstdc++

