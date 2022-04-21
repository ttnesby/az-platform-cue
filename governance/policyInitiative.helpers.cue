package policyInitiative

import (
    "strings"
    "azure.platform/config/v1/managementGroup:managementGroup"
)

_customPolicyPlacement: managementGroup.#nodes["nav"]

#IdPath: {
	#id: string
	#custom: bool

	_path: [
		if #custom {"/providers/Microsoft.Management/managementGroups/\(_customPolicyPlacement)/providers/Microsoft.Authorization/policyDefinitions/"},"/providers/Microsoft.Authorization/policyDefinitions/"][0]
	r: _path + #id
}

#DisplayNameToRefId: {
	#n: string
	_t: strings.ToCamel(
			strings.Replace(strings.ToTitle(#n)," ","",-1))
	r: strings.Trim(strings.Split(_t,"-")[0]," ")
}