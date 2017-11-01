#!/bin/bash
# Job name:
#SBATCH --job-name=test
#
# Account:
#SBATCH --account=ic_stat243
#
# Partition:
#SBATCH --partition=savio
#
# Wall clock limit (30 minutes here):
#SBATCH --time=02:59:59
#
## Command(s) to run:
module load r/3.2.5 doParallel dplyr stringr
R CMD BATCH --no-save ProblemSet6Q4.R ProblemSet6Q4.out

