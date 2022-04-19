package allowedRegionsForRGAndResources

import (
	"azure.platform/config/v1/managementGroup:managementGroup"
	"azure.platform/config/v1/governance:policyAssignment"
)

_a: policyAssignment.#Assignment & {
	definitionId: "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
	displayName: "Allowed Regions for RG and Resources"
	params: listOfAllowedLocations: value: ["norwayeast", "norwaywest"]
	scopes: _scopes
}

_scopes: policyAssignment.#ScopeList & [
	{scope: managementGroup.#nodes["landing-zones"], assignmentId: "nav-policy-e5cbfcb4-4a0"},
	{scope: managementGroup.#nodes["platform"], assignmentId: "nav-policy-4af3f96a-6dd"}
]

policyAssignment.#Parameters & { #in: _a } 