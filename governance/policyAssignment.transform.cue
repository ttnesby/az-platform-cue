package policyAssignment

import (
    "azure.platform/config/v1/deployment:deployment"
)

#Parameters: {
    #in: #Assignment

    let tmp = [for e in #in.scopes {                
            policyDefinitionID: value: #in.definitionId
            policyAssignmentDisplayName: value: #in.displayName
            if #in.managedIdentity != _|_ {requiresManagedIdentity: value: #in.managedIdentity}
            if #in.uaiResourceId != _|_ {uaiResourceID: value: #in.uaiResourceId}
            if #in.params != _|_ {parameters: value: #in.params}
            if #in.roleDefinitionId != _|_ {roleDefinitionIds: value: #in.roleDefinitionId} 
            scope: value: "/providers/Microsoft.Management/managementGroups/\(e.scope)"
            policyAssignmentID: value: e.assignmentId        
    }]

    r:[for e in tmp {deployment.#Parameters & { #in: e } }]
}