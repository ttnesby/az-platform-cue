package managementGroup

import "uuid"

#nodes: [string]: #Guid
#nodeKeys: [for k,v in #nodes {k}]

#Guid: value=string & uuid.Parse(value)

_hierarchy: #ParentChildren 
#ParentChildren: [#IsNode]: #Children

#IsNode: string & or(#nodeKeys)
#Children: [#IsNode,...#IsNode]