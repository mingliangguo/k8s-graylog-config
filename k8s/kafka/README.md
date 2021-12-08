This deployment manifest is generated from the official helm charts from confluent - https://github.com/confluentinc/cp-helm-charts


kafka-brokerlist: ming-kafka-0.ming-kafka-headless:9092,ming-kafka-1.ming-kafka-headless:9092,ming-kafka-2.ming-kafka-headless:9092

zookeeper: ming-zookeeper:2181

For services: need to change security_protocol to `PLAINTEXT`

For connecting to graylog, add the following environment variable:
```
- name: LOGGING_KAFKA_SECURITY_PROTOCOL
  value: PLAINTEXT
````

**NOTE:**

- canary-pod in the `cp-kafka/templates/tests`` folder will spin up a kafka-client container that can be used to do some testing. And inside the same folder, there are some scripts with some commonly used kafka cli scripts.


