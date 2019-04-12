
get-monitor: ## get monitor definition, make get-monitor id=my-monitor-id
	@curl -s "$(DATADOG_API_URL)/monitor/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" > monitors/$(id)

get-all-monitor: ## get all monitors
	@curl "$(DATADOG_API_URL)/dashboard?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)"

update-monitor: ## update monitor definition, make update-monitor id=my-monitor-id
	@curl -X PUT -H "Content-type: application/json" "$(DATADOG_API_URL)/monitor/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" -d@monitors/$(id)

delete-monitor: ## delete monitor, make delete-monitor id=my-monitor-id"
	@curl -X DELETE "$(DATADOG_API_URL)/monitor/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" && rm -f monitors/$(id)
