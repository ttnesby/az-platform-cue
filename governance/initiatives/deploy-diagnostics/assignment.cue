package deployDiagnosticsAssignment

import (
	"azure.platform/config/v1/managementGroup:managementGroup"
	"azure.platform/config/v1/governance:policyAssignment"
  "azure.platform/config/v1/governance:policyInitiative"
  "azure.platform/config/v1/governance/initiatives/deploy-diagnostics:deployDiagnosticsPolicy"
)

_a: policyAssignment.#Assignment & {
	definitionId: (policyInitiative.#IdPath & {#id: deployDiagnosticsPolicy.policySetId, #custom: true}).r
	displayName: deployDiagnosticsPolicy.displayName
  managedIdentity: true
  uaiResourceId: "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourceGroups/CentralLA/providers/Microsoft.ManagedIdentity/userAssignedIdentities/az-platform-centralLA-UAIdentity"
	params: logAnalytics: value: "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourcegroups/centralla/providers/microsoft.operationalinsights/workspaces/az-platform-central-logs"
  roleDefinitionId: [
        "/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa",
        "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
      ]
	scopes: _scopes
}

_scopes: policyAssignment.#ScopeList & [
	{scope: managementGroup.#nodes["landing-zones"], assignmentId: "nav-policy-77dfa217-29a"},
	{scope: managementGroup.#nodes["platform"], assignmentId: "nav-policy-f65a168d-447"}
]

policyAssignment.#Parameters & { #in: _a }