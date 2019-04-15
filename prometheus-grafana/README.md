# RabbitMQ monitoring with Prometheus and Grafana


## Get started

Run the following commands to get a single node cluster with Prometheus and Grafana ready to use with a sample dashboard:
```
cd prometheus-grafana
docker-compose up
```
> The docker-compose uses a RabbitMQ build from 3.8 line that uses the latest [Prometheus plugin exporter](https://github.com/rabbitmq/rabbitmq-prometheus)

Go to [Grafana running at http://localhost:3000](http://localhost:3000/d/jr701-RWk/sample-dashboard?orgId=1)

![overview](assets/rabbitmq-overview-dashboard.png)
