#!/bin/bash
#PBS -N Spark
#PBS -l walltime=2:00:00
#PBS -l select=2:ncpus=36
#PBS -l place=scatter:excl
#PBS -A XXX

export NUM_NODES=2
export SPARK_HOME=/lustre/home/<USER>/spark-2.3.1-bin-hadoop2.7
export JAVA_HOME=/lustre/sw/spack/opt/spack/linux-centos7-x86_64/gcc-6.2.0/jdk-8u92-linux-x64-24xtmiygsdlaayomilfa5mnrasmxqlhj

cd $HOME/bash_scripts

nodes=($( cat $PBS_NODEFILE | sort | uniq ))
nnodes=${#nodes[@]}
last=$(( $nnodes - 1 ))

echo "`hostname`" > master.log
for each in "${nodes[@]}"
do
  echo "Nodo: $each"
done

# start resource manager only once
./start_master.sh
mastername=$(cat "master.log")
echo "Started master on" $mastername

# start slaves in all the nodes except the one where the master was started
rm -f slaves.log
for i in "${nodes[@]}"
do
    echo $i >> slaves.log
    ssh $i "cd $HOME/bash_scripts; ./start_slave.sh $mastername" &
done

sleep 2h
