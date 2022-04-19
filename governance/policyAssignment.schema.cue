package policyAssignment

import (
    "azure.platform/config/v1/managementGroup:managementGroup"
)

#Assignment: {
    definitionId: string
    displayName: string
    params?: _
    scopes: #ScopeList
}

#ScopeList: [#Scope,...#Scope]

#Scope: {
    scope: managementGroup.#Guid
    assignmentId: string
}

#Parameters: {
    in: #Assignment
    result: [for e in in.scopes {
        $schema:        "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
        contentVersion: "1.0.0.0"
        parameters: {
            policyDefinitionID: value: in.definitionId
            policyAssignmentDisplayName: value: in.displayName
            if in.params != _|_ {parameters: value: in.params}
            scope: value: "/providers/Microsoft.Management/managementGroups/\(e.scope)"
            policyAssignmentID: value: e.assignmentId
        }
    }]
}