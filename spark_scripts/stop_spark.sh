#!/bin/bash --login

export SPARK_HOME=$HOME/spark-2.4.0-bin-hadoop2.7

$SPARK_HOME/sbin/stop-master.sh
$SPARK_HOME/sbin/stop-history-server.sh
$SPARK_HOME/sbin/stop-slaves.sh
