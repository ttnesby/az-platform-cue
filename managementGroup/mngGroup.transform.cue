package managementGroup

import (
    "list"
    "azure.platform/config/v1/deployment:deployment"
)

_root: {
    id: #nodes["\(#nodeKeys[0])"] 
    name: #nodeKeys[0]
}

_children:  [for aParent,childList in _hierarchy, for child in childList {
                id: #nodes["\(child)"]
                name: child
                parent: #nodes["\(aParent)"]
            }]

result: deployment.#Parameters & {#in: managementGroupsList: value: list.FlattenN([_root, _children],-1)}