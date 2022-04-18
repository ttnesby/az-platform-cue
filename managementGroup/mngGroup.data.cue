package managementGroup

_nodes: {
	nav:             "77b612df-5cc8-4114-b11f-0ab74eadbdf6"
	sandboxes:       "b63fce10-f7dc-4812-8d2d-21aceb1c1c2e"
	decommissioned:  "ef344fb7-242b-4940-9e97-dccabba22659"
	"landing-zones": "95af6ea4-4c92-4116-b8a4-a8db279fdd9b"
	online:          "0520559f-342f-473f-9983-16a27f8c3ca6"
	"online-dev":    "4d80920b-2298-4e81-a33b-840ee51ebd6d"
	"online-test":   "b465acc8-e1f6-43c2-88cc-5714cc7b1c81"
	"online-prod":   "fe725b54-b2d4-4617-8c80-d2465769fd1c"
	hybrid:          "9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e"
	"hybrid-dev":    "09cdf845-8f55-4173-90ca-130c97186e26"
	"hybrid-test":   "9eee88f3-53fc-4b3d-9090-11b6b9a886cd"
	"hybrid-prod":   "92370364-04df-4135-85bd-c7e3b1170189"
	platform:        "4a88fc9b-a575-4e96-a474-9d149df75e32"
	identity:        "6ee7e0da-8304-4f0b-9212-7c53599bd013"
	management:      "c0811c2b-a9c4-405f-9844-ed0a5d7c0e89"
	connectivity:    "6ece9f79-fbea-4576-a968-8d724a9a7477"
}

_hierarchy: {
	nav: ["sandboxes", "decommissioned", "landing-zones", "platform"]
	"landing-zones": ["online", "hybrid"]
	online: ["online-dev", "online-test", "online-prod"]
	hybrid: ["hybrid-dev", "hybrid-test", "hybrid-prod"]
	platform: ["identity", "management", "connectivity"]
}

test: "torstein"