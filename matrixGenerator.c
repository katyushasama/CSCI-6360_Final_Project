#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MATRIX_SIZE 1000

int MatrixInit(float **MatrixA, float **MatrixB, float **ResultVector, int RowsNo, int ColsNo, int RowsNo2, int ColsNo2)
{
  float *TempMatrixA, *TempVectorB, *TempResultVector, *TempMatrixB;
  int Status, Index;

  //Allocating memory on the host
  TempMatrixA = (float *)malloc(RowsNo * ColsNo * sizeof(float));
  if(TempMatrixA == NULL)
    Status = 0;
  TempMatrixB = (float *)malloc(RowsNo2 * ColsNo2 * sizeof(float));
  if(TempMatrixB == NULL)
    Status = 0;
  TempResultVector = (float *)malloc(RowsNo * ColsNo2 * sizeof(float));
  if(TempResultVector == NULL)
    Status = 0;

  //Intializing the Matrix and the Vectors

  int a=10;
  for(Index = 0; Index < RowsNo*ColsNo; Index++)
  {
    TempMatrixA[Index] = (float)rand()/(float)(RAND_MAX/a);
  }
  printf("Matrix A initialized\n");

  for(Index = 0; Index < RowsNo2 * ColsNo2; Index++)
  {   
    TempMatrixB[Index] = (float)rand()/(float)(RAND_MAX/a);
     
  }
  printf("Matrix B initilized\n");

  for(Index = 0; Index < ColsNo2 * RowsNo; Index++)
  {
    TempResultVector[Index] = 0.0f;
  }


  *MatrixA = TempMatrixA;
  *MatrixB = TempMatrixB;
  *ResultVector = TempResultVector;
  
  return(Status);
}

int main() {
	  // initialize random number generator
  int Status;

  // generate random matrices A and B
  float *MatrixA, *ResultVector, *MatrixB;

  Status = MatrixInit(&MatrixA, &MatrixB, &ResultVector, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE, MATRIX_SIZE);

  //write matrices A and B to binary files
  FILE* fileA = fopen("inputA.bin", "wb");
  FILE* fileB = fopen("inputB.bin", "wb");
  fwrite(MatrixA, sizeof(float), MATRIX_SIZE*MATRIX_SIZE, fileA);
  fwrite(MatrixB, sizeof(float), MATRIX_SIZE*MATRIX_SIZE, fileB);

  // close files
  fclose(fileA);
  fclose(fileB);
  
  return 0;
}