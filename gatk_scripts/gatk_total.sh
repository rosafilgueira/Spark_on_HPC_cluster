#!/bin/bash
#PBS -N Gatk_Total
#PBS -l select=1:ncpus=72
#PBS -l place=excl
#PBS -l walltime=03:00:00

module load anaconda
module load mpt

cd $PBS_O_WORKDIR

export SPARK_HOME=/lustre/home//<USER>/spark-2.3.1-bin-hadoop2.7
export REF=/lustre/home/<USER>/gatk/GRCh37.2bit
export PATH=/lustre/home/<USER>/gatk/gatk-4.0.4.0:$PATH
export DBSNP=/lustre/home/<USER>/gatk/dbsnp-147.vcf.gz

gatk BaseRecalibratorSpark \
--java-options '-Djava.io.tmpdir=/lustre/home//<USER>/gatk/tmp ' \
-R $REF \
-I /lustre/home/<USER>/gatk/FullGatk4.raw.bam \
--known-sites $DBSNP \
-O gatk4.recal.table.tmp \
-- \
--spark-runner SPARK --verbose --spark-master spark://<MASTER_URL>:7077 \
--total-executor-cores 720 \
--executor-memory 250G 

gatk ApplyBQSRSpark \
--java-options '-Djava.io.tmpdir=/lustre/home/<USER>/gatk/tmp ' \
-I /lustre/home/<USER>/gatk/FullGatk4.raw.bam \
--bqsr-recal-file gatk4.recal.table \
-O /lustre/home//<USER>/gatk/gatk4_v14.bam \
-- \
--spark-runner SPARK --verbose --spark-master spark://<MASTER_URL>:7077 \
--total-executor-cores 720 \
--executor-memory 250G 

