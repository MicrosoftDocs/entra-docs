---
title: Configure a multitenant organization using PowerShell or Microsoft Graph API
description: Learn how to configure a multitenant organization in Microsoft Entra ID using Microsoft Graph PowerShell or Microsoft Graph API.
author: rolyon
manager: amycolannino
ms.service: entra-id
ms.subservice: multitenant-organizations
ms.topic: how-to
ms.date: 04/23/2024
ms.author: rolyon
ms.custom: it-pro
#Customer intent: As a dev, devops, or it admin, I want to
---

# Configure a multitenant organization using PowerShell or Microsoft Graph API

This article describes the key steps to configure a multitenant organization using Microsoft Graph PowerShell or Microsoft Graph API. This article uses an example owner tenant named *Cairo* and two member tenants named *Berlin* and *Athens*.

If you instead want to use the Microsoft 365 admin center to configure a multitenant organization, see [Set up a multitenant org in Microsoft 365](/microsoft-365/enterprise/set-up-multi-tenant-org) and [Join or leave a multitenant organization in Microsoft 365](/microsoft-365/enterprise/join-leave-multi-tenant-org). To learn how to configure Microsoft Teams for your multitenant organization, see the [Microsoft Teams desktop client](/microsoftteams/new-teams-desktop-admin).

:::image type="content" source="./media/multi-tenant-organization-configure-graph/configure-multitenant-organization-diagram.png" alt-text="Diagram that shows a multitenant organization with one owner tenant and two member tenants." lightbox="./media/multi-tenant-organization-configure-graph/configure-multitenant-organization-diagram.png":::

## Prerequisites

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

