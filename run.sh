#!/bin/bash -x

module load spectrum-mpi

#1 node
./a.out
sbatch -p el8 -N 1 --gres=gpu:6 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult6.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult6.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum.sh 6
sbatch -p el8 -N 1 --gres=gpu:4 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult32.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult32.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum1.sh 32
#2node
./a.out
sbatch -p el8 -N 2 --gres=gpu:6 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult12.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult12.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum.sh 6
sbatch -p el8 -N 2 --gres=gpu:4 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult64.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult64.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum1.sh 32
#3node
./a.out
sbatch -p el8 -N 4 --gres=gpu:6 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult18.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult18.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum.sh 6
sbatch -p el8 -N 4 --gres=gpu:4 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult128.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult128.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum1.sh 32
#4node
./a.out
sbatch -p el8 -N 8 --gres=gpu:6 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult24.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/gpu_mult24.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum.sh 6
sbatch -p el8 -N 8 --gres=gpu:4 --mail-type=ALL --mail-user=yanz9@rpi.edu -t 2 -D /gpfs/u/home/PCPC/PCPCnzhe/scratch/project -o /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult256.stdout -e /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/cpu_mult256.stderr /gpfs/u/home/PCPC/PCPCnzhe/scratch/project/slurmNewSpectrum1.sh 32