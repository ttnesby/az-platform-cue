package managementGroup

import "uuid"

_nodes: [string]: #Guid
_nodeKeys: [for k,v in _nodes {k}]

#Guid: value=string & uuid.Parse(value)

_hierarchy: #ParentChildren 
#ParentChildren: [#IsNode]: #Children

#IsNode: string & or(_nodeKeys)
#Children: [#IsNode,...#IsNode]