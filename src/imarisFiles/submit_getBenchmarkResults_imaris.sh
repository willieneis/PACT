#!/bin/sh

#Torque directives
#PBS -N main
#PBS -W group_list=hpcstats
#PBS -l nodes=1,walltime=24:00:00,mem=2000mb
#PBS -M ddp4mtt.jobs@gmail.com
#PBS -V


# make test directory, set output and error directories, and run matlab script

#PBS -o localhost:./
#PBS -e localhost:./

#define parameters
matlab -nosplash -nodisplay -nodesktop -singleCompThread -r "getBenchmarkResults_imaris" > ./out

#End of script
