.ONESHELL:# single shell invocation for all lines in the recipe
.PHONY: check-datadog-env

SHELL = bash# we depend on bash expansion for e.g. queue patterns

.DEFAULT_GOAL = help

include $(CURDIR)/mk/datadog.mk
include $(CURDIR)/mk/dashboards.mk
include $(CURDIR)/mk/monitors.mk

### TARGETS ###

#help:
#	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN { FS = "[:#]" } ; { printf "\033[36m%-30s\033[0m %s\n", $$2, $$5 }' | sort

get-dashboard-url: ## get dashboard url that selects a rabbitmq service instance  => make get-dashboard-url service-instance=rmq id=common-dashboard-id
	@SERVICE_GUID=$$(cf service $(service-instance) --guid); \
		echo "$(DATADOG_APP_URL)/dashboard/$(id)?tpl_var_service-instance=service-instance_$$SERVICE_GUID"

create-dashboard: ## create dashboard to monitor a rmq service instance => make create-dashboard service-instance=rmq template=standard
	@DASHBOARD=$$(mktemp); TEMPLATED_DASHBOARD=$$(mktemp); \
		bin/template-dashboard $(service-instance) $(template) > $$TEMPLATED_DASHBOARD; \
		curl -s -X POST \
				-H "Content-type: application/json" \
				"$(DATADOG_API_URL)/dashboard?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" -d@$$TEMPLATED_DASHBOARD > $$DASHBOARD; \
		DASHBOARD_ID=$$(jq -r .id $$DASHBOARD); \
		DASHBOARD_TITLE=$$(jq -r .title $$DASHBOARD); \
		DASHBOARD_URL=$$(jq -r .url $$DASHBOARD); \
		mv $$DASHBOARD dashboards/$$DASHBOARD_ID; \
		echo "Created dashboard "; \
		echo "  - id: $$DASHBOARD_ID"; \
		echo "  - title: $$DASHBOARD_TITLE"; \
		echo "  - file: dashboards/$$DASHBOARD_ID"; \
		echo "  - url: $(DATADOG_APP_URL)/$$DASHBOARD_URL"

save-dashboard-as-template: ## e.g. make save-dashboard-as-template id=dashboard-id template=standard
	@curl -s "$(DATADOG_API_URL)/dashboard/$(id)?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" > templates/$(template).json


create-monitors: ## create monitor for a rmq service instance => make create-monitors service-instance=rmq notif-recipient=myemail@address.com dashboard=the-id
	@MONITOR=$$(mktemp); TEMPLATED_MONITOR=$$(mktemp); \
		SERVICE_GUID=$$(cf service $(service-instance) --guid); \
		DASHBOARD_URL=$(DATADOG_APP_URL)/dashboard/$(id)?tpl_var_service-instance=service-instance_$$SERVICE_GUID; \
		bin/template-threshold-monitor $(service-instance) messaging-service-availability \
												1 \
												2 \
												$(notif-recipient) \
												$$DASHBOARD_URL > $$TEMPLATED_MONITOR; \
		curl -s -X POST \
				-H "Content-type: application/json" \
				"$(DATADOG_API_URL)/monitor?api_key=$(DATADOG_API_KEY)&application_key=$(DATADOG_APP_KEY)" -d@$$TEMPLATED_MONITOR > $$MONITOR; \
		MONITOR_ID=$$(jq -r .id $$MONITOR); \
		mv $$MONITOR monitors/$$MONITOR_ID; \
		echo "Created monitor "; \
		echo "  - id: $$MONITOR_ID"; \
		echo "  - file: dashboards/$$MONITOR_ID"; \
