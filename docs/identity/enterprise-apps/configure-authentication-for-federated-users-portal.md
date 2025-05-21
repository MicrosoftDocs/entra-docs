---
title: Configure sign-in auto-acceleration
description: Learn how to force federated IdP auto-acceleration for an application using Home Realm Discovery policy.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 11/29/2024
ms.author: jomondi
ms.reviewer: ludwignick
ms.collection: M365-identity-device-management
zone_pivot_groups: enterprise-apps-minus-portal-aad
ms.custom: enterprise-apps, no-azure-ad-ps-ref, sfi-ropc-nochange
#customer intent: As an IT admin configuring sign-in behavior for federated users in Microsoft Entra ID, I want to understand how to use Home Realm Discovery (HRD) policy to enable auto-acceleration sign-in and direct username/password authentication, so that I can streamline the sign-in process for specific applications and improve user experience.
---

# Configure sign-in auto-acceleration

This article provides an introduction to configuring Microsoft Entra authentication behavior for federated users using Home Realm Discovery (HRD) policy. It covers using auto-acceleration sign-in to skip the username entry screen and automatically forward users to federated sign-in endpoints. To learn more about HRD policy, check out the [Home Realm Discovery](home-realm-discovery-policy.md) article.


## Prerequisites

To configure HRD policy for an application in Microsoft Entra ID, you need:

- An Azure account with an active subscription. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- The Application Administrator role

## Auto-acceleration sign-in

Some organizations configure domains in their Microsoft Entra tenant to federate with another identity provider (IDP), such as Active Directory Federation Services (ADFS) for user authentication. When a user signs into an application, they're first presented with a Microsoft Entra sign-in page. After they type their User Principal Name (UPN), if they are in a federated domain they're then taken to the sign-in page of the IDP serving that domain. Under certain circumstances, administrators might want to direct users to the sign-in page when they're signing in to specific applications. As a result users can skip the initial Microsoft Entra ID page. This process is referred to as "sign-in auto-acceleration."

For federated users with cloud-enabled credentials, such as Short Message Service (SMS) sign-in or FIDO keys, you should prevent sign-in auto-acceleration. See [Disable auto-acceleration sign-in](prevent-domain-hints-with-home-realm-discovery.md) to learn how to prevent domain hints with HRD.

> [!IMPORTANT]
> Starting April 2023, organizations who use auto-acceleration or smartlinks might begin to see a new screen added to the sign-in UI. This screen, termed the Domain Confirmation Dialog, is part of Microsoft's general commitment to security hardening and requires the user to confirm the domain of the tenant in which they are signing in to. If you see the Domain Confirmation Dialog and do not recognize the tenant domain listed, you should cancel the authentication flow and contact your IT Admin.
>
> For more information, please visit [Domain Confirmation Dialog](home-realm-discovery-policy.md#domain-confirmation-dialog).

:::zone pivot="ms-powershell"

## Set up an HRD policy using Microsoft Graph PowerShell

We use Microsoft Graph PowerShell cmdlets to walk through a few scenarios, including:

- Setting up HRD policy to do auto-acceleration for an application in a tenant with a single federated domain.
- Setting up HRD policy to do auto-acceleration  for an application to one of several domains that are verified for your tenant.
- Setting up HRD policy to enable a legacy application to do direct username/password authentication to Microsoft Entra ID for a federated user.
- Listing the applications for which a policy is configured.

In the following examples, you create, update, link, and delete HRD policies on application service principals in Microsoft Entra ID.

1. Before you begin, run the Connect command to sign in to Microsoft Entra ID with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role:

    ```powershell
    connect-MgGraph -scopes "Policy.Read.All"
    ```

1. Run the following command to see all the policies in your organization:

    ```powershell
    Get-MgPolicyHomeRealmDiscoveryPolicy -Property Id, displayName
    ```
If nothing is returned, it means you have no policies created in your tenant.

### Create an HRD policy using Microsoft Graph PowerShell

In this example, you create a policy such that when you assign it to an application, it either:

- Auto-accelerates users to a federated identity provider sign-in screen when they're signing in to an application when there's a single domain in your tenant.
- Auto-accelerates users to a federated identity provider sign-in screen if there's more than one federated domain in your tenant.
- Enables non-interactive username/password sign-in directly to Microsoft Entra ID for federated users for the applications the policy is assigned to.

The following policy auto-accelerates users to a federated identity provider sign-in screen when they're signing in to an application when there's a single domain in your tenant.

1. Run the Connect command to sign in to Microsoft Entra ID with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role:

    ```powershell
    connect-MgGraph -scopes "Policy.ReadWrite.ApplicationConfiguration"

1. Run the following command to create a new HRD policy:

    ```powershell
    # Define the parameters for the policy 
    $params = @{
        definition = @(
        '{"HomeRealmDiscoveryPolicy":{
        "AccelerateToFederatedDomain":true,
        }
    }'
    )
    displayName = "BasicAutoAccelerationPolicy"
    isOrganizationDefault = $true
    } 
    # Create a new Home Realm Discovery Policy
    New-MgPolicyHomeRealmDiscoveryPolicy -BodyParameter $params 
    ```

The following policy auto-accelerates users to a federated identity provider sign-in screen when there's more than one federated domain in your tenant. If you have more than one federated domain that authenticates users for applications, you need to specify the domain to auto-accelerate.

```powershell
connect-MgGraph -scopes "Policy.ReadWrite.ApplicationConfiguration"

