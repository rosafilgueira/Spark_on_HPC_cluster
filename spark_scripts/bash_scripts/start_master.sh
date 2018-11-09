#!/bin/bash

export SPARK_HOME=/lustre/home/<USER>/spark-2.3.1-bin-hadoop2.7
cd $SPARK_HOME/

sbin/start-master.sh
echo "Started spark Master $HOSTNAME"
