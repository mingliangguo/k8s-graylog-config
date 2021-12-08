#!/usr/bin/env bash

# run this inside the ming-kafka container
# k exec ming-kafka-0 -it -- bash

kafka-topics --create --topic test-topic --partitions 5 --replication-factor=1 --zookeeper ming-zookeeper:2181


