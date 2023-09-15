#include<cstdio>
#include "matrix.h"

//Matrix Vector Multiplication
#define NTHREADS_X 32
#define NTHREADS_Y 32

__global__ void MatrixMultiplication(float *a, float *b, float *c, int a_ncolumns, int c_nlines, int c_ncolumns,int rank)
{  	
    int column = blockIdx.x * blockDim.x + threadIdx.x;
    int line =  blockIdx.y * blockDim.y + threadIdx.y;

    if (column  >= c_ncolumns || line >= c_nlines)
        return;

    int i = 0;
    float sum = 0.0;

    int beginA = a_ncolumns * line;
    int beginB = column;

    for (i = 0; i < a_ncolumns; i++)
    {
        sum += a[beginA + i] * b[i * c_ncolumns + beginB];
    }

    c[line * c_ncolumns + column] = sum;
}

extern "C" 
Matrix cudaInit(int myrank, const float* MyMatrixA, const float* MatrixB, int ColsNo, const int elements, const int size, const size_t matrixbsize){
    cudaError_t cE;
    int cudaDeviceCount;
    cE = cudaGetDeviceCount(&cudaDeviceCount);
    if(cE != cudaSuccess){
        printf("Unable to determine cuda device count, error is %d, count is %d\n", cE, cudaDeviceCount);
        exit(-1);
    }
    cE = cudaSetDevice(myrank % cudaDeviceCount);
    if(cE != cudaSuccess){
        printf("Unable to have rank %d set to cuda device %d, error is %d \n", myrank, (myrank % cudaDeviceCount), cE);
        exit(-1);
    }
    Matrix M;
    M.sizeA = size;
    M.sizeB = matrixbsize;

	//Allocating the Memory on the device memory
	cudaMallocManaged( (void **)&M.MatrixA, size * ColsNo * sizeof(float) );
	cudaMallocManaged( (void **)&M.MatrixB, matrixbsize*sizeof(float) );
	cudaMallocManaged( (void **)&M.result, elements * sizeof(float) );

	//Copying the data from host to device
	cudaMemcpy( (void *)M.MatrixA, (void *)MyMatrixA, size * ColsNo * sizeof(float), cudaMemcpyHostToDevice );
	cudaMemcpy( (void *)M.MatrixB, (void *)MatrixB,  matrixbsize*sizeof(float), cudaMemcpyHostToDevice );
    return M;
}

extern "C" 
void cudaReduce(float* MyResultMatrix, Matrix* M, int elements, int RowsNo, int ColsNo, int RowsNo2, int ColsNo2, int size, int rank){
        dim3 blocks = dim3(
                    (int) std::ceil( (double) ColsNo/ NTHREADS_X ),
                    (int) std::ceil ( (double) (RowsNo/size)/ NTHREADS_Y ),
                    1
                );

    dim3 threads = dim3(
                        NTHREADS_X,
                        NTHREADS_Y,
                        1
                    );
    MatrixMultiplication<<<blocks, threads>>>(M->MatrixA, M->MatrixB, M->result, RowsNo2,RowsNo/size,ColsNo,rank);	
	cudaMemcpy( (void *)MyResultMatrix, (void *)M->result, elements * sizeof(float), cudaMemcpyDeviceToHost );
	cudaDeviceSynchronize();
}