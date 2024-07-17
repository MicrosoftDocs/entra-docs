---
title: Create a Microsoft Entra entitlement management access package for an application with a single role with PowerShell| Microsoft Docs
description: You can use Microsoft Entra entitlement management to enforce the policies for who can get assigned access to an application.
author: markwahl-msft
manager: amycolannino
editor: markwahl-msft
ms.service: entra-id-governance
ms.topic: how-to
ms.date: 04/05/2024
ms.author: mwahl
ms.reviewer: mwahl
---

# Create an access package in entitlement management for an application with a single role using PowerShell

In Microsoft Entra entitlement management, an access package encompasses the policies for how users can obtain assignments for one or more resource roles. The resources can include groups, applications, and SharePoint Online sites.

This article describes how to create an access package for a single application with a single role, using Microsoft Graph PowerShell. This scenario is primarily applicable to environments that are using entitlement management for automating ongoing access for a specific business or middleware application. An organization that has multiple resources or resources with multiple roles can also model their access policies with access packages:

* If the organization already has an existing organizational role model for their business roles, they can migrate that model to Microsoft Entra ID Governance, and [govern access with an organizational role model](identity-governance-organizational-roles.md).
* If the organization has applications with multiple roles, then they can [deploy organizational policies for governing access to applications integrated with Microsoft Entra ID](identity-governance-applications-deploy.md)
* For more information on creating access packages for other scenarios, see [tutorial: Manage access to resources in entitlement management](entitlement-management-access-package-first.md) and how to [create an access package in entitlement management](entitlement-management-access-package-create.md).

## Prerequisites

[!INCLUDE [active-directory-entra-governance-license.md](~/includes/entra-entra-governance-license.md)]


Before you begin creating the access package, you must [integrate the application with Microsoft Entra ID](identity-governance-applications-integrate.md). If your application isn't already present in your Microsoft Entra ID tenant, follow the instructions in that article to create an application and service principal for the object. Also ensure that your Microsoft Entra ID tenant has met the [prerequisites before configuring Microsoft Entra ID for identity governance](identity-governance-applications-prepare.md).

To create the access package and its associated policies and assignments, you'll need to have the following information ready:

|Use case|Configuration setting|PowerShell variable|
|--|--|--|
| All| Name of the application in your Microsoft Entra ID tenant|`$servicePrincipalName`|
| All| Name of the application's role|`$servicePrincipalRoleName`|
| All| Name of the catalog containing the access package|`$catalogName`|
| All| Name to give the access package|`$accessPackageName`|
| All | Description to give the access package|`$accessPackageDescription`|
| Separation of duties requirement with an incompatible access package | the ID of the incompatible access package | `$incompatibleAccessPackageId` (if required) |
| Users who do not already have assignments and would not be automatically assigned | list of users | `$inputpath` (if required) |
| Users with specific attributes automatically have assignments | the query expression for the users in scope | `$autoAssignmentPolicyFilter` (if required) |
| Allow users who don't have an assignment to request an assignment| the scope of users who can request, the approvers, and the access review period |depends upon requirements |
| Automate the creation or removal of assignments based on join or leave workflows in lifecycle workflows | the names of the workflows that give and remove access | depends upon requirements |

## Authenticate to Microsoft Entra ID

