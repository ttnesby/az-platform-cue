package allowedRegionsForRGAndResources

import "azure.platform/config/v1/managementGroup:managementGroup"

_scopeAndID: [
	{scope: "landing-zones", id: "nav-policy-e5cbfcb4-4a0"},
	{scope: "platform", id: "nav-policy-4af3f96a-6dd"}
]

[for sid in _scopeAndID {
	$schema:        "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
	contentVersion: "1.0.0.0"
	parameters: {
		scope: value: "/providers/Microsoft.Management/managementGroups/\(managementGroup.#nodes[sid.scope])"
		policyDefinitionID: {
			value: "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
			metadata: version: "1.0.0"
		}
		policyAssignmentDisplayName: value: "Allowed Regions for RG and Resources"
		policyAssignmentID: value: sid.id
		parameters: value: listOfAllowedLocations: value: ["norwayeast", "norwaywest"]
	}
}]