# Define the parameters for the New-MgPolicyHomeRealmDiscoveryPolicy cmdlet
$params = @{
	definition = @(
	'{"HomeRealmDiscoveryPolicy":{
	"AccelerateToFederatedDomain":true,
	"PreferredDomain":"federated.example.edu"
	}}'
)
displayName = "MultiDomainAutoAccelerationPolicy"
isOrganizationDefault = $true

}

# Create the new policy
New-MgPolicyHomeRealmDiscoveryPolicy -BodyParameter $params
```

The following policy enables username/password authentication for federated users directly with Microsoft Entra ID for specific applications:

```powershell

connect-MgGraph -scopes "Policy.ReadWrite.ApplicationConfiguration"

# Define the parameters for the New-MgPolicyHomeRealmDiscoveryPolicy cmdlet  
$params = @{
	definition = @(
	'{"HomeRealmDiscoveryPolicy":{
	 "AllowCloudPasswordValidation":true
     }
   }'
)
displayName = "EnableDirectAuthPolicy"
}

New-MgPolicyHomeRealmDiscoveryPolicy -BodyParameter $params  
```

To see your new policy and get its **ObjectID**, run the following command:

```powershell
    Get-MgPolicyHomeRealmDiscoveryPolicy -Property Id, displayName
```

To apply the HRD policy after creating it, you can assign it to multiple service principals.

### Locate the service principal to assign the policy using Microsoft Graph PowerShell

You need the **ObjectID** of the service principals to which you want to assign the policy. There are several ways to find the **ObjectID** of service principals.

You can use the [Microsoft Entra admin center](https://entra.microsoft.com). Using this option:

1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results. Copy the Object ID of the application.

Because you're using Microsoft Graph PowerShell, run the following cmdlet to list the service principals and their IDs.

```powershell
connect-MgGraph -scopes "Application.Read.All"
Get-MgServicePrincipal
```

### Assign the policy to your service principal using Microsoft Graph PowerShell

After you have the **ObjectID** of the service principal of the application for which you want to configure auto-acceleration, run the following command. This command associates the HRD policy that you created with the service principal that you located in the previous sections.

```powershell
    connect-MgGraph -scopes "Policy.ReadWrite.ApplicationConfiguration", "Application.ReadWrite.All"

# Define the parameters for the New-MgServicePrincipalHomeRealmDiscoveryPolicy cmdlet  
$assignParams = @{
	"@odata.id" = "https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/<policyId>"
}

New-MgServicePrincipalHomeRealmDiscoveryPolicyByRef -ServicePrincipalId $servicePrincipalId -BodyParameter $assignParams
```

You can repeat this command for each service principal to which you want to add the policy.

In the case where an application already has a Home Realm Discovery policy assigned, you can't add a second one. In that case, change the definition of the HRD policy that is assigned to the application to add extra parameters.

### Check which service principals your HRD policy is assigned to using Microsoft Graph PowerShell

Run the following command to list the service principals to which the policy is assigned:

```powershell
Get-MgPolicyHomeRealmDiscoveryPolicyApplyTo -HomeRealmDiscoveryPolicyId "<ObjectId of the Policy>"
 # Replace with the actual ObjectId of the Policy 
```

Ensure you test the sign-in experience for the application to check that the new policy is working.

:::zone-end

:::zone pivot="ms-graph"

## Set up an HRD policy using Microsoft Graph

We use Microsoft Graph API calls to walk through a few scenarios, including:

- Setting up HRD policy to do auto-acceleration for an application in a tenant with a single federated domain.

- Setting up HRD policy to do auto-acceleration  for an application to one of several domains that are verified for your tenant.

- Setting up HRD policy to enable a legacy application to do direct username/password authentication to Microsoft Entra ID for a federated user.

- Listing the applications for which a policy is configured.

In the following examples, you create, update, link, and delete HRD policies on application service principals in Microsoft Entra ID.

1. Before you begin, access the Microsoft Graph explorer window.

1. Sign in with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role.
1. Grant consent to the `Policy.Read.All` permission.
1. Run the following API call to see all the policies in your organization:

    ```http
    GET https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies
    ```
If nothing is returned, it means you have no policies created in your tenant.

### Create an HRD policy using Microsoft Graph

In this example, you create a policy such that when you assign it to an application, it either:

- Auto-accelerates users to a federated identity provider sign-in screen when they're signing in to an application when there's a single domain in your tenant.
- Auto-accelerates users to a federated identity provider sign-in screen if there's more than one federated domain in your tenant.
- Enables non-interactive username/password sign-in directly to Microsoft Entra ID for federated users for the applications the policy is assigned to.

The following policy auto-accelerates users to a federated identity provider sign-in screen when they're signing in to an application when there's a single domain in your tenant.

From the Microsoft Graph explorer window:

1. Sign in with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role.
1. Grant consent to the `Policy.ReadWrite.ApplicationConfiguration` permission.
1. POST the new policy, or PATCH to update an existing policy.

    ```http
    POST https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies  
    
    {  
        "definition": [  
            "{\"HomeRealmDiscoveryPolicy\":{\"AccelerateToFederatedDomain\":true}}"  
        ],  
        "displayName": "BasicAutoAccelerationPolicy",
        "isOrganizationDefault": true 
    } 
    ```

The following policy auto-accelerates users to a federated identity provider sign-in screen when there's more than one federated domain in your tenant. If you have more than one federated domain that authenticates users for applications, you need to specify the domain to auto-accelerate.

```http
POST https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies  
  
