# Spark_on_HPC_cluster
This repository describe the steps necesaries to create a Spark cluster within a PBS-job. We have tested those scripts using Cirrus HPC cluster, hosted at EPCC ( Universtiy of Edinburgh)

# Download Spark
wget http://apache.mirror.anlx.net/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
tar xvf spark-2.3.1-bin-hadoop2.7

# Change the Spark configurable files
cp spark_conf/* spark-2.3.1-bin-hadoop2.7/conf/.

# Start a Spark cluster within a PBS job
In this example we are going to configure 1 node as a master and 10 nodes as workers

cp spark_scripts/* in your $HOME directory
cp -r bash_scripts in your $HOME directory

./spark_start
Note: All the necesary scripts ( for starting the master and the workers) are under bash_scripts directory


# Submit a spark application to the Spark cluster
Once you have the spark cluster running ( your PBS job has been accepted and you have the resoureces available), you can submit spark applications to it. 
In this example we are going to submit two genomics spark applications to i. 
Note: Change the master URL - check the bash_scripts/master.log 

./gat_total.sh 

#Dowloading the lustre-connector
You might need to have the luster-connector. Those are the steps in case you need it.
git clone https://github.com/whamcloud/lustre-connector-for-hadoop.git
cd lustre-connector-for-hadoop
mvn package
check ->  /lustre/home/<USERNAME>lustre-connector-for-hadoop/target/classes/META-INF/services/org.apache.hadoop.fs.FileSystem  - uses # instead of / for comments

