package allowedRegionsForRGAndResources

import "azure.platform/config/v1/managementGroup:managementGroup"

_scopeAndID: [
	{scope: "hybrid", id: "43ac-b255-2d65ef49b805"}
]

[for sid in _scopeAndID {
	$schema:        "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
	contentVersion: "1.0.0.0"
	parameters: {
		scope: value: "/providers/Microsoft.Management/managementGroups/\(managementGroup.#nodes[sid.scope])"
		policyDefinitionID: {
			value: "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"
			metadata: version: "1.0.0"
		}
		policyAssignmentDisplayName: value: "Audit SA without infrastructure encryption"
		policyAssignmentID: value: sid.id
	}
}]