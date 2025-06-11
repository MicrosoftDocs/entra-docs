---
title: Disable auto-acceleration sign-in
description: Learn how to prevent domain_hint auto-acceleration to federated IDPs using Home Realm Discovery policy.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: how-to
ms.date: 11/29/2024
ms.author: jomondi
ms.reviewer: ludwignick
zone_pivot_groups: enterprise-apps-minus-portal-aad
ms.custom: enterprise-apps, no-azure-ad-ps-ref, 
#customer intent: As an administrator managing federated domains, I want to disable auto-acceleration sign-in for certain domains and applications, so that users can always use their managed credentials and have a consistent sign-in experience, improving security and reducing frustration.
---
# Disable auto-acceleration sign-in

In this article, you learn how to disable auto-acceleration sign-in for certain domains and applications using the Home Realm Discovery (HRD) policy. With this policy configured, administrators can ensure that users always use their managed credentials, improving security and providing a consistent sign-in experience.

Home Realm Discovery (HRD) policy offers administrators multiple ways to control how and where their users authenticate. The `domainHintPolicy` section of the HRD policy is used to help migrate federated users to cloud managed credentials like [FIDO](~/identity/authentication/howto-authentication-passwordless-security-key.md), by ensuring that they always visit the Microsoft Entra sign-in page and aren't auto-accelerated to a federated IDP because of domain hints. To learn more about HRD policy, see [Home Realm Discovery](home-realm-discovery-policy.md).

This policy is needed in situations where admins can't control or update domain hints during sign-in.  For example, `outlook.com/contoso.com` sends the user to a sign-in page with the `&domain_hint=contoso.com` parameter appended, to auto-accelerate the user directly to the federated IDP for the `contoso.com` domain. Users with managed credentials sent to a federated IDP can't sign in using their managed credentials, reducing security, and frustrating users with randomized sign-in experiences. Admins rolling out managed credentials should also set up this policy to ensure that users can always use their managed credentials.

## Prerequisites

To disable auto-acceleration sign-in for an application in Microsoft Entra ID, you need:

- An Azure account with an active subscription. If you don't already have one, you can [create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.

:::zone pivot="ms-powershell"

## Configure HRD to prevent domain hints using Microsoft Graph PowerShell

Admins of federated domains should set up this section of the HRD policy in a four-phase plan. The goal of this plan is to eventually get all users in a tenant to use their managed credentials regardless of domain or application, save those apps that have hard dependencies on `domain_hint` usage. This plan helps admins find those apps, exempt them from the new policy, and continue rolling out the change to the rest of the tenant.

Pick a domain to initially roll this change out to. This domain is your test domain, so pick one that might be more receptive to changes in UX (For example, seeing a different sign-in page). The following example is configured to ignore all domain hints from all applications that use this domain name. Set this policy in your tenant-default HRD policy:

Run the Connect command to sign in to Microsoft Entra ID with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role:

```powershell
connect-MgGraph -scopes "Policy.ReadWrite.ApplicationConfiguration"
```

1. Run the following command to prevent domain hints for the test domain.

    ```powershell
    # Define the Home Realm Discovery Policy parameters  
    $params = @{
    definition = @(
        '{
            "HomeRealmDiscoveryPolicy": {
                "DomainHintPolicy": {
                    "IgnoreDomainHintForDomains": ["federated.example.edu"],
                    "RespectDomainHintForDomains": [],
                    "IgnoreDomainHintForApps": [],
                    "RespectDomainHintForApps": []
                }
            }
        }'
    )
    displayName = "Home Realm Discovery Domain Hint Exclusion Policy"
    isOrganizationDefault = $true
   }
    
    # Define the Home Realm Discovery Policy ID (ensure this is set to a valid ID)  
    $homeRealmDiscoveryPolicyId = "<Your-Policy-ID-Here>"  # Replace with your actual policy ID  
    
    # Update the policy to ignore domain hints for the specified domains  
    Update-MgPolicyHomeRealmDiscoveryPolicy -HomeRealmDiscoveryPolicyId $homeRealmDiscoveryPolicyId -BodyParameter $params  
    ```

    Ensure to Replace with the `app-client-Guid` with the actual app GUIDs and the placeholder domain value with the actual domain.

