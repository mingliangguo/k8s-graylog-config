#!/usr/bin/env bash

# test script

BROKER_LIST=ming-kafka-0.ming-kafka-headless:9092,ming-kafka-1.ming-kafka-headless:9092,ming-kafka-2.ming-kafka-headless:9092
BOOTSTRAP_SERVERS=ming-kafka-0.ming-kafka-headless:9092,ming-kafka-1.ming-kafka-headless:9092,ming-kafka-2.ming-kafka-headless:9092
ZOOKEEPER_SERVERS=ming-zookeeper:2181

# Delete the topic if it exists
kafka-topics --zookeeper $ZOOKEEPER_SERVERS --topic ming-kafka-canary-topic --delete --if-exists
# Create the topic
kafka-topics --zookeeper $ZOOKEEPER_SERVERS --topic ming-kafka-canary-topic --create --partitions 1 --replication-factor 1 --if-not-exists && \
# Create a message
MESSAGE="`date -u`" && \
# Produce a test message to the topic
echo "$MESSAGE" | kafka-console-producer --broker-list ming-kafka:9092 --topic ming-kafka-canary-topic && \
# Consume a test message from the topic
kafka-console-consumer --bootstrap-server ming-kafka-headless:9092 --topic ming-kafka-canary-topic --from-beginning --timeout-ms 2000 | grep "$MESSAGE"

kafka-console-producer --broker-list $BROKER_LIST --topic ming-kafka-canary-topic
kafka-console-consumer --bootstrap-server $BOOTSTRAP_SERVERS  --topic ming-kafka-canary-topic --from-beginning

kafka-topics --zookeeper ming-zookeeper:2181 --topic sci-logs-u --create --partitions 10 --replication-factor 3 --if-not-exists
