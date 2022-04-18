package aPolicy

import "azure.platform/config/v1/managementGroup:managementGroup"

$schema:        "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
contentVersion: "1.0.0.0"
parameters: {
	scope: managementGroup.#getScope & {_name: "landing-zones"}
	policyDefinitionID: {
		value: "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
		metadata: version: "1.0.0"
	}
	policyAssignmentDisplayName: value: "Allowed Regions for RG and Resources"
	policyAssignmentID: value: "nav-policy-e5cbfcb4-4a0"
	parameters: value: listOfAllowedLocations: value: ["norwayeast", "norwaywest"]
}