1. Gather feedback from the test domain users. Collect details for applications that broke as a result of this change - they have a dependency on domain hint usage, and should be updated. For now, add them to the `RespectDomainHintForApps` section:

    ```powershell
    # Define the Home Realm Discovery Policy parameters
    $params = @{
    definition = @(
        '{
            "HomeRealmDiscoveryPolicy": {
                "DomainHintPolicy": {
                    "IgnoreDomainHintForDomains": ["federated.example.edu"],
                    "RespectDomainHintForDomains": [],
                    "IgnoreDomainHintForApps": [],
                    "RespectDomainHintForApps": ["app1-clientID-Guid", "app2-clientID-Guid"]
                }
            }
        }'
    )
    displayName = "Home Realm Discovery Domain Hint Exclusion Policy"
    isOrganizationDefault = $true
   }
    # Define the Home Realm Discovery Policy ID (ensure this is set to a valid ID)  
    $homeRealmDiscoveryPolicyId = "<Your-Policy-ID-Here>"  # Replace with your actual policy ID  
    
    # Update the policy to ignore domain hints for the specified domains  
    Update-MgPolicyHomeRealmDiscoveryPolicy -HomeRealmDiscoveryPolicyId $homeRealmDiscoveryPolicyId -BodyParameter $params
    ```

    Ensure to Replace with the `app-client-Guid` with the actual app GUIDs and the placeholder domain value with the actual domain.
   
1. Continue expanding rollout of the policy to new domains, and collecting more feedback.

    ```powershell
    # Define the Home Realm Discovery Policy parameters  
    $params = @{
    definition = @(
        '{
            "HomeRealmDiscoveryPolicy": {
                "DomainHintPolicy": {
                    "IgnoreDomainHintForDomains": ["federated.example.edu", "otherDomain.com", "anotherDomain.com"],
                    "RespectDomainHintForDomains": [],
                    "IgnoreDomainHintForApps": [],
                    "RespectDomainHintForApps": ["app1-clientID-Guid", "app2-clientID-Guid"]
                }
            }
        }'
    )
    displayName = "Home Realm Discovery Domain Hint Exclusion Policy"
    isOrganizationDefault = $true
    }
   
    # Define the Home Realm Discovery Policy ID (ensure this is set to a valid ID)  
    $homeRealmDiscoveryPolicyId = "<Your-Policy-ID-Here>"  # Replace with your actual policy ID  

    # Update the policy to ignore domain hints for the specified domains  
    Update-MgPolicyHomeRealmDiscoveryPolicy -HomeRealmDiscoveryPolicyId $homeRealmDiscoveryPolicyId -BodyParameter $params
    ```
    
    Ensure to Replace with the `app-client-Guid` with the actual app GUIDs and the placeholder domain value with the actual domain.

1. Complete your rollout - target all domains, exempting those that should continue to be accelerated:

    ```powershell
    $params = @{
    definition = @(
        '{
            "HomeRealmDiscoveryPolicy": {
                "DomainHintPolicy": {
                    "IgnoreDomainHintForDomains": ["*"],
                    "RespectDomainHintForDomains": ["guestHandlingDomain.com"],
                    "IgnoreDomainHintForApps": [],
                    "RespectDomainHintForApps": ["app1-clientID-Guid", "app2-clientID-Guid"]
                }
            }
        }'
    )
    displayName = "Home Realm Discovery Domain Hint Exclusion Policy"
    isOrganizationDefault = $true
    }  
    
    # Define the Home Realm Discovery Policy ID (ensure this is set to a valid ID)  
    $homeRealmDiscoveryPolicyId = "<Your-Policy-ID-Here>"  # Replace with your actual policy ID  

    # Update the policy to ignore domain hints for the specified domains  
    Update-MgPolicyHomeRealmDiscoveryPolicy -HomeRealmDiscoveryPolicyId $homeRealmDiscoveryPolicyId -BodyParameter $params
    ```
    
    Ensure to Replace with the `app-client-Guid` with the actual app GUIDs and the placeholder domain value with the actual domain.

::: zone-end

::: zone pivot="ms-graph"

## Configure HRD to prevent domain hints using Microsoft Graph

Admins of federated domains should set up this section of the HRD policy in a four-phase plan. The goal of this plan is to eventually get all users in a tenant to use their managed credentials regardless of domain or application, save those apps that have hard dependencies on `domain_hint` usage. This plan helps admins find those apps, exempt them from the new policy, and continue rolling out the change to the rest of the tenant.


