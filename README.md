# accountability-sysdig-kafka

This repository includes the required code for an accountability solution based on Sysdig, Librdkafka producer, Apache Kafka and MongoDB.
Three subfolders are included to contain the adapted Sysdig Lua scripts (chisels) regarding the evaluated frameworks: ROS, ROS2 and contenedorized ROS.
Minimal configuration is needed in Lua scripts when being used as an accountability system for frameworks of applications different from the ones chosen.

# Components
Sysdig (version 0.27.1)

Librdkafka (version 1.6)

Apache Kafka (version 2.7.0)

MongoDB (version 4.4.5)

# Usage
```
./producer $KAFKA_BROKER:$KAFKA_BROKER_PORT $KAFKA_TOPIC
```
# Example
Having an Apache Kafka broker node with name kafka01, with TLS1.3 enable in port 9093 and a topic with name sysdigOutput
```
./producer kafka01:9093 sysdigOutput
```
