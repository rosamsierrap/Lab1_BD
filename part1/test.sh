#!/bin/sh
../start.sh
/usr/local/hadoop/bin/hdfs dfs -rm -r /part1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /part1/output/
/usr/local/hadoop/bin/hdfs dfs -mkdir -p /part1/input/
/usr/local/hadoop/bin/hdfs dfs -copyFromLocal ../data/access.log /part1/input/
/usr/local/hadoop/bin/hadoop jar /usr/local/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.3.1.jar \
-file ../part1/mapper.py -mapper ../part1/mapper.py \
-file ../part1/reducer.py -reducer ../part1/reducer.py \
-input /part1/input/* -output /part1/output/
/usr/local/hadoop/bin/hdfs dfs -cat /part1/output/part-00000
/usr/local/hadoop/bin/hdfs dfs -rm -r /part1/input/
/usr/local/hadoop/bin/hdfs dfs -rm -r /part1/output/
../stop.sh