This section shows how to interact with Microsoft Entra ID Governance by using [Microsoft Graph PowerShell](https://www.powershellgallery.com/packages/Microsoft.Graph) cmdlets.

The first time your organization uses these cmdlets for this scenario, you need to be in a Global Administrator role to allow Microsoft Graph PowerShell to be used in your tenant. Subsequent interactions can use a lower-privileged role, such as:

- [Identity Governance Administrator](~/identity/role-based-access-control/permissions-reference.md#identity-governance-administrator).

1. Open PowerShell.
1. If you don't have the [Microsoft Graph PowerShell modules](https://www.powershellgallery.com/packages/Microsoft.Graph) already installed, install the `Microsoft.Graph.Identity.Governance` module and others by using this command:

   ```powershell
   Install-Module Microsoft.Graph
   ```

   If you already have the modules installed, ensure that you're using a recent version:

   ```powershell
   Update-Module microsoft.graph.users,microsoft.graph.identity.governance,microsoft.graph.applications
   ```

1. Connect to Microsoft Entra ID:

   ```powershell
   $msg = Connect-MgGraph -ContextScope Process -Scopes "User.ReadWrite.All,Application.ReadWrite.All,AppRoleAssignment.ReadWrite.All,EntitlementManagement.ReadWrite.All"
   ```

1. If this is the first time you have used this command, you may need to consent to allow the Microsoft Graph Command Line tools to have these permissions.

## Create a catalog in Microsoft Entra entitlement management

By default, when an administrator first interacts with entitlement management, then a default catalog is automatically created. However, access packages for governed applications should be in a designated catalog.

1. Specify the name of the catalog.

   ```powershell
   $catalogName = "Business applications"
   ```

1. If you already have a catalog for your application governance scenario, then continue at step 4 of this section.
1. If you don't already have a catalog for your application governance scenario, [create a catalog](entitlement-management-catalog-create.md#create-a-catalog-with-powershell).

   ```powershell
   $catalog = New-MgEntitlementManagementCatalog -DisplayName $catalogName
   ```

1. Look up the ID of the catalog.

   ```powershell
   $catalogFilter = "displayName eq '" + $catalogName + "'"
   $catalog = Get-MgEntitlementManagementCatalog -Filter $catalogFilter -All -expandProperty resources,accessPackages
   if ($catalog -eq $null) { throw "catalog $catalogName not found" }
   $catalogId = $catalog.Id
   ```

## Add the application as a resource to the catalog

Once the catalog is created, add the application [as a resource in that catalog](entitlement-management-catalog-create.md#add-a-resource-to-a-catalog-with-powershell).

1. Specify the name of the application and the name of the application role. Use the name of your application as the value of `servicePrincipalName`.

   ```powershell
   $servicePrincipalName = "SAP Cloud Identity Services"
   $servicePrincipalRoleName = "User"
   ```

1. Look up the ID of the application service principal.

   ```powershell
   $servicePrincipalFilter = "displayName eq '" + $applicationName + "'"
   $servicePrincipal = Get-MgServicePrincipal -Filter $servicePrincipalFilter -all
   if ($servicePrincipal -eq $null) { throw "service principal $servicePrincipalName not found" }
   $servicePrincipalId = $servicePrincipal.Id
   ```

1. Check if the application is already present in the catalog as a resource. If it's already present, continue at step 6 of this section.

   ```powershell
   $resourceId = $null
   foreach ($r in $catalog.Resources) { if ($r.OriginId -eq $servicePrincipalId) { $resourceId = $r.id; break } }
   if ($resourceId -ne $null) { write-output "resource already in catalog" } else {write-output "resource not yet in catalog"}
   ```

1. Add the application's service principal as a resource to the catalog.

   ```powershell
   $resourceAddParams = @{
     requestType = "adminAdd"
     resource = @{
       originId = $servicePrincipalId
       originSystem = "AadApplication"
     }
     catalog = @{ id = $catalogId }
   }

   $resourceAdd = New-MgEntitlementManagementResourceRequest -BodyParameter $resourceAddParams
   if ($resourceAdd -eq $null) { throw "resource could not be added" }
   sleep 5
   ```

1. Retrieve the ID and the scope of the resource in that catalog.

   ```powershell
   $resource = $null
   $resourceId = $null
   $resourceScope = $null
   $catalogResources = Get-MgEntitlementManagementCatalogResource -AccessPackageCatalogId $CatalogId -ExpandProperty "scopes" -all

   foreach ($r in $catalogResources) { if ($r.OriginId -eq $servicePrincipalId) { $resource = $r; $resourceId = $r.id; $resourceScope = $r.Scopes[0]; break } }
   if ($resourceId -eq $null) { throw "resource was not added" }
   ```

1. Retrieve the roles of the application.

   ```powershell
   $resourceRoleFilter = "(originSystem eq 'AadApplication' and resource/id eq '" + $resourceId + "')"
   $resourceRoles = @(get-mgentitlementmanagementcatalogresourcerole  -AccessPackageCatalogId $catalogId -Filter $resourceRoleFilter -All -ExpandProperty "resource")
   if ($resourceRoles -eq $null -or $resourceRoles.count -eq 0) { throw "no roles available" }
   ```

1. Select the role that will be included in the access package.

   ```powershell
   $resourceRole = $null
   foreach ($r in $resourceRoles) { if ($r.DisplayName -eq $servicePrincipalRoleName) { $resourceRole = $r; break; } }
   if ($resourceRole -eq $null) { throw "role $servicePrincipalRoleName not located" }
   ```

## Create the access package for the application


Next you'll use PowerShell to [create an access package in a catalog](entitlement-management-access-package-create.md#create-an-access-package-by-using-microsoft-powershell)  that includes the application's role.

1. Specify the name and description of the access package.

   ```powershell
   $accessPackageName = "SAP Cloud Identity Services"
   $accessPackageDescription = "A user of SAP Cloud Identity Services"
   $accessPackageHidden = $true
   ```

1. Check that the access package doesn't already exist.


   ```powershell
   foreach ($a in $catalog.AccessPackages) { if ($a.DisplayName -eq $accessPackageName) { throw "access package $accessPackageName already exists" } }
   ```

1. Create the access package.

   ```powershell
   $accessPackageParams = @{
       displayName = $accessPackageName
       description = $accessPackageDescription
       isHidden = $accessPackageHidden
       catalog = @{
           id = $catalog.id
       }
   }
   $accessPackage = New-MgEntitlementManagementAccessPackage -BodyParameter $accessPackageParams
   $accessPackageId = $accessPackage.Id
   ```

## Add the application role to the access package

Once you've created an access package, then you link the role of the resource in the catalog to the access package.

   ```powershell
   $rrsParams = @{
    role = @{
        id =  $resourceRole.Id
        displayName =  $resourceRole.DisplayName
        description =  $resourceRole.Description
        originSystem =  $resourceRole.OriginSystem
        originId =  $resourceRole.OriginId
        resource = @{
            id = $resource.Id
            originId = $resource.OriginId
            originSystem = $resource.OriginSystem
        }
    }
    scope = @{
        id = $resourceScope.Id
        originId = $resourceScope.OriginId
        originSystem = $resourceScope.OriginSystem
    }
   }

   $roleAddRes = New-MgEntitlementManagementAccessPackageResourceRoleScope -AccessPackageId $accessPackageId -BodyParameter $rrsParams
   ```

## Create access package assignment policies for direct assignment

In this section you'll create the first access package assignment policy in the access package, an [access package assignment policy for direct assignment](entitlement-management-access-package-request-policy.md#none-administrator-direct-assignments-only), that can be used to track the users who already have access to the application. In the example policy created in this section, only the administrators or access package assignment managers can assign access, users retain access indefinitely, and there are no approvals or access reviews.

1. Create a policy.

   ```powershell
   $policy1Name = "Direct assignment policy"
   $policy1Description = "policy for administrative assignment"

   $policy1params = @{
    displayName = $policy1Name
    description = $policy1Description
    allowedTargetScope = "notSpecified"
    specificAllowedTargets = @(
    )
    expiration = @{
        endDateTime = $null
        duration = $null
        type = "noExpiration"
    }
    requestorSettings = @{
        enableTargetsToSelfAddAccess = $true
        enableTargetsToSelfUpdateAccess = $false
        enableTargetsToSelfRemoveAccess = $true
        allowCustomAssignmentSchedule = $true
        enableOnBehalfRequestorsToAddAccess = $false
        enableOnBehalfRequestorsToUpdateAccess = $false
        enableOnBehalfRequestorsToRemoveAccess = $false
        onBehalfRequestors = @(
        )
    }
    requestApprovalSettings = @{
        isApprovalRequiredForAdd = $false
        isApprovalRequiredForUpdate = $false
        stages = @(
        )
    }
    accessPackage = @{
        id = $accessPackageId
    }
   }

   $policy1Res = New-MgEntitlementManagementAssignmentPolicy -BodyParameter $policy1params
   $directAssignmentPolicyId = $policy1Res.Id

   ```

## Configure separation of duties constraints

Microsoft Entra entitlement management can enforce [separation of duties](entitlement-management-access-package-incompatible.md) checks to prevent a user who already has an existing assignment to another designated access package, or membership of a designated group, from requesting an access package.

If you don't have separation of duties requirements for this application, then continue at the next section.

If you have separation of duties requirements, then configure the incompatible access packages or existing groups for your access package.

For each access package that is to be marked as incompatible with another, you can use a PowerShell [configure access packages as incompatible](entitlement-management-access-package-incompatible.md#configure-incompatible-access-packages-through-microsoft-powershell).

1. Specify the other access package that is incompatible with this one. Change the value of `incompatibleAccessPackageId` to the ID of another access package in Microsoft Entra entitlement management.

   ```powershell
   $incompatibleAccessPackageId = "67cc7175-7a3d-4cb2-860f-4d9217ba96ca"
   ```

1. Create the incompatible reference on this access package.

   ```powershell
   $incompatible1params = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/accessPackages/" + $incompatibleAccessPackageId
   }
   New-MgEntitlementManagementAccessPackageIncompatibleAccessPackageByRef -AccessPackageId $accessPackageId -BodyParameter $incompatible1params
   ```

1. Create the incompatible reference on the other access package.

   ```powershell
   $incompatible2params = @{
    "@odata.id" = "https://graph.microsoft.com/v1.0/identityGovernance/entitlementManagement/accessPackages/" + $accessPackageId
   }
   New-MgEntitlementManagementAccessPackageIncompatibleAccessPackageByRef -AccessPackageId $incompatibleAccessPackageId -BodyParameter $incompatible2params
   ```

1. Repeat for any other access packages.

1. If your scenario requires the ability to override a separation of duties check, then you can also [set up additional access packages for those override scenarios](entitlement-management-access-package-incompatible.md#configuring-multiple-access-packages-for-override-scenarios).

## Add assignments of existing users who already have access to the application

Add assignments of existing users, who already have access to the application, to the access package and its direct assignment policy. You can [directly assign each user](entitlement-management-access-package-assignments.md#assign-a-user-to-an-access-package-with-powershell) to an access package.

1. Retrieve the existing application role assignments.

   ```powershell
   $existingAppRoleAssignments = @(Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $servicePrincipalId -All)
   ```

1. To avoid creating duplicate assignments, retrieve any existing assignments to the access package.

   ```powershell
   $existingAssignments1filter = "accessPackage/id eq '" + $accessPackageId + "' and state eq 'Delivered'"
   $existingassignments1 = @(Get-MgEntitlementManagementAssignment -Filter $existingAssignments1filter -ExpandProperty target -All -ErrorAction Stop)
   $existingusers1 = @()
   foreach ($a in $existingassignments1) { $existingusers1 += $a.Target.ObjectId}
   ```

1. Create new assignments.

   ```powershell
   foreach ($ar in $existingAppRoleAssignments) {
    if ($ar.principalType -ne "User") {
      write-warning "non-user assigned to application role"
    }
    $arpid = $ar.principalId
    if ($existingusers1.contains($arpId)) { continue }

    $params = @{
      requestType = "adminAdd"
      assignment = @{
         targetId = $arpId
         assignmentPolicyId = $directAssignmentPolicyId
         accessPackageId = $accessPackageId
      }
    }
    try {
      New-MgEntitlementManagementAssignmentRequest -BodyParameter $params
    } catch {
      write-error "cannot create request for user $upn"
    }
   }
   ```

## Add any additional users who should have access to the application

This script illustrates using the Microsoft Graph PowerShell cmdlets to add additional users to the application. If you don't have any users that need access, and wouldn't receive it automatically, then continue in the next section.

This script assumes you have an input CSV file containing one column, `UserPrincipalName`, to assign those users to the access package via its direct assignment policy.

1. Specify the name of the input file.

   ```powershell
   $inputpath = "users.csv"
   ```

1. To avoid creating duplicate assignments, retrieve any existing assignments to the access package.

   ```powershell
   $existingAssignments2filter = "accessPackage/id eq '" + $accessPackageId + "' and state eq 'Delivered'"
   $existingassignments2 = @(Get-MgEntitlementManagementAssignment -Filter $existingAssignments2filter -ExpandProperty target -All -ErrorAction Stop)
   $existingusers2 = @()
   foreach ($a in $existingassignments2) { $existingusers2 += $a.Target.ObjectId}
   ```

1. Create new assignments.

   ```powershell
   $users = import-csv -Path $inputpath
   foreach ($userrecord in $users) {
      $upn = $userrecord.UserPrincipalName
      if ($null -eq $upn) {throw "no UserPrincipalName" }
      $u = $null
      try {
         $u = Get-MgUser -UserId $upn
      } catch {
         write-error "no user $upn"
      }
      if ($u -eq $null) { continue }
      if ($existingusers2.contains($u.Id)) { continue }

      $params = @{
         requestType = "adminAdd"
         assignment = @{
            targetId = $u.Id
            assignmentPolicyId = $directAssignmentPolicyId
            accessPackageId = $accessPackageId
         }
      }
      try {
         New-MgEntitlementManagementAssignmentRequest -BodyParameter $params
      } catch {
         write-error "cannot create request for user $upn"
      }
   }
   ```

## Add a policy to the access packages for auto assignment

If your organization's policy for who can be assigned access to an application includes a rule based on user's attributes to assign and remove access automatically based on those attributes, you can represent this using an [automatic assignment policy](entitlement-management-access-package-auto-assignment-policy.md). An access package can have at most one automatic assignment policy. If you don't have a requirement for an automatic assignment, then continue at the next section.

1. Specify the automatic assignment filter expression for users to receive an assignment. Change the value of `autoAssignmentPolicyFilter` to be a filter for the users in your Microsoft Entra ID that are in scope. The syntax and allowable attributes are provided in [dynamic membership rules for groups in Microsoft Entra ID](~/identity/users/groups-dynamic-membership.md).

   ```powershell
   $autoAssignmentPolicyFilter = '(user.city -eq "Redmond")'
   ```

1. Use PowerShell to [create an automatic assignment policy](entitlement-management-access-package-auto-assignment-policy.md#create-an-access-package-assignment-policy-through-powershell) in the access package.

   ```powershell
   $policy2Name = "Automatic assignment policy"
   $policy2Description = "policy for automatic assignment"

   $policy2Params = @{
    DisplayName = $policy2Name
    Description = $policy2Description
    AllowedTargetScope = "specificDirectoryUsers"
    SpecificAllowedTargets = @( @{
        "@odata.type" = "#microsoft.graph.attributeRuleMembers"
        description = $policy2Description
        membershipRule = $autoAssignmentPolicyFilter
    } )
    AutomaticRequestSettings = @{
        RequestAccessForAllowedTargets = $true
    }
    AccessPackage = @{
      Id = $accessPackageId
    }
   }
   New-MgEntitlementManagementAssignmentPolicy -BodyParameter $policy2Params
   ```

## Create additional policies to allow users to request access

If users who don't already have access allowed to request to be assigned to the application, then you can also configure an access package assignment policy to allow users to request an access package. You can [add additional policies to an access package](entitlement-management-access-package-request-policy.md#choose-between-one-or-multiple-policies), and in each policy specify which users can request and who must approve. If you wish to only have users assigned access automatically or by an administrator, then continue at the next section.

For more examples, see [Create an assignment policy through PowerShell](entitlement-management-access-package-request-policy.md#create-an-access-package-assignment-policy-through-powershell), [accessPackageAssignmentPolicy](/graph/api/resources/accesspackageassignmentpolicy) and [Create an assignmentPolicy](/graph/api/entitlementmanagement-post-assignmentpolicies?tabs=http&view=graph-rest-1.0&preserve-view=true).


1. Specify the name, description of the policy, and the ID of a Microsoft Entra user who will be the approver.

   ```powershell
   $policy3Name = "example policy"
   $policy3Description = "example of a policy for users to request assignment"
   $policy3ApproverSingleUserId = "1aaaaaa1-2bb2-3cc3-4dd4-5eeeeeeeeee5"
   ```

1. Create the policy.

   ```powershell
   $policy3Params = @{
    displayName = $policy3Name
    description = $policy3Description
    allowedTargetScope = "allMemberUsers"
    expiration = @{
        type = "noExpiration"
    }
    requestorSettings = @{
        enableTargetsToSelfAddAccess = "true"
        enableTargetsToSelfUpdateAccess = "true"
        enableTargetsToSelfRemoveAccess = "true"
    }
    requestApprovalSettings = @{
        isApprovalRequiredForAdd = "true"
        isApprovalRequiredForUpdate = "true"
        stages = @(
            @{
                durationBeforeAutomaticDenial = "P7D"
                isApproverJustificationRequired = "false"
                isEscalationEnabled = "false"
                fallbackPrimaryApprovers = @(
                )
                escalationApprovers = @(
                )
                fallbackEscalationApprovers = @(
                )
                primaryApprovers = @(
                    @{
                        "@odata.type" = "#microsoft.graph.singleUser"
                        userId = $policy3ApproverSingleUserId
                    }
                )
            }
        )
    }
    accessPackage = @{
        id = $accessPackageId
    }
   }

   New-MgEntitlementManagementAssignmentPolicy -BodyParameter $policy3Params
   ```

## Configure lifecycle workflows tasks

If you use Microsoft Entra [lifecycle workflows](what-are-lifecycle-workflows.md) for employee join, move leave events, then you can also add tasks to those workflows to add or remove assignments to this access package. If you don't use lifecycle workflows, then continue at the next section.

This example illustrates how to make a change to the join and leave event workflows.

1. Retrieve the `joiner` category workflow and its tasks, using [Get-MgIdentityGovernanceLifecycleWorkflow](/graph/api/identitygovernance-workflow-get?&tabs=powershell) command.
1. Add a [task](/graph/api/resources/identitygovernance-task) to list of tasks in that workflow.

   | Task display name | taskDefinitionId | arguments |
   |--|--|--|
   | Request user access package assignment | `c1ec1e76-f374-4375-aaa6-0bb6bd4c60be` | **name**: `assignmentPolicyId`<br/>**value**: The assignment policy ID, such as the value from `$directAssignmentPolicyId` if no approval is required, for the access package you want to assign the user.<br/><br/>**name**: `accessPackageId`<br/>**value**: The access package ID, `$accessPackageId`, for the access package you want to assign to the user. |

1. Create a new version of the workflow, including the new task, using [New-MgIdentityGovernanceLifecycleWorkflowNewVersion](/graph/api/identitygovernance-workflow-createnewversion?&tabs=powershell) command.

1. Retrieve the `leaver` category workflow and its tasks, using [Get-MgIdentityGovernanceLifecycleWorkflow](/graph/api/identitygovernance-workflow-get?&tabs=powershell) command.
1. Add a [task](/graph/api/resources/identitygovernance-task) to list of tasks in that workflow.

   | Task display name | taskDefinitionId | arguments |
   |--|--|--|
   | Remove access package assignment for user | `4a0b64f2-c7ec-46ba-b117-18f262946c50` | **name**: `accessPackageId`<br/>**value**: A valid access package ID, `accessPackageId` for the access package you want to unassign from the user. |

1. Create a new version of the workflow, including the new task, using [New-MgIdentityGovernanceLifecycleWorkflowNewVersion](/graph/api/identitygovernance-workflow-createnewversion?&tabs=powershell) command.

## Manage assignments

Once the access packages, policies, and initial assignments have been created, then users are assigned access to the application's role.

Later, you can monitor for changes to the assignments, or programmatically add or remove assignments.

### Retrieve existing assignments

This script illustrates using a filter to retrieve the assignments to the access package that are in state `Delivered`. The script generates a CSV file `assignments.csv` with a list of users that have assignments, with one row per assignment.

   ```powershell
   $assignmentFilter = "accessPackage/id eq '" + $accessPackageId + "' and state eq 'Delivered'"
   $assignments = @(Get-MgEntitlementManagementAssignment -Filter $assignmentFilter -ExpandProperty target -All -ErrorAction Stop)
   $sp = $assignments | select-object -Property Id,{$_.Target.id},{$_.Target.ObjectId},{$_.Target.DisplayName},{$_.Target.PrincipalName}
   $sp | Export-Csv -Encoding UTF8 -NoTypeInformation -Path ".\assignments.csv"
   ```

### Remove an assignment

You can remove a user's assignment with the `New-MgEntitlementManagementAssignmentRequest` cmdlet.

```powershell
$userId = "00aa00aa-bb11-cc22-dd33-44ee44ee44ee"
$filter = "accessPackage/Id eq '" + $accessPackageId + "' and state eq 'Delivered' and target/objectId eq '" + $userId + "'"
$assignment = Get-MgEntitlementManagementAssignment -Filter $filter -ExpandProperty target -all -ErrorAction stop
if ($assignment -ne $null) {
   $params = @{
      requestType = "adminRemove"
      assignment = @{ id = $assignment.id }
   }
   New-MgEntitlementManagementAssignmentRequest -BodyParameter $params
}
```

## Next steps

- [Govern access for an application's existing users](identity-governance-applications-existing-users.md)
- [Govern access for applications in your environment](identity-governance-applications-prepare.md)
