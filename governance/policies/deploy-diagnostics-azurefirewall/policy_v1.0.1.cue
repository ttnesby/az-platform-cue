package diagnosticsAzureFirewall

$schema:     "../../../library/schema/policyDefinition.schema.json"
policyId:    "b34a519f-4623-49c5-91da-481bfb1a1844-v1.0.1"
displayName: "Deploy Diagnostic Settings for Azure Firewall - v1.0.1"
policyType:  "Custom"
mode:        "All"
description: "Deploys diagnostic settings (metrics + logs) for Azure Firewall to log analytics"
metadata: {
	version:  "1.0.1"
	category: "Monitoring"
}
parameters: {
	logAnalytics: {
		type: "String"
		metadata: {
			displayName: "Log Analytics workspace"
			description: "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
			strongType:  "omsWorkspace"
		}
	}
	effect: {
		type: "String"
		metadata: {
			displayName: "Effect"
			description: "Enable or disable the execution of the policy"
		}
		allowedValues: ["DeployIfNotExists", "Disabled"]
		defaultValue: "DeployIfNotExists"
	}
	profileName: {
		type: "String"
		metadata: {
			displayName: "Profile name"
			description: "The diagnostic settings profile name"
		}
		defaultValue: "setbypolicy"
	}
	metricsEnabled: {
		type: "String"
		metadata: {
			displayName: "Enable metrics"
			description: "Whether to enable metrics stream to the Log Analytics workspace - True or False"
		}
		allowedValues: [
			"True",
			"False",
		]
		defaultValue: "True"
	}
	logsEnabled: {
		type: "String"
		metadata: {
			displayName: "Enable logs"
			description: "Whether to enable logs stream to the Log Analytics workspace - True or False"
		}
		allowedValues: [
			"True",
			"False",
		]
		defaultValue: "True"
	}
}
policyRule: {
	if: {
		field:  "type"
		equals: "Microsoft.Network/azureFirewalls"
	}
	then: {
		effect: "[parameters('effect')]"
		details: {
			type: "Microsoft.Insights/diagnosticSettings"
			name: "[parameters('profileName')]"
			existenceCondition: allOf: [{
				field:  "Microsoft.Insights/diagnosticSettings/logs.enabled"
				equals: "true"
			}, {
				field:  "Microsoft.Insights/diagnosticSettings/metrics.enabled"
				equals: "true"
			}, {
				field:  "Microsoft.Insights/diagnosticSettings/workspaceId"
				equals: "[parameters('logAnalytics')]"
			}]
			roleDefinitionIds: ["/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa", "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"]
			deployment: properties: {
				mode: "Incremental"
				template: {
					$schema:        "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
					contentVersion: "1.0.0.0"
					parameters: {
						resourceName: type: "String"
						logAnalytics: type: "String"
						location: type: "String"
						profileName: type: "String"
						metricsEnabled: type: "String"
						logsEnabled: type: "String"
					}
					variables: {}
					resources: [{
						type:       "Microsoft.Network/azureFirewalls/providers/diagnosticSettings"
						apiVersion: "2017-05-01-preview"
						name:       "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/', parameters('profileName'))]"
						location:   "[parameters('location')]"
						dependsOn: []
						properties: {
							workspaceId: "[parameters('logAnalytics')]"
							metrics: [{
								category: "AllMetrics"
								enabled:  "[parameters('metricsEnabled')]"
								retentionPolicy: {
									days:    0
									enabled: false
								}
							}]
							logs: [{
								category: "AzureFirewallApplicationRule"
								enabled:  "[parameters('logsEnabled')]"
							}, {
								category: "AzureFirewallNetworkRule"
								enabled:  "[parameters('logsEnabled')]"
							}, {
								category: "AzureFirewallDnsProxy"
								enabled:  "[parameters('logsEnabled')]"
							}]
						}
					}]
					outputs: {}
				}
				parameters: {
					logAnalytics: value: "[parameters('logAnalytics')]"
					location: value: "[field('location')]"
					resourceName: value: "[field('name')]"
					profileName: value: "[parameters('profileName')]"
					metricsEnabled: value: "[parameters('metricsEnabled')]"
					logsEnabled: value: "[parameters('logsEnabled')]"
				}
			}
		}
	}
}
