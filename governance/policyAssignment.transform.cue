package policyAssignment

import (
    "azure.platform/config/v1/deployment:deployment"
)

#Parameters: {
    #in: #Assignment

    let tmp = [for e in #in.scopes {                
            policyDefinitionID: value: #in.definitionId
            policyAssignmentDisplayName: value: #in.displayName
            if #in.params != _|_ {parameters: value: #in.params}
            scope: value: "/providers/Microsoft.Management/managementGroups/\(e.scope)"
            policyAssignmentID: value: e.assignmentId        
    }]

    result:[for e in tmp {deployment.#Parameters & { #in: e } }]
}