# Purpose

Define relevant test cases for deploy-diagnostics-storageaccount.

The policy has the effect `deployIfNotExists`, giving two options for existence conditions;
1. satisfied - compliance
2. NOT satisfied -  non-compliance and remediation should result in compliance

# Test cases

## Prerequisites for each test case
- A resource group (rg) is available

## Existence condition are satisfied

*Steps*
- Deploy a storage account with diagnostic settings for table
- Deploy policy assignment
- Do policy compliance scan

*Result*: compliance

## Existence condition are NOT satisfied

**Awareness** - the policy engine may interfer by doing its own actions behind the scene.

*Steps*
- Deploy policy assignment
- Create storage account without diag settings for table
- Do policy compliance scan - non-compliance

*Intermediate result*: non-compliance

- Do remediation task - should see diagnostic settings for storage account
- Do policy compliance scan

*Result*: compliance