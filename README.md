# az-platform-cue

This repo is a conceptual test of the `cue` [configuration language](https://cuelang.org/)

Azure platform as code implies a vast set of configuration of different entities, e.g. <br>
- Management groups hierarchy <br>
- Which management group to place custom policy definitions <br>
- Assignment of policies to different levels in the management group hierarchy <br>
-  Define policy initiatives of custom and/or built-in policies <br>
- Assignment of policy initiatives to different levels in the management group hierarchy <br>
- ... and so on

Before `cue`, it was copy-paste of nitty gritty configuration details or do boiler plate coding.

With `cue`, it is easy to reuse configuration across related/dependent entities due to [modules/package support](https://cuelang.org/docs/concepts/packages/).

## Deployment Parameters

Folder `./deployment` contains a single cue-file `deployment.transform.cue` belonging to `deployment` package.

```cue
#Parameters: {
    #in: _
    
    $schema: "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#"
    contentVersion: "1.0.0.0",
    parameters: #in    
}
```

It's a simple [Function pattern](https://cuetorials.com/patterns/functions/) giving the start of the deployment paramters with anything (or `top` in cue) as content. 
## Management Group

Folder `./managementGroup` contains three cue-files belonging to `managementGroup` package
- `mngGroup.data.cue` - dictionary of management groups and related hierarchy <br>
- `mngGroup.schema.cue` - schema for validating management group dictionary <br>
- `mngGroup.transform.cue` - tranforms management group dictionary to a classic Azure bicep parameter file <br>

### Validate 

Validation is done with `cue vet -h`.

```zsh
az-platform-cue git:(main) ✗ cd ./managementGroup
➜  managementGroup git:(main) ✗ cue vet
➜  managementGroup git:(main) ✗
```

`no news are good news` - data satisfies the schema (constraints).

The following change 
```cue
_hierarchy: {
	ttn: ["sandboxes", "decommissioned", "landing-zones", "platform"]
	"landing-zones": ["online", "hybrid"]
	online: ["online-dev", "online-test", "online-prod"]
	hybrid: ["hybrid-dev", "hybrid-test", "hybrid-prod"]
	platform: ["identity", "management", "connectivity"]
}
```
gives the following validation results

```zsh
➜  managementGroup git:(main) ✗ cue vet
_hierarchy: field not allowed: ttn:
    ./mngGroup.data.cue:23:2
    ./mngGroup.schema.cue:10:13
    ./mngGroup.schema.cue:11:18
```
> Change it back to `nav` and get positive validation.

### Transform

Export/transform of data is done with `cue export -h`.

```zsh
➜  managementGroup git:(main) ✗ cue export -e r
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "managementGroupsList": {
            "value": [
                {
                    "id": "77b612df-5cc8-4114-b11f-0ab74eadbdf6",
                    "name": "nav"
                },
                {
                    "id": "b63fce10-f7dc-4812-8d2d-21aceb1c1c2e",
                    "name": "sandboxes",
                    "parent": "77b612df-5cc8-4114-b11f-0ab74eadbdf6"
                },
                {
                    "id": "ef344fb7-242b-4940-9e97-dccabba22659",
                    "name": "decommissioned",
                    "parent": "77b612df-5cc8-4114-b11f-0ab74eadbdf6"
                },
                {
                    "id": "95af6ea4-4c92-4116-b8a4-a8db279fdd9b",
                    "name": "landing-zones",
                    "parent": "77b612df-5cc8-4114-b11f-0ab74eadbdf6"
                },
                {
                    "id": "4a88fc9b-a575-4e96-a474-9d149df75e32",
                    "name": "platform",
                    "parent": "77b612df-5cc8-4114-b11f-0ab74eadbdf6"
                },
                {
                    "id": "0520559f-342f-473f-9983-16a27f8c3ca6",
                    "name": "online",
                    "parent": "95af6ea4-4c92-4116-b8a4-a8db279fdd9b"
                },
                {
                    "id": "9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e",
                    "name": "hybrid",
                    "parent": "95af6ea4-4c92-4116-b8a4-a8db279fdd9b"
                },
                {
                    "id": "4d80920b-2298-4e81-a33b-840ee51ebd6d",
                    "name": "online-dev",
                    "parent": "0520559f-342f-473f-9983-16a27f8c3ca6"
                },
                {
                    "id": "b465acc8-e1f6-43c2-88cc-5714cc7b1c81",
                    "name": "online-test",
                    "parent": "0520559f-342f-473f-9983-16a27f8c3ca6"
                },
                {
                    "id": "fe725b54-b2d4-4617-8c80-d2465769fd1c",
                    "name": "online-prod",
                    "parent": "0520559f-342f-473f-9983-16a27f8c3ca6"
                },
                {
                    "id": "09cdf845-8f55-4173-90ca-130c97186e26",
                    "name": "hybrid-dev",
                    "parent": "9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e"
                },
                {
                    "id": "9eee88f3-53fc-4b3d-9090-11b6b9a886cd",
                    "name": "hybrid-test",
                    "parent": "9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e"
                },
                {
                    "id": "92370364-04df-4135-85bd-c7e3b1170189",
                    "name": "hybrid-prod",
                    "parent": "9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e"
                },
                {
                    "id": "6ee7e0da-8304-4f0b-9212-7c53599bd013",
                    "name": "identity",
                    "parent": "4a88fc9b-a575-4e96-a474-9d149df75e32"
                },
                {
                    "id": "c0811c2b-a9c4-405f-9844-ed0a5d7c0e89",
                    "name": "management",
                    "parent": "4a88fc9b-a575-4e96-a474-9d149df75e32"
                },
                {
                    "id": "6ece9f79-fbea-4576-a968-8d724a9a7477",
                    "name": "connectivity",
                    "parent": "4a88fc9b-a575-4e96-a474-9d149df75e32"
                }
            ]
        }
    }
}
```

The output is ready-to-deploy with a suitable `pwsh/bicep` solution.

## Governance - Policy Assignment

Folder `./governance` contains two cue-files belonging to `policyAssignment` package.
- `policyAssignment.schema.cue` - schema for validating assignment - and scope details. **Observe** reuse of schema element from `managementGroup`,`#Guid` 
- `policyAssignment.transform.cue` - tranforms assignment to a classic Azure bicep parameter file

## Assignment of built-in audit policy

Folder `./governance/policies/audit-storageaccount-infrastructure-encryption` contains a single `assignment.cue`.

This file reuse both the `managementGroup` and `policyAssignment`. **Observe** how easy the scope assignment is done - `scope: managementGroup.#nodes["hybrid"]`. 

```zsh
➜  audit-storageaccount-infrastructure-encryption git:(main) ✗ cue vet
➜  audit-storageaccount-infrastructure-encryption git:(main) ✗ cue export -e r
[
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "policyDefinitionID": {
                "value": "/providers/Microsoft.Authorization/policyDefinitions/4733ea7b-a883-42fe-8cac-97454c2a9e4a"
            },
            "policyAssignmentDisplayName": {
                "value": "Audit SA without infrastructure encryption"
            },
            "scope": {
                "value": "/providers/Microsoft.Management/managementGroups/9ce5c8ec-29d0-4828-8fa6-5dd73cecaf5e"
            },
            "policyAssignmentID": {
                "value": "43ac-b255-2d65ef49b805"
            }
        }
    }
]
```
Validation ok, and the export is ready-to-deploy with a suitable `pwsh/bicep` solution.

## Assignment of built-in deny policy

Folder `./governance/policies/allowed-regions-for-rg-and-resources` contains a single `assignment.cue`.

```zsh
➜  allowed-regions-for-rg-and-resources git:(main) ✗ cue vet
➜  allowed-regions-for-rg-and-resources git:(main) ✗ cue export -e r
[
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "policyDefinitionID": {
                "value": "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
            },
            "policyAssignmentDisplayName": {
                "value": "Allowed Regions for RG and Resources"
            },
            "scope": {
                "value": "/providers/Microsoft.Management/managementGroups/95af6ea4-4c92-4116-b8a4-a8db279fdd9b"
            },
            "parameters": {
                "value": {
                    "listOfAllowedLocations": {
                        "value": [
                            "norwayeast",
                            "norwaywest"
                        ]
                    }
                }
            },
            "policyAssignmentID": {
                "value": "nav-policy-e5cbfcb4-4a0"
            }
        }
    },
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "policyDefinitionID": {
                "value": "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
            },
            "policyAssignmentDisplayName": {
                "value": "Allowed Regions for RG and Resources"
            },
            "scope": {
                "value": "/providers/Microsoft.Management/managementGroups/4a88fc9b-a575-4e96-a474-9d149df75e32"
            },
            "parameters": {
                "value": {
                    "listOfAllowedLocations": {
                        "value": [
                            "norwayeast",
                            "norwaywest"
                        ]
                    }
                }
            },
            "policyAssignmentID": {
                "value": "nav-policy-4af3f96a-6dd"
            }
        }
    }
]
```
Validation ok, and the export is ready-to-deploy with a suitable `pwsh/bicep` solution.

## Governance - Policy Initiative

Folder `./governance` contains a single cue-file belonging to `policyInitiative` 
package
- `policyInitiative.helpers.cue` - defines where custom policy definitions are placed with two helper definitions

## Custom policies to be used in policy initiative

Two folders `./governance/policies/deploy-diagnostics*` contains a single `policy_v*.cue` file. Those are created with `cue import <policy_v*.json>` in each folder.

The only `addition` is the definition of a **package** for each cue-based policy. `cue export` will give ready-to-deploy policy json.

## Policy Initiative Definition - Custom - and Built-in policies

Folder `./governance/initiatives/deploy-diagnostics` contains a `policySet_v1.4.0.cue`, belonging to `deployDiagnosticsPolicy` package.

The key points here are
- import of custom policies packages used in the initiative definition
- automatic generation of `policyDefinitions` based on a list of available policy packages

```zsh
➜  deploy-diagnostics git:(main) ✗ cue vet policySet_v1.4.0.cue
➜  deploy-diagnostics git:(main) ✗
```

Validation ok.

```zsh
➜  deploy-diagnostics git:(main) ✗ cue export policySet_v1.4.0.cue
{
    "policySetId": "fb615e09-4fb2-4014-8c03-b4fdab7315ff-v1.4.0",
    "displayName": "Deploy Diagnostics - v1.4.0",
    "description": "Enable Diagnostic settings on resources and send to Log Analytics",
    "policyType": "Custom",
    "metadata": {
        "version": "1.4.0",
        "category": "Security Center"
    },
    "parameters": {
        "logAnalytics": {
            "type": "String",
            "metadata": {
                "displayName": "Log Analytics workspace",
                "description": "Select Log Analytics workspace from dropdown list. If this workspace is outside of the scope of the assignment you must manually grant 'Log Analytics Contributor' permissions (or similar) to the policy assignment's principal ID.",
                "strongType": "omsWorkspace"
            }
        }
    },
    "policyDefinitions": [
        {
            "policyDefinitionId": "/providers/Microsoft.Management/managementGroups/77b612df-5cc8-4114-b11f-0ab74eadbdf6/providers/Microsoft.Authorization/policyDefinitions/55dad05f-f98b-4f18-8756-335542fe0307-v1.0.0",
            "policyDefinitionReferenceId": "deployDiagnosticSettingsForApplicationGateway",
            "parameters": {
                "logAnalytics": {
                    "value": "[parameters('logAnalytics')]"
                }
            }
        },
        {
            "policyDefinitionId": "/providers/Microsoft.Management/managementGroups/77b612df-5cc8-4114-b11f-0ab74eadbdf6/providers/Microsoft.Authorization/policyDefinitions/b34a519f-4623-49c5-91da-481bfb1a1844-v1.0.1",
            "policyDefinitionReferenceId": "deployDiagnosticSettingsForAzureFirewall",
            "parameters": {
                "logAnalytics": {
                    "value": "[parameters('logAnalytics')]"
                }
            }
        },
        {
            "policyDefinitionId": "/providers/Microsoft.Authorization/policyDefinitions/6f8f98a4-f108-47cb-8e98-91a0d85cd474",
            "policyDefinitionReferenceId": "diagStorageAccount",
            "parameters": {
                "logAnalytics": {
                    "value": "[parameters('logAnalytics')]"
                }
            }
        }
    ]
}
```
A ready-to-deploy policy initiative definition.

## Policy Initiative Assignment

Folder `./governance/initiatives/deploy-diagnostics` contains a `assignment.cue`, belonging to `deployDiagnosticsAssignment` package.

The only difference between this assignment versus the previous ones, is `reuse` of the definition.

```zsh
➜  deploy-diagnostics git:(main) ✗ cue vet assignment.cue
➜  deploy-diagnostics git:(main) ✗
```

Validation ok.

```zsh
➜  deploy-diagnostics git:(main) ✗ cue export assignment.cue -e r
[
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "policyDefinitionID": {
                "value": "/providers/Microsoft.Management/managementGroups/77b612df-5cc8-4114-b11f-0ab74eadbdf6/providers/Microsoft.Authorization/policyDefinitions/fb615e09-4fb2-4014-8c03-b4fdab7315ff-v1.4.0"
            },
            "policyAssignmentDisplayName": {
                "value": "Deploy Diagnostics - v1.4.0"
            },
            "scope": {
                "value": "/providers/Microsoft.Management/managementGroups/95af6ea4-4c92-4116-b8a4-a8db279fdd9b"
            },
            "requiresManagedIdentity": {
                "value": true
            },
            "uaiResourceID": {
                "value": "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourceGroups/CentralLA/providers/Microsoft.ManagedIdentity/userAssignedIdentities/az-platform-centralLA-UAIdentity"
            },
            "parameters": {
                "value": {
                    "logAnalytics": {
                        "value": "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourcegroups/centralla/providers/microsoft.operationalinsights/workspaces/az-platform-central-logs"
                    }
                }
            },
            "roleDefinitionIds": {
                "value": [
                    "/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa",
                    "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
                ]
            },
            "policyAssignmentID": {
                "value": "nav-policy-77dfa217-29a"
            }
        }
    },
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "policyDefinitionID": {
                "value": "/providers/Microsoft.Management/managementGroups/77b612df-5cc8-4114-b11f-0ab74eadbdf6/providers/Microsoft.Authorization/policyDefinitions/fb615e09-4fb2-4014-8c03-b4fdab7315ff-v1.4.0"
            },
            "policyAssignmentDisplayName": {
                "value": "Deploy Diagnostics - v1.4.0"
            },
            "scope": {
                "value": "/providers/Microsoft.Management/managementGroups/4a88fc9b-a575-4e96-a474-9d149df75e32"
            },
            "requiresManagedIdentity": {
                "value": true
            },
            "uaiResourceID": {
                "value": "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourceGroups/CentralLA/providers/Microsoft.ManagedIdentity/userAssignedIdentities/az-platform-centralLA-UAIdentity"
            },
            "parameters": {
                "value": {
                    "logAnalytics": {
                        "value": "/subscriptions/7e260459-3026-4653-b259-0347c0bb5970/resourcegroups/centralla/providers/microsoft.operationalinsights/workspaces/az-platform-central-logs"
                    }
                }
            },
            "roleDefinitionIds": {
                "value": [
                    "/providers/microsoft.authorization/roleDefinitions/749f88d5-cbae-40b8-bcfc-e573ddc772fa",
                    "/providers/microsoft.authorization/roleDefinitions/92aaf0da-9dab-42b6-94a3-d43ce8d16293"
                ]
            },
            "policyAssignmentID": {
                "value": "nav-policy-f65a168d-447"
            }
        }
    }
]
```
Ready-to-deploy with a suitable pwsh/bicep solution.