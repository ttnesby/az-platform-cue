package policyAssignment

import (
    "azure.platform/config/v1/managementGroup:managementGroup"
)

#Assignment: {
    definitionId: string
    displayName: string
    parameters?: [string]
    scopes: #ScopeList
}

#ScopeList: [#Scope,...#Scope]

#Scope: {
    scope: managementGroup.#Guid
    assignmentId: string
}

#Parameters: {
    A="in": #Assignment
    //result: [for e in A.scopes {e}]
    result: [for e in A.scopes {
        $schema:        "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
        contentVersion: "1.0.0.0"
        parameters: {
            scope: value: "/providers/Microsoft.Management/managementGroups/\(e.scope)"
            policyDefinitionID: value: A.definitionId
            policyAssignmentDisplayName: value: A.displayName
            policyAssignmentID: value: e.assignmentId
            parameters?: value?: A.parameters
        }
    }]
}