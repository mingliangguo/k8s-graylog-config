#!/usr/bin/env bash

ZOOKEEPER_SERVER=ming-zookeeper:2181
KAFKA_PREFIX=sci
LARGE_PARTION_NUMS=30
SMALL_PARTION_NUMS=12
REPLICA_FACTOR=3

## declare an array variable
declare -a large_topics=("${KAFKA_PREFIX}-actionable-event-topic" "${KAFKA_PREFIX}-chat-to-notification-topic" "${KAFKA_PREFIX}-notification-to-chat-topic" "${KAFKA_PREFIX}-outbound-internal-topic" "${KAFKA_PREFIX}-per-identity-app-notification")

declare -a small_topics=("${KAFKA_PREFIX}-reaction-event-topic" "${KAFKA_PREFIX}-reaction-internal-topic" "${KAFKA_PREFIX}-reaction-notification-topic" "${KAFKA_PREFIX}-settings-to-notification-topic" "${KAFKA_PREFIX}-system-provisioning-topic" "${KAFKA_PREFIX}-user-anonymized-event-topic" "${KAFKA_PREFIX}-search-etl" "${KAFKA_PREFIX}-search-etl-inc" "${KAFKA_PREFIX}-search-etl-ingest")

################################################################################
# Usage: create kafka topics by specifying number of partitions and replica_factor
################################################################################

function create_topic() {
  TOPIC_NAME=$1
  PARTION_NUM=$2
  REPLICA_FACTOR=$3
  kafka-topics --zookeeper $ZOOKEEPER_SERVER --topic $TOPIC_NAME --create --partitions $partion_num --replication-factor $replica_factor --if-not-exists
}

for large_topic_name in "${large_topics[@]}"; do
  create_topic $large_topic_name $LARGE_PARTION_NUMS $REPLICA_FACTOR
  echo $large_topic_name
done
for small_topic_name in "${small_topics[@]}"; do
  create_topic $small_topic_name $SMALL_PARTION_NUMS $REPLICA_FACTOR
  echo $small_topic_name
done

set +x
