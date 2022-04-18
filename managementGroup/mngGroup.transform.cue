package managementGroup

import "list"

_root: {
    id: #nodes["\(#nodeKeys[0])"] 
    name: #nodeKeys[0]
}

_children:  [for aParent,childList in _hierarchy, for child in childList {
                id: #nodes["\(child)"]
                name: child
                parent: #nodes["\(aParent)"]
            }]

$schema: "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
contentVersion: "1.0.0.0",
parameters: managementGroupsList: value: list.FlattenN([_root, _children],-1)