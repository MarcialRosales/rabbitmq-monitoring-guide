
get-dashboard: ## get dashboard definition, make get-dashboard id=my-dashboard-id
	@curl "$(DATADOG_API_URL)/dashboard/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" > dashboards/$(id)

get-all-dashboards: ## get all dashboards
	@curl "$(DATADOG_API_URL)/dashboard?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)"

update-dashboard: ## update dashboard definition, make update-dashboard id=my-dashboard-id
	@curl -X PUT -H "Content-type: application/json" "$(DATADOG_API_URL)/dashboard/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" -d@dashboards/$(id)

get-all-dashboard-lists: ## get all dashboard lists
	@curl "$(DATADOG_API_URL)/dashboard/lists/manual?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)"

delete-dashboard: ## delete dashboard, make delete-dashboard id=my-dashboard-id"
	@curl -X DELETE "$(DATADOG_API_URL)/dashboard/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" && rm -f dashboards/$(id)
