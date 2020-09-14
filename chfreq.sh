#!/bin/bash
NUM_CORE=`cat /proc/cpuinfo | grep processor | wc -l`
NUM_CORE=`expr $NUM_CORE \- 1`
for idx in `seq 0 $NUM_CORE`;
do
     cpufreq-set -f $1 -c $idx
done
