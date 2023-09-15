#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include "matrix.h"
#include "clockcycle.h"

#define N 768 // matrix size 768 * 768
#define clock_frequency 512000000

int main(int argc, char **argv)
{
	MPI_File fileA, fileB, fileC;
	MPI_Offset offsetA, offsetB, offsetC;
	MPI_Status status;
	int MyRank, MySize;
	float *MatrixA, *MatrixB, *ResultMatrix;
	int size, matrixbsize;


	//MPI Intialization
	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &MyRank);
	MPI_Comm_size(MPI_COMM_WORLD, &MySize);

	int num_blocks = N / MySize;

	matrixbsize= N*N;

	// open input files
	MPI_File_open(MPI_COMM_WORLD, "inputA.bin", MPI_MODE_RDONLY, MPI_INFO_NULL, &fileA);
	MPI_File_open(MPI_COMM_WORLD, "inputB.bin", MPI_MODE_RDONLY, MPI_INFO_NULL, &fileB);

	// open output file
	MPI_File_open(MPI_COMM_WORLD, "outputC.bin", MPI_MODE_CREATE|MPI_MODE_WRONLY, MPI_INFO_NULL, &fileC);

	// calculate file offset for each process
	offsetA = MyRank * num_blocks * N;
	offsetB = MyRank * num_blocks * N;
	offsetC = MyRank * num_blocks * N;

	int elements;

	//Calculating the Scatter size of the Matrix
	size = N / MySize;

	elements = N*N /MySize;

	//Allocating the memory on the host for the MatrixA and MyResultVector by all nodes

	MatrixA = (float *)malloc(size * N * sizeof(float) );
	
	ResultMatrix = (float *)malloc(elements* sizeof(float));

	MatrixB = (float *)malloc(matrixbsize * sizeof(float));
	

	// read blocks of A and B assigned to each process
	MPI_File_set_view(fileA, offsetA, MPI_FLOAT, MPI_FLOAT, "native", MPI_INFO_NULL);
	MPI_File_read_all(fileA, MatrixA, size*N, MPI_FLOAT, &status);
	MPI_File_set_view(fileB, offsetB, MPI_FLOAT, MPI_FLOAT, "native", MPI_INFO_NULL);
	MPI_File_read_all(fileB, MatrixB, matrixbsize, MPI_FLOAT, &status);
	
	uint64_t start_cycles = clock_now();
	
	for (int i = 0; i < size; i++) {
		for (int j = 0; j < N; j++) {
			float sum = 0.0;
			for (int k = 0; k < N; k++) {
				sum = sum + MatrixA[i*N+k] * MatrixB[k*N+j];
			}
			ResultMatrix[i*N+j] = sum;
		}
	} 

	uint64_t end_cycles = clock_now();
   	double time_in_secs = ((double)(end_cycles - start_cycles)) / clock_frequency;
		
	// write blocks of C assigned to each process
	MPI_File_set_view(fileC, offsetC, MPI_FLOAT, MPI_FLOAT, "native", MPI_INFO_NULL);
	MPI_File_write_all(fileC, ResultMatrix, size*N, MPI_FLOAT, &status);


   	if(MyRank == 0) printf("Time in secs: %lf\n", time_in_secs);

	//Freeing the host memory
	free(MatrixA);
	free(MatrixB);
	free(ResultMatrix);

	MPI_File_close(&fileA);
	MPI_File_close(&fileB);
	MPI_File_close(&fileC);

	MPI_Finalize();

	return(0);
}//End of Main function