#!/bin/bash
#PBS -N Spark
#PBS -l walltime=5:00:00
#PBS -l select=11:ncpus=72
#PBS -l place=excl
#PBS -A xxxxx

module load mpt

export NUM_NODES=11
export SPARK_HOME=/lustre/home/<USER>/spark-2.3.1-bin-hadoop2.7
export JAVA_HOME=/lustre/sw/spack/opt/spack/linux-centos7-x86_64/gcc-6.2.0/jdk-8u92-linux-x64-24xtmiygsdlaayomilfa5mnrasmxqlhj

cd $HOME/bash_scripts

# start resource manager only once
echo "`hostname`" > master.log
mastername=`hostname`
echo "Started master on" $mastername

export MPI_SHEPHERD=true
mpiexec_mpt -n $NUM_NODES -ppn 1 $HOME/bash_scripts/start_slave.sh $mastername &

sleep 5h
