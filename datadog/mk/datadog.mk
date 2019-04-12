
DATADOG_API_URL := https://api.datadoghq.com/api/v1
DATADOG_APP_URL := https://app.datadoghq.com

check-datadog-env:
	ifndef DATADOG_API_KEY
		$(error DATADOG_API_KEY is undefined)
	endif
	ifndef DATADOG_APP_KEY
		$(error DATADOG_APP_KEY is undefined)
	endif
