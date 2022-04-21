package deployDiagnosticsPolicy

import (
	"list"
	"azure.platform/config/v1/governance:policyInitiative"
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

_customPolicies: [diagnosticsApplicationGateway,diagnosticsAzureFirewall] 
_builtInPolicies: [{id: "6f8f98a4-f108-47cb-8e98-91a0d85cd474", refId: "diagStorageAccount"}]

policyDefinitions: list.FlattenN([
	[for p in _customPolicies {
		policyDefinitionId:          (policyInitiative.#IdPath & {#id: p.policyId, #custom: true}).r
		policyDefinitionReferenceId: (policyInitiative.#DisplayNameToRefId & {#n: p.displayName}).r
		parameters: logAnalytics: value: "[parameters('logAnalytics')]"
	}],
	[for p in _builtInPolicies {
		policyDefinitionId:          (policyInitiative.#IdPath & {#id: p.id, #custom: false}).r
		policyDefinitionReferenceId: p.refId
		parameters: logAnalytics: value: "[parameters('logAnalytics')]"		
	}]
],-1)