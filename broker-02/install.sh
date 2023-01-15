#!/bin/bash
# Install Java11
sudo yum install -y java-11-openjdk-devel.x86_64
echo "export JAVA_HOME=$(readlink -f  $(which java) | sed 's|/bin/java||' | sed 's/^ //g')" >> /etc/profile
source /etc/profile

# Install kafka
curl -O https://archive.apache.org/dist/kafka/2.8.0/kafka_2.12-2.8.0.tgz 
tar xvf kafka_2.12-2.8.0.tgz
rm -rf kafka_2.12-2.8.0.tgz

sudo mv /kafka-cluster-install/broker-02/server.properties kafka_2.12-2.8.0/config/server.properties

# Run kafka
export KAFKA_JMX_OPTS='-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false 
  -Dcom.sun.management.jmxremote.ssl=false 
  -Dcom.sun.management.jmxremote.port=9999 
  -Dcom.sun.management.jmxremote.rmi.port=9999 
  -Djava.rmi.server.hostname=0.0.0.0'
env JMX_PORT=9999 kafka_2.12-2.8.0/bin/kafka-server-start.sh -daemon kafka_2.12-2.8.0/config/server.properties
