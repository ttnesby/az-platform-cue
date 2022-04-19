package allowedRegionsForRGAndResources

import (
	"azure.platform/config/v1/managementGroup:managementGroup"
	"azure.platform/config/v1/governance:policyAssignment"
)

_a: policyAssignment.#Assignment & {
	definitionId: "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"
	displayName: "Audit SA without infrastructure encryption"
	scopes: _scopes
}

_scopes: policyAssignment.#ScopeList & [
		{scope: managementGroup.#nodes["hybrid"], assignmentId: "43ac-b255-2d65ef49b805"}
	]

policyAssignment.#Parameters & { #in: _a } 
