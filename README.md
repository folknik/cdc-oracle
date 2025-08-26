# CDC demo project

This repository contains a **Change Data Capture (CDC) demo project** that showcases real-time data streaming from Oracle to Kafka.  
It is designed for educational and experimental purposes, helping you understand how to capture and stream database changes using open-source tools.

## Components

The demo project includes the following components:

- **Oracle Database 21c XE**  
  Lightweight edition of Oracle Database, serving as the source system for change capture.

- **OpenLogReplicator v1.8.6**  
  An open-source tool for parsing Oracle redo/archived logs and streaming changes to external systems.

- **Debezium Oracle Connector v3.2.1**  
  A Kafka Connect plugin that integrates with OpenLogReplicator and delivers change events into Apache Kafka topics.

## Architecture Overview

1. Oracle Database 21c XE generates redo logs with transactional changes.  
2. OpenLogReplicator reads and parses these redo logs.  
3. Debezium Oracle Connector consumes changes from OpenLogReplicator and produces CDC events into Kafka.  
4. Downstream consumers can subscribe to Kafka topics for real-time data processing.

## Prerequisites

- Docker and Docker Compose installed  
- At least 8 GB of RAM recommended  
- Basic knowledge of Oracle and Kafka


## Usage

Clone the repository:

```bash
cd /home
git clone https://github.com/folknik/cdc-oracle.git .
```