From the Microsoft Graph explorer window, sign in with at least the [Application Administrator](~/identity/role-based-access-control/permissions-reference.md#application-administrator) role.

Grant consent to the `Policy.ReadWrite.ApplicationConfiguration` permission.

1. Pick a domain to initially roll this change out to. This domain is your test domain, so pick one that might be more receptive to changes in UX (For example, seeing a different sign-in page). This ignores all domain hints from all applications that use this domain name. Set this policy in your tenant-default HRD policy. POST a new policy, or PATCH to update an existing policy.

    ```http
    PATCH https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{homeRealmDiscoveryPolicyId} 
        {  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"IgnoreDomainHintForDomains\":[\"testDomain.com\"],\"RespectDomainHintForDomains\":[],\"IgnoreDomainHintForApps\":[],\"RespectDomainHintForApps\":[]}}"
    ],
    "displayName": "Home Realm Discovery Domain Hint Exclusion Policy",  
    "isOrganizationDefault": true 
    }
    ```

1. Gather feedback from the test domain users. Collect details for applications that broke as a result of this change - they have a dependency on domain hint usage, and should be updated. For now, add them to the `RespectDomainHintForApps` section:

    ```http
    PATCH https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{homeRealmDiscoveryPolicyId} 
    {  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"IgnoreDomainHintForDomains\":[\"testDomain.com\"],\"RespectDomainHintForDomains\":[],\"IgnoreDomainHintForApps\":[],\"RespectDomainHintForApps\":[\"app1-clientID-Guid\",\"app2-clientID-Guid\"]}}"
    ],
    "displayName": "Home Realm Discovery Domain Hint Exclusion Policy6",  
    "isOrganizationDefault": false   
    }
    ```

1. Continue expanding rollout of the policy to new domains, and collecting more feedback.

    ```http
    PATCH https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{homeRealmDiscoveryPolicyId} 
    {  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"IgnoreDomainHintForDomains\":[\"testDomain.com\",\"otherDomain.com\",\"anotherDomain.com\"],\"RespectDomainHintForDomains\":[],\"IgnoreDomainHintForApps\":[],\"RespectDomainHintForApps\":[\"app1-clientID-Guid\",\"app2-clientID-Guid\"]}}"  
    ],  
    "displayName": "Home Realm Discovery Domain Hint Exclusion Policy",  
    "isOrganizationDefault": true  
    }
    ```

1. Complete your rollout - target all domains, exempting those domains that should continue to be accelerated:

    ```http
    PATCH https://graph.microsoft.com/v1.0/policies/homeRealmDiscoveryPolicies/{homeRealmDiscoveryPolicyId} 
    {  
    "definition": [  
        "{\"HomeRealmDiscoveryPolicy\":{\"IgnoreDomainHintForDomains\":[\"*\"],\"RespectDomainHintForDomains\":[\"guestHandlingDomain.com\"],\"IgnoreDomainHintForApps\":[],\"RespectDomainHintForApps\":[\"app1-clientID-Guid\",\"app2-clientID-Guid\"]}}"  
    ],  
    "displayName": "Home Realm Discovery Domain Hint Exclusion Policy",  
    "isOrganizationDefault": true   
    }
    ```

::: zone-end

After step 4 is complete all users, except users in `guestHandlingDomain.com`, can sign-in at the Microsoft Entra sign-in page even when domain hints would otherwise cause an auto-acceleration to a federated IDP. The exception to this setting is if the app requesting sign-in is one of the exempted ones - for those apps, all domain hints are still accepted.

## DomainHintPolicy details

The DomainHintPolicy section of the HRD policy is a JSON object that allows an admin to opt out certain domains and applications from domain hint usage. Functionally, this section tells the Microsoft Entra sign-in page to behave as if a `domain_hint` parameter on the sign-in request wasn't present.

### The Respect and Ignore policy sections

|Section | Meaning | Values |
|--------|---------|--------|
|`IgnoreDomainHintForDomains` |If this domain hint is sent in the request, ignore it. |Array of domain addresses (for example `contoso.com`). Also supports `all_domains`|
|`RespectDomainHintForDomains`| If this domain hint is sent in the request, respect it even if `IgnoreDomainHintForApps` indicates that the app in the request shouldn't auto-accelerate. This property is for slowing the rollout of deprecating domain hints within your network – you can indicate that some domains should still be accelerated. | Array of domain addresses (for example `contoso.com`). Also supports `all_domains`|
|`IgnoreDomainHintForApps`| If a request from this application comes with a domain hint, ignore it. | Array of application IDs (GUIDs). Also supports `all_apps`|
|`RespectDomainHintForApps` |If a request from this application comes with a domain hint, respect it even if `IgnoreDomainHintForDomains` includes that domain. Used to ensure some apps keep working if you discover they break without domain hints. | Array of application IDs (GUIDs). Also supports `all_apps`|

### Policy evaluation

The DomainHintPolicy logic runs on each incoming request that contains a domain hint and accelerates based on two pieces of data in the request – the domain in the domain hint, and the client ID (the app). In short - 'Respect' for a domain or app takes precedence over an instruction to "Ignore" a domain hint for a given domain or application.

- In the absence of any domain hint policy, or if none of the four sections reference the app or domain hint mentioned, [the rest of the HRD policy is evaluated](home-realm-discovery-policy.md#priority-and-evaluation-of-hrd-policies).
- If either one (or both) of `RespectDomainHintForApps` or `RespectDomainHintForDomains` section includes the app or domain hint in the request, then the user is auto-accelerated to the federated IDP as requested.
- If either one (or both) of `IgnoreDomainHintsForApps` or `IgnoreDomainHintsForDomains` references the app or the domain hint in the request, and they’re not referenced by the “Respect” sections, then the request won't be auto-accelerated, and the user remains at the Microsoft Entra sign-in page to provide a username.

Once a user enters a username at the sign-in page, they can use their managed credentials. If they choose not to use a managed credential, or they have none registered, they're taken to their federated IDP for credential entry as usual.