- For license information, see [License requirements](./multi-tenant-organization-overview.md#license-requirements).
- [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator) role to configure cross-tenant access settings and templates for the multitenant organization.
- [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) role to consent to required permissions.

![Icon for the member tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Member tenant**

- For license information, see [License requirements](./multi-tenant-organization-overview.md#license-requirements).
- [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator) role to configure cross-tenant access settings and templates for the multitenant organization.
- [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator) role to consent to required permissions.

## Step 1: Sign in to the owner tenant

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

# [PowerShell](#tab/ms-powershell)

1. Start PowerShell.

1. If necessary, install the [Microsoft Graph PowerShell SDK](/powershell/microsoftgraph/installation).

1. Get the tenant ID of the owner and member tenants and initialize variables.

    ```powershell
    $OwnerTenantId = "<OwnerTenantId>"
    $MemberTenantIdB = "<MemberTenantIdB>"
    $MemberTenantIdA = "<MemberTenantIdA>"
    ```

1. Use the [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) command to sign in to the owner tenant and consent to the following required permissions.

    - `MultiTenantOrganization.ReadWrite.All`
    - `Policy.Read.All`
    - `Policy.ReadWrite.CrossTenantAccess`
    - `Application.ReadWrite.All`
    - `Directory.ReadWrite.All`

    ```powershell
    Connect-MgGraph -TenantId $OwnerTenantId -Scopes "MultiTenantOrganization.ReadWrite.All","Policy.Read.All","Policy.ReadWrite.CrossTenantAccess","Application.ReadWrite.All","Directory.ReadWrite.All"
    ```

# [Microsoft Graph](#tab/ms-graph)

These steps describe how to use Microsoft Graph Explorer, but you can also use another REST API client.

1. Start [Microsoft Graph Explorer tool](https://aka.ms/ge).

1. Sign in to the owner tenant.

1. Select your profile and then select **Consent to permissions**.

1. Consent to the following required permissions.

    - `MultiTenantOrganization.ReadWrite.All`
    - `Policy.Read.All`
    - `Policy.ReadWrite.CrossTenantAccess`
    - `Application.ReadWrite.All`
    - `Directory.ReadWrite.All`

---

## Step 2: Create a multitenant organization

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

# [PowerShell](#tab/ms-powershell)

1. In the owner tenant, use the [Update-MgBetaTenantRelationshipMultiTenantOrganization](/powershell/module/microsoft.graph.beta.identity.signins/update-mgbetatenantrelationshipmultitenantorganization) command to create your multitenant organization. This operation can take a few minutes.

    ```powershell
    Update-MgBetaTenantRelationshipMultiTenantOrganization -DisplayName "Cairo"
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganization](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganization) command to check that the operation has completed before proceeding.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganization | Format-List
    ```

    ```Output
    CreatedDateTime      : 1/8/2024 7:47:45 PM
    Description          :
    DisplayName          : Cairo
    Id                   : <MtoIdC>
    JoinRequest          : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationJoinRequestRecord
    State                : active
    Tenants              :
    AdditionalProperties : {[@odata.context, https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/$entity]}
    ```

# [Microsoft Graph](#tab/ms-graph)

1. In the owner tenant, use the [Create multiTenantOrganization](/graph/api/tenantrelationship-put-multitenantorganization) API to create your multitenant organization. This operation can take a few minutes.

    **Request**

    ```http
    PUT https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization
    {
        "displayName": "Cairo"
    }
    ```

1. Use the [Get multiTenantOrganization](/graph/api/multitenantorganization-get) API to check that the operation has completed before proceeding.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization
    ```

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/$entity",
        "id": "{mtoId}",
        "createdDateTime": "2023-11-20T20:38:20Z",
        "state": "active",
        "displayName": "Cairo",
        "description": null
    }
    ```

---

## Step 3: Add tenants

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

# [PowerShell](#tab/ms-powershell)

1. In the owner tenant, use the [New-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/new-mgbetatenantrelationshipmultitenantorganizationtenant) command to add tenants to your multitenant organization.

    ```powershell
    New-MgBetaTenantRelationshipMultiTenantOrganizationTenant -TenantID $MemberTenantIdB -DisplayName "Berlin" | Format-List
    ```

    ```powershell
    New-MgBetaTenantRelationshipMultiTenantOrganizationTenant -TenantID $MemberTenantIdA -DisplayName "Athens" | Format-List
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganizationtenant) command to verify that the operation has completed before proceeding.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant | Format-List
    ```

    ```Output
    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 7:47:45 PM
    DeletedDateTime      :
    DisplayName          : Cairo
    Id                   : <MtoIdC>
    JoinedDateTime       :
    Role                 : owner
    State                : active
    TenantId             : <OwnerTenantId>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[multiTenantOrgLabelType, none]}

    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 8:05:25 PM
    DeletedDateTime      :
    DisplayName          : Berlin
    Id                   : <MtoIdB>
    JoinedDateTime       :
    Role                 : member
    State                : pending
    TenantId             : <MemberTenantIdB>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[multiTenantOrgLabelType, none]}

    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 8:08:47 PM
    DeletedDateTime      :
    DisplayName          : Athens
    Id                   : <MtoIdA>
    JoinedDateTime       :
    Role                 : member
    State                : pending
    TenantId             : <MemberTenantIdA>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[multiTenantOrgLabelType, none]}
    ```

# [Microsoft Graph](#tab/ms-graph)

1. In the owner tenant, use the [Add multiTenantOrganizationMember](/graph/api/multitenantorganization-post-tenants) API to add tenants to your multitenant organization.

    **Request**

    ```http
    POST https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants
    {
        "tenantId": "{memberTenantIdB}",
        "displayName": "Berlin"
    }
    ```

    **Request**

    ```http
    POST https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants
    {
        "tenantId": "{memberTenantIdA}",
        "displayName": "Athens"
    }
    ```

1. Use the [List multiTenantOrganizationMembers](/graph/api/multitenantorganization-list-tenants) API to verify that the operation has completed before proceeding.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants
    ```

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/tenants"
        "value": [
            {
                "tenantId": "{ownerTenantId}",
                "displayName": "Cairo",
                "addedDateTime": "2023-11-20T20:38:20Z",
                "joinedDateTime": null,
                "addedByTenantId": "{ownerTenantId}",
                "role": "owner",
                "state": "active",
                "transitionDetails": null
            },
            {
                "tenantId": "{memberTenantIdB}",
                "displayName": "Berlin",
                "addedDateTime": "2023-11-20T21:22:35Z",
                "joinedDateTime": null,
                "addedByTenantId": "{ownerTenantId}",
                "role": "member",
                "state": "pending",
                "transitionDetails": {
                    "desiredState": "active",
                    "desiredRole": "member",
                    "status": "notStarted",
                    "details": null
                }
            },
            {
                "tenantId": "{memberTenantIdA}",
                "displayName": "Athens",
                "addedDateTime": "2023-11-20T21:24:59Z",
                "joinedDateTime": null,
                "addedByTenantId": "{ownerTenantId}",
                "role": "member",
                "state": "pending",
                "transitionDetails": {
                    "desiredState": "active",
                    "desiredRole": "member",
                    "status": "notStarted",
                    "details": null
                }
            }
        ]
    }
    ```

---

## Step 4: (Optional) Change the role of a tenant

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

By default, tenants added to the multitenant organization are member tenants. Optionally, you can change them to owner tenants, which allow them to add other tenants to the multitenant organization. You can also change an owner tenant to a member tenant.

# [PowerShell](#tab/ms-powershell)

1. In the owner tenant, use the [Update-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/update-mgbetatenantrelationshipmultitenantorganizationtenant) command to change a member tenant to an owner tenant.

    ```powershell
    Update-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId $MemberTenantIdB -Role "Owner" | Format-List
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganizationtenant) command to verify the change.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId $MemberTenantIdB | Format-List
    ```

    ```Output
    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 8:05:25 PM
    DeletedDateTime      :
    DisplayName          : Berlin
    Id                   : <MtoIdB>
    JoinedDateTime       :
    Role                 : owner
    State                : pending
    TenantId             : <MemberTenantIdB>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[@odata.context, https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/tenants/$entity],
                           [multiTenantOrgLabelType, none]}
    ```

# [Microsoft Graph](#tab/ms-graph)

1. In the owner tenant, use the [Update multiTenantOrganizationMember](/graph/api/multitenantorganizationmember-update) API to change a member tenant to an owner tenant.

    **Request**

    ```http
    PATCH https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantIdB}
    {
        "role": "owner"
    }
    ```

1. Use the [Get multiTenantOrganizationMember](/graph/api/multitenantorganizationmember-get) API to verify the change.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantIdB}
    ```

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/tenants/$entity",
        "tenantId": "{memberTenantIdB}",
        "displayName": "Berlin",
        "addedDateTime": "2023-11-20T21:22:35Z",
        "joinedDateTime": null,
        "addedByTenantId": "{ownerTenantId}",
        "role": "member",
        "state": "pending",
        "transitionDetails": {
            "desiredState": "active",
            "desiredRole": "owner",
            "status": "notStarted",
            "details": null
        } 
    }
    ```

1. Use the [Update multiTenantOrganizationMember](/graph/api/multitenantorganizationmember-update) API to change an owner tenant to a member tenant.

    **Request**

    ```http
    PATCH https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantIdB}
    {
        "role": "member"
    }
    ```

---

## Step 5: (Optional) Remove a member tenant

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

You can remove any member tenant, including your own. You can't remove owner tenants. Also, you can't remove the original creator tenant, even if it has been changed from owner to member.

# [PowerShell](#tab/ms-powershell)

1. In the owner tenant, use the [Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/remove-mgbetatenantrelationshipmultitenantorganizationtenant) command to remove any member tenant. This operation takes a few minutes.

    ```powershell
    Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId <MemberTenantIdD>
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganizationtenant) command to verify the change.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId <MemberTenantIdD>
    ```

    After the remove command completes, the output is similar to the following. This is an expected error message. It indicates that the tenant has been removed from the multitenant organization.

    ```Output
    Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant_Get: Unable to read the company information from the directory.

    Status: 404 (NotFound)
    ErrorCode: Directory_ObjectNotFound
    Date: 2024-01-08T20:35:11

    ...
    ```

# [Microsoft Graph](#tab/ms-graph)

1. In the owner tenant, use the [Remove multiTenantOrganizationMember](/graph/api/multitenantorganization-delete-tenants) API to remove any member tenant. This operation takes a few minutes.

    **Request**

    ```http
    DELETE https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantIdD}
    ```

1. Use the [Get multiTenantOrganizationMember](/graph/api/multitenantorganizationmember-get) API to verify the change.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantIdD}
    ```

    If you check immediately after calling the remove API, it will show a response similar to the following.

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/tenants/$entity",
        "tenantId": "{memberTenantIdD}",
        "displayName": "Denver",
        "addedDateTime": "2023-11-20T20:56:05Z",
        "joinedDateTime": null,
        "addedByTenantId": "{ownerTenantId}",
        "role": "member",
        "state": "pending",
        "transitionDetails": {
            "desiredState": "removed",
            "desiredRole": "member",
            "status": "notStarted",
            "details": null
        }
    }
    ```

    After the remove operation completes, the response is similar to the following. This is an expected error message. It indicates that the tenant has been removed from the multitenant organization.

    **Response**

    ```http
    {
        "error": {
            "code": "Directory_ObjectNotFound",
            "message": "Unable to read the company information from the directory.",
            "innerError": {
                "date": "2023-11-20T21:09:53",
                "request-id": "75216961-c21d-49ed-8c1f-2cfe51f920f1",
                "client-request-id": "0000aaaa-11bb-cccc-dd22-eeeeee333333"
            }
        }
    }
    ```

---

## Step 6: Sign in to a member tenant

![Icon for the member tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Member tenant**

The Cairo tenant created a multitenant organization and added the Berlin and Athens tenants. In these steps, you sign in to the Berlin tenant and join the multitenant organization created by Cairo.

# [PowerShell](#tab/ms-powershell)

1. Start PowerShell.

1. Use the [Connect-MgGraph](/powershell/microsoftgraph/authentication-commands#using-connect-mggraph) command to sign in to the member tenant and consent to the following required permissions.

    - `MultiTenantOrganization.ReadWrite.All`
    - `Policy.Read.All`
    - `Policy.ReadWrite.CrossTenantAccess`
    - `Application.ReadWrite.All`
    - `Directory.ReadWrite.All`

    ```powershell
    Connect-MgGraph -TenantId $MemberTenantIdB -Scopes "MultiTenantOrganization.ReadWrite.All","Policy.Read.All","Policy.ReadWrite.CrossTenantAccess","Application.ReadWrite.All","Directory.ReadWrite.All"
    ```

# [Microsoft Graph](#tab/ms-graph)

1. Start [Microsoft Graph Explorer tool](https://aka.ms/ge).

1. Sign in to the member tenant.

1. Select your profile and then select **Consent to permissions**.

1. Consent to the following required permissions.

    - `MultiTenantOrganization.ReadWrite.All`
    - `Policy.Read.All`
    - `Policy.ReadWrite.CrossTenantAccess`
    - `Application.ReadWrite.All`
    - `Directory.ReadWrite.All`

---

## Step 7: Join the multitenant organization

![Icon for the member tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Member tenant**

# [PowerShell](#tab/ms-powershell)

1. In the member tenant, use the [Update-MgBetaTenantRelationshipMultiTenantOrganizationJoinRequest](/powershell/module/microsoft.graph.beta.identity.signins/update-mgbetatenantrelationshipmultitenantorganizationjoinrequest) command to join the multitenant organization.

    ```powershell
    Update-MgBetaTenantRelationshipMultiTenantOrganizationJoinRequest -AddedByTenantId $OwnerTenantId | Format-List
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganizationJoinRequest](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganizationjoinrequest) command to verify the join.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganizationJoinRequest | Format-List
    ```

    ```Output
    AddedByTenantId      : <OwnerTenantId>
    Id                   : <MtoJoinRequestIdB>
    MemberState          : active
    Role                 : member
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationJoinRequestTransitionDetails
    AdditionalProperties : {[@odata.context, https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/joinRequest/$entity]}
    ```

1. Use the [Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/get-mgbetatenantrelationshipmultitenantorganizationtenant) command to check the multitenant organization itself. It should reflect the join operation.

    ```powershell
    Get-MgBetaTenantRelationshipMultiTenantOrganizationTenant | Format-List
    ```

    ```Output
    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 8:05:25 PM
    DeletedDateTime      :
    DisplayName          : Berlin
    Id                   : <MtoJoinRequestIdB>
    JoinedDateTime       : 1/8/2024 9:53:55 PM
    Role                 : member
    State                : active
    TenantId             : <MemberTenantIdB>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[multiTenantOrgLabelType, none]}

    AddedByTenantId      : <OwnerTenantId>
    AddedDateTime        : 1/8/2024 7:47:45 PM
    DeletedDateTime      :
    DisplayName          : Cairo
    Id                   : <Id>
    JoinedDateTime       :
    Role                 : owner
    State                : active
    TenantId             : <OwnerTenantId>
    TransitionDetails    : Microsoft.Graph.Beta.PowerShell.Models.MicrosoftGraphMultiTenantOrganizationMemberTransitionDetails
    AdditionalProperties : {[multiTenantOrgLabelType, none]}
    ```

1. To allow for asynchronous processing, wait **up to 2 hours** before joining a multitenant organization is completed.

# [Microsoft Graph](#tab/ms-graph)

1. In the member tenant, use the [Update multiTenantOrganizationJoinRequestRecord](/graph/api/multitenantorganizationjoinrequestrecord-update) API to join the multitenant organization.

    **Request**

    ```http
    PATCH https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/joinRequest
    {
        "addedByTenantId": "{ownerTenantId}"
    }
    ```

1. Use the [Get multiTenantOrganizationJoinRequestRecord](/graph/api/multitenantorganizationjoinrequestrecord-get) API to verify the join.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/joinRequest
    ```

    This operation takes a few minutes. If you check immediately after calling the API to join, the response will be similar to the following.

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/joinRequest/$entity",
        "id": "aa87e8a4-9c88-4e67-971d-79c9e43319a3",
        "addedByTenantId": "{ownerTenantId}",
        "memberState": "pending",
        "role": null,
        "transitionDetails": {
            "desiredMemberState": "active",
            "status": "notStarted",
            "details": ""
        }
    }
    ```

    After the join operation completes, the response is similar to the following.

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/joinRequest/$entity",
        "id": "aa87e8a4-9c88-4e67-971d-79c9e43319a3",
        "addedByTenantId": "{ownerTenantId}",
        "memberState": "active",
        "role": "member",
        "transitionDetails": null
    }
    ```

1. Use the [List multiTenantOrganizationMembers](/graph/api/multitenantorganization-list-tenants) API to check the multitenant organization itself. It should reflect the join operation.

    **Request**

    ```http
    GET https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants
    ```

    **Response**

    ```http
    {
        "@odata.context": "https://graph.microsoft.com/beta/$metadata#tenantRelationships/multiTenantOrganization/tenants",
        "value": [
            {
                "tenantId": "{memberTenantIdA}",
                "displayName": "Athens",
                "addedDateTime": "2023-11-20T21:24:59Z",
                "joinedDateTime": "2023-11-21T22:09:18Z",
                "addedByTenantId": "{ownerTenantId}",
                "role": "member",
                "state": "active",
                "transitionDetails": null
            },
            {
                "tenantId": "{memberTenantIdB}",
                "displayName": "Berlin",
                "addedDateTime": "2023-11-20T21:22:35Z",
                "joinedDateTime": "2023-11-21T21:55:34Z",
                "addedByTenantId": "{ownerTenantId}",
                "role": "member",
                "state": "active",
                "transitionDetails": null
            },
            {
                "tenantId": "{ownerTenantId}",
                "displayName": "Cairo",
                "addedDateTime": "2023-11-20T20:38:20Z",
                "joinedDateTime": null,
                "addedByTenantId": "{ownerTenantId}",
                "role": "owner",
                "state": "active",
                "transitionDetails": null
            }
        ]
    }
    ```

1. To allow for asynchronous processing, wait **up to 2 hours** before joining a multitenant organization is completed.

---

## Step 8: (Optional) Leave the multitenant organization

![Icon for the member tenant.](../../media/common/icons/entra-id-purple.png)<br/>**Member tenant**

You can leave a multitenant organization that you have joined. The process for removing your own tenant from the multitenant organization is the same as the process for removing another tenant from the multitenant organization.

If your tenant is the only multitenant organization owner, you must designate a new tenant to be the multitenant organization owner. For steps, see [Step 4: (Optional) Change the role of a tenant](#step-4-optional-change-the-role-of-a-tenant).

# [PowerShell](#tab/ms-powershell)

- In the tenant, use the [Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/remove-mgbetatenantrelationshipmultitenantorganizationtenant) command to remove the tenant. This operation takes a few minutes.

    ```powershell
    Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId <MemberTenantId>
    ```

# [Microsoft Graph](#tab/ms-graph)

- In the tenant, use the [Remove multiTenantOrganizationMember](/graph/api/multitenantorganization-delete-tenants) API to remove the tenant. This operation takes a few minutes.

    **Request**

    ```http
    DELETE https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{memberTenantId}
    ```

---

## Step 9: (Optional) Delete the multitenant organization

![Icon for the owner tenant.](../../media/common/icons/entra-id.png)<br/>**Owner tenant**

You delete a multitenant organization by removing all tenants. The process for removing the final owner tenant is the same as the process for removing all other member tenants.

# [PowerShell](#tab/ms-powershell)

- In the final owner tenant, use the [Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant](/powershell/module/microsoft.graph.beta.identity.signins/remove-mgbetatenantrelationshipmultitenantorganizationtenant) command to remove the tenant. This operation takes a few minutes.

    ```powershell
    Remove-MgBetaTenantRelationshipMultiTenantOrganizationTenant -MultiTenantOrganizationMemberId $OwnerTenantId
    ```

# [Microsoft Graph](#tab/ms-graph)

- In the final owner tenant, use the [Remove multiTenantOrganizationMember](/graph/api/multitenantorganization-delete-tenants) API to remove the tenant. This operation takes a few minutes.

    **Request**

    ```http
    DELETE https://graph.microsoft.com/beta/tenantRelationships/multiTenantOrganization/tenants/{ownerTenantId}
    ```

---

## Next steps

- [Set up a multitenant org in Microsoft 365](/microsoft-365/enterprise/set-up-multi-tenant-org)
- [Synchronize users in multitenant organizations in Microsoft 365](/microsoft-365/enterprise/sync-users-multi-tenant-orgs)
- The [new Microsoft Teams desktop client](/microsoftteams/new-teams-desktop-admin)
- [Configure multitenant organization templates using the Microsoft Graph API](./multi-tenant-organization-configure-templates.md)
