/*
 * Copyright 1993-2015 NVIDIA Corporation.  All rights reserved.
 *
 * Please refer to the NVIDIA end user license agreement (EULA) associated
 * with this source code for terms and conditions that govern your use of
 * this software. Any use, reproduction, disclosure, or distribution of
 * this software and related documentation outside the terms of the EULA
 * is strictly prohibited.
 *
 */

#ifndef __MATRIX_H__
#define __MATRIX_H__

typedef struct Matrix{
    size_t sizeA;
    size_t sizeB;
    float* MatrixA;
    float* MatrixB;
    float* result;
} Matrix;

#ifdef __cplusplus
extern "C" {
#endif

Matrix cudaInit(int myrank, const float* MyMatrixA, const float* MatrixB, int ColsNo, const int elements, const int size, const size_t matrixbsize);
void cudaReduce(float* MyResultMatrix, Matrix* matrix, int elements, int RowsNo, int ColsNo, int RowsNo2, int ColsNo2, int size,int rank);

#ifdef __cplusplus
}
#endif
#endif
