# Spark_on_HPC_cluster
This repository describes all the steps necesaries to create a **multinode Spark standalone cluster** within a PBS-job. We have tested those scripts using Cirrus HPC cluster, hosted at EPCC ( Universtiy of Edinburgh)

# Download Spark
	wget http://apache.mirror.anlx.net/spark/spark-2.3.1/spark-2.3.1-bin-hadoop2.7.tgz
	tar xvf spark-2.3.1-bin-hadoop2.7

# Change the Spark configurable files
	cp spark_conf/* spark-2.3.1-bin-hadoop2.7/conf/.
	
	
  Note: JAVA_HOME needs to be updated - in spark-env.sh. You might also want to configure more parameters inside spark-defaults.conf file (e.g. tmp directory or log directory). 
  
# Start a Spark cluster within a PBS job
We have two similar PBS-jobs to provision on-demand and for a specific period of time the desired spark cluster by starting the master, workers and registering all workers against master. 

  	spark_start.sh --> Uses mpiexec_mpt to start the spark workers
  	spart_start_ssh2.sh --> Uses ssh to login into the nodes that have been reserved, and starts the spark worker in each of them. 

Depending on the policy of your cluster, you might want to use one or another PBS script. 

You can modify it as you wish for reserving more or less nodes for your spark cluster. In the current scipt, we have used 11 nodes: one node for running the master, and 10 nodes for running the workers (each worker in one node). 

	cp spark_scripts/* in your $HOME directory
	cp -r bash_scripts in your $HOME directory
	--- Option 1 - using mpiexec_mpt
	./spark_start.sh 
	--- Option 2 - using ssh
	./spark_start_ssh.sh

 Note: All the necesary scripts ( for starting the master and the workers) are under bash_scripts directory. JAVA_HOME needs  to point to your java. 


# Submit spark applications to the Spark cluster
Once you have the spark cluster running ( your PBS job has been accepted and you have the resoureces available), you can submit spark applications to it. 

1) Just as an exmaple, you can find here the PBS job (gatk_total.sh) for running two genomics spark applications (*BaseRecalibratorSpark* and *ApplyBQSRSpark*) in the spark cluster. 

	./gatk_total.sh 
	
2) Another example is the following one, where we submit the SparkPi example to Spark-Cluster from the login node. 

Note: Replace XXXX in the spark://XXXXX:7077, by master node

	spark-2.3.1-bin-hadoop2.7/bin/spark-submit --verbose --class org.apache.spark.examples.SparkPi \ 
	--master spark://XXXXX:7077 --deploy-mode cluster --supervise --executor-memory 2g \
	--total-executor-cores 2 spark-2.3.1-bin-hadoop2.7/examples/jars/spark-examples_2.11-2.3.1.jar 10 >> 	output_spark_cluster &
	

Note: Change the master URL - check the bash_scripts/master.log 