{  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"AccelerateToFederatedDomain\":true,\"PreferredDomain\":\"federated.example.edu\"}}"  
    ],  
    "displayName": "MultiDomainAutoAccelerationPolicy",
    "isOrganizationDefault": true 
 
}
```

The following policy enables username/password authentication for federated users directly with Microsoft Entra ID for specific applications:

```http
POST https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies  
  
{  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"AllowCloudPasswordValidation\":true}}"  
    ],  
    "displayName": "EnableDirectAuthPolicy"  
}  
```

To see your new policy and get its **ObjectID**, run the following API call:

```http
    GET https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies
```

To apply the HRD policy after creating it, you can assign it to multiple service principals.

### Locate the service principal to assign the policy using Microsoft Graph

You need the **ObjectID** of the service principals to which you want to assign the policy. There are several ways to find the **ObjectID** of service principals.

You can use the [Microsoft Entra admin center](https://entra.microsoft.com). Using this option:

1. Browse to **Entra ID** > **Enterprise apps** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results. Copy the Object ID of the application.

   Because you're using Microsoft Graph explorer, run the following request to list the service principals and their IDs.

    ```http
    GET https://graph.microsoft.com/v1.0/servicePrincipals  
    ```

### Assign the policy to your service principal using Microsoft Graph

After you have the **ObjectID** of the service principal of the application for which you want to configure auto-acceleration, run the following API cal. This API call associates the HRD policy that you created with the service principal that you located in the previous sections.

Ensure you consent to the `Application.ReadWrite.All` permission.

```http
POST https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipalId}/homeRealmDiscoveryPolicies/$ref  
  
{  
    "@odata.id": "https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{policyId}"  
}  
```

You can repeat this API call for each service principal to which you want to add the policy.

In the case where an application already has a Home Realm Discovery policy assigned, you can't add a second one. In that case, change the definition of the HRD policy that is assigned to the application to add extra parameters.

### Check which service principals your HRD policy is assigned to using Microsoft Graph

Run the following API call to list the service principals to which the policy is assigned:

```http
GET https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{policyId}/appliesTo  
```

Ensure you test the sign-in experience for the application to check that the new policy is working.

:::zone-end

:::zone pivot="ms-powershell"

## Remove an HRD policy from an application using Microsoft Graph PowerShell

1. Get the ObjectID of the policy.

   Use the previous example for getting the **ObjectID** of the policy, and that of the application service principal from which you want to remove it.

1. Remove the policy assignment from the application service principal.

    ```powershell
    Remove-MgServicePrincipalHomeRealmDiscoveryPolicyHomeRealmDiscoveryPolicyByRef -ServicePrincipalId $servicePrincipalId -HomeRealmDiscoveryPolicyId $homeRealmDiscoveryPolicyId
    ```

1. Check removal by listing the service principals to which the policy is assigned.

    ```powershell
    Get-MgPolicyHomeRealmDiscoveryPolicyApplyTo -HomeRealmDiscoveryPolicyId "<ObjectId of the Policy>"
    # Replace with the actual ObjectId of the Policy 
    ```

### Delete the HRD policy using Microsoft Graph PowerShell

To  delete the HRD policy you created, run the following command:

```powershell
    Remove-MgPolicyHomeRealmDiscoveryPolicy -HomeRealmDiscoveryPolicyId "<ObjectId of the Policy>" # Replace with the actual ObjectId of the Policy
```

:::zone-end

:::zone pivot="ms-graph"

## Remove an HRD policy from an application using Microsoft Graph

1. Get the ObjectID of the policy.

   Use the previous example for getting the **ObjectID** of the policy, and that of the application service principal from which you want to remove it.

1. Remove the policy assignment from the application service principal.

    ```http
    DELETE https://graph.microsoft.com/v1.0/servicePrincipals/{servicePrincipalId}/homeRealmDiscoveryPolicies/{policyId}/$ref
    ```

1. Check removal by listing the service principals to which the policy is assigned.

    ```http
    GET https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/<policyId>/appliesTo  
    ```

### Delete the HRD policy using Microsoft Graph

To  delete the HRD policy you created, run the following API call:

```http
DELETE https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{id}
```

:::zone-end
