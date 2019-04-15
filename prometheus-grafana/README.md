# RabbitMQ monitoring with Prometheus and Grafana


## Get started

Run the following commands to get a single node cluster with Prometheus and Grafana ready to use:
```
cd prometheus-grafana
docker-compose up
```
> The docker-compose uses a RabbitMQ build from 3.8 line that uses the latest [Prometheus plugin exporter](https://github.com/rabbitmq/rabbitmq-prometheus)

Go to [Grafana running at http://localhost:3000](http://localhost:3000) and create a dashboard by importing the provided [sample](grafana/sample.json) dashboard which monitors the memory utilization.

![overview](assets/rabbitmq-overview-dashboard.png)
