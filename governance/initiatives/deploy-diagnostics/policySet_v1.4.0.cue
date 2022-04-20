package deployDiagnostics

import (
	"azure.platform/config/v1/managementGroup:managementGroup"
	"azure.platform/config/v1/governance/policies/deploy-diagnostics-application-gateway:diagnosticsApplicationGateway"
	"azure.platform/config/v1/governance/policies/deploy-diagnostics-azurefirewall:diagnosticsAzureFirewall"
)

policySetId: "fb615e09-4fb2-4014-8c03-b4fdab7315ff-v1.4.0"
displayName: "Deploy Diagnostics - v1.4.0"
description: "Enable Diagnostic settings on resources and send to Log Analytics"
policyType:  "Custom"
metadata: {
	version:  "1.4.0"
	category: "Security Center"
}
parameters: logAnalytics: {
	type: "String"
	metadata: {
		displayName: "Log Analytics workspace"
		description: "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID."
		strongType:  "omsWorkspace"
	}
}

_customPolicy: "/providers/Microsoft.Management/managementGroups/\(managementGroup.#nodes["nav"])/providers/Microsoft.Authorization/policyDefinitions/"

_builtInPolicy: "/providers/Microsoft.Authorization/policyDefinitions/"

policyDefinitions: [{
	policyDefinitionId:          _customPolicy + diagnosticsApplicationGateway.policyId
	policyDefinitionReferenceId: "diagAppGateway"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          _customPolicy + diagnosticsAzureFirewall.policyId
	policyDefinitionReferenceId: "diagAzureFirewall"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/58294e20-6cf6-422b-9143-151ed91dbb1f-v1.0.0"
	policyDefinitionReferenceId: "diagCosmosDB"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47"
	policyDefinitionReferenceId: "diagKeyVault"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/9533c2fa-76eb-4042-8f6f-39a3438a6ce4-v1.0.0"
	policyDefinitionReferenceId: "diagNIC"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/6364fb9b-4f36-4681-987b-166039aa8acf-v2.0.0"
	policyDefinitionReferenceId: "diagNSG"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/da6aec1f-c530-497b-a747-a0893b4373c3-v1.0.0"
	policyDefinitionReferenceId: "diagPIP"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/809a0b26-a12a-456a-a469-03d82adab8d2-v1.0.0"
	policyDefinitionReferenceId: "diagPostgreSQL"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          _builtInPolicy + "6f8f98a4-f108-47cb-8e98-91a0d85cd474"
	policyDefinitionReferenceId: "diagStorageAccount"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/89125484-db4a-4857-a997-738df56e5718-v1.0.0"
	policyDefinitionReferenceId: "diagManagedSQL"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/1c6143b5-a5df-4dad-ae0c-011a5d4724cd-v1.0.0"
	policyDefinitionReferenceId: "diagManSQLInst"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}, {
	policyDefinitionId:          "/providers/Microsoft.Management/managementGroups/#NAVMGID#/providers/Microsoft.Authorization/policyDefinitions/b76c87c5-45ce-419c-b146-0f0299165b5a-v1.0.1"
	policyDefinitionReferenceId: "diagExpressrouteGateways"
	parameters: logAnalytics: value: "[parameters('logAnalytics')]"
}]
