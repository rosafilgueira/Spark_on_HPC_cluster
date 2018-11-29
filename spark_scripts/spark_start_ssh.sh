#!/bin/bash
#PBS -N Spark
#PBS -l walltime=16:00:00
#PBS -l select=10:ncpus=36
#PBS -l place=scatter:excl
#PBS -A XXX

export NUM_NODES=10
export SPARK_HOME=/lustre/home/z04/rosaf2/spark-2.3.1-bin-hadoop2.7
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
rm -f slaves.log
for i in "${nodes[@]}"
do
    echo $i >> slaves.log
    ssh $i "cd $HOME/bash_scripts; ./start_slave.sh $mastername" &
done

sleep 16h
