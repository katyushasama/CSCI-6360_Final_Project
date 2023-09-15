#!/bin/bash -x

module load spectrum-mpi

#####################################################################################################
# Launch N tasks per compute node allocated. Per below this launches 32 MPI rank per compute node.
# taskset insures that hyperthreaded cores are skipped.
#####################################################################################################
RANKS_PER_NODE=$1
taskset -c 0-159:4 mpirun -N $RANKS_PER_NODE /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/test-exe

