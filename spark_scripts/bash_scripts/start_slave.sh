#!/bin/bash
 
hostmaster=$1
echo "Received master" $hostmaster
export HOSTNAME=`hostname`
export SPARK_HOME=/lustre/home/<USER>/spark-2.3.1-bin-hadoop2.7

if [ $HOSTNAME != $hostmaster ] ; then
 cd $SPARK_HOME/
 sbin/start-slave.sh $hostmaster:7077
 echo "Started SLAVE on `hostname`"
else
  echo "I am the master - I dont start an slave" $hostmaster
fi

 
 
