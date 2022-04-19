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