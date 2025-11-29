# Rideau Canal Real-time Monitoring System

This project implements a real-time monitoring platform to observe the skating
conditions on the Rideau Canal.

Features include:

- Simulated multi-device telemetry ingestion through Azure IoT Hub
- Live stream processing with Azure Stream Analytics
- Low-latency data access via Cosmos DB
- Archival storage in Blob Storage
- Web-based data visualization dashboard

This project demonstrates key cloud engineering concepts including event-driven
architectures, tumbling window analytics, distributed data storage, and
real-time UI updates. It shows a production-ready implementation of an IoT
analytics stack from device to dashboard.

## Student Information

- **Name:** Sebastien Dunne
- **Student ID:** 040938887

## Project Repositories

- [Main Documentation](https://github.com/DunneDev/rideau_canal_monitoring)
- [Sensor Simulation](https://github.com/DunneDev/rideau_canal_sensor_simulation)
- [Dashboard Backend](https://github.com/DunneDev/rideau_canal_dashboard_backend)
- [Dashboard Frontend](https://github.com/DunneDev/rideau_canal_dashboard_fontend)

## Scenario Overview

The National Capital Commission requires a monitoring system to track:

- Ice Thickness (cm)
- Surface Temperature (°C)
- Snow Accumulation (cm)
- External Temperature (°C)

The goal is to:

- Stream device data to Azure IoT Hub
- Process data in 5-minute tumbling windows
- Store processed aggregates
- Display live status & safety classifications
- Provide real-time insights for canal operation teams

## System Architecture

![architecture](./architecture/architecture-diagram.svg)

### Data Flow

#### 1. IoT Sensors

Rust implementation of MQTT IoT devices that send telemetry data every 10
seconds from:

- Dow’s Lake
- Fifth Avenue
- NAC

#### 2. Azure IoT Hub

- Central ingestion point for device telemetry.

#### 3. Azure Stream Analytics

- 5-minute tumbling windows
- Aggregation of all measurements
- Safety rule evaluation
- Output to Cosmos DB and Blob Storage

#### 4. Azure Cosmos DB

- Stores aggregated, query-optimized JSON documents
- Partitioned by `/location`

#### 5. Azure Blob Storage

- Long-term archival
- JSON files organized by date/time

#### 6. Web Backend API

- Written in c-sharp using .NET
- Exposes endpoint for accessing aggregated sensor data

#### 7. Web Frontend Dashboard

- Created in React with Material UI
- Auto-refresh + status indicators
