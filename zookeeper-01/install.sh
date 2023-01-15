#!/bin/bash
# Install Java11
sudo yum install -y java-11-openjdk-devel.x86_64
echo "export JAVA_HOME=$(readlink -f  $(which java) | sed 's|/bin/java||' | sed 's/^ //g')" >> /etc/profile
source /etc/profile

# Install kafka
curl -O https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz 
tar xvf kafka_2.12-2.8.0.tgz
rm -rf kafka_2.12-2.8.0.tgz

sudo mv /kafka-cluster-install/zookeeper-01/zookeeper.properties kafka_2.12-2.8.0/config/zookeeper.properties

# Run zookeeper
kafka_2.12-2.8.0/bin/zookeeper-server-start.sh -daemon kafka_2.12-2.8.0/config/zookeeper.properties