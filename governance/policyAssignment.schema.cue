package policyAssignment

import (
    "azure.platform/config/v1/managementGroup:managementGroup"
)

#Assignment: {
    definitionId: string
    displayName: string
    managedIdentity?: bool
    uaiResourceId?: string
    params?: _
    roleDefinitionId?: [string,...string]
    scopes: #ScopeList
}

#ScopeList: [#Scope,...#Scope]

#Scope: {
    scope: managementGroup.#Guid
    assignmentId: string
}