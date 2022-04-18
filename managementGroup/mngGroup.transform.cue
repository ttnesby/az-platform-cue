package managementGroup

import "list"

_root: {
    id: _nodes["\(_nodeKeys[0])"] 
    name: _nodeKeys[0]
}

_children:  [for aParent,childList in _hierarchy, for child in childList {
                id: _nodes["\(child)"]
                name: child
                parent: _nodes["\(aParent)"]
            }]

$schema: "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
contentVersion: "1.0.0.0",
parameters: managementGroupsList: value: list.FlattenN([_root, _children],-1)