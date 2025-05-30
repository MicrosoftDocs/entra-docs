---
title: Home Realm Discovery policy for an application
description: Learn how to manage Home Realm Discovery policy for Microsoft Entra authentication for federated users, including auto-acceleration and domain hints.
author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps
ms.topic: concept-article
ms.date: 11/26/2024
ms.author: jomondi
ms.reviewer: sreyanth, ludwignick
ms.custom: enterprise-apps, no-azure-ad-ps-ref sfi-ropc-nochange
#customer intent: As an IT admin, I want to understand how to configure Home Realm Discovery (HRD) policies, so that I can control the sign-in behavior for an application and ensure a streamlined authentication experience for users.
---
# Home Realm Discovery for an Application  

Home Realm Discovery (HRD) enables Microsoft Entra ID to identify the appropriate identity provider (IDP) for user authentication during sign-in. When users sign in to a Microsoft Entra tenant to access a resource or the common sign-in page, they enter a user name (UPN). Microsoft Entra ID uses this information to determine the correct sign-in location.  

Users are directed to one of the following identity providers for authentication:  

- The user's home tenant (which might be the same as the resource tenant).  
- Microsoft account, if the user is a guest in the resource tenant using a consumer account.  
- An on-premises identity provider like Active Directory Federation Services (ADFS).  
- Another identity provider federated with the Microsoft Entra tenant.  

## Auto-acceleration  

Organizations might configure domains in their Microsoft Entra tenant to federate with another IdP, such as ADFS, for user authentication. When users sign in to an application, they initially see a Microsoft Entra sign-in page. If they belong to a federated domain, they're redirected to the IdP's sign-in page for that domain. Administrators might want to bypass the initial Microsoft Entra ID page for specific applications, a process known as "sign-in auto-acceleration."  

Microsoft advises against configuring auto-acceleration as it can hinder stronger authentication methods like FIDO and collaboration. For more information, see [Enable passwordless security key sign-in](~/identity/authentication/howto-authentication-passwordless-security-key.md). To learn how to prevent sign-in auto-acceleration, see [Disable auto-acceleration sign-in](prevent-domain-hints-with-home-realm-discovery.md).  

Auto-acceleration can streamline sign-in for tenants federated with another IdP. You can configure it for individual applications. To learn how to force auto-acceleration using HRD, See [Configure auto-acceleration](configure-authentication-for-federated-users-portal.md).

> [!NOTE]  
> Configuring an application for auto-acceleration prevents users from using managed credentials (like FIDO) and guest users from signing in. Directing users to a federated IdP for authentication bypasses the Microsoft Entra sign-in page, preventing guest users from accessing other tenants or external IdPs like Microsoft accounts.  

Control auto-acceleration to a federated IdP in three ways:  

- Use a domain hint on authentication requests for an application.  
- Configure an HRD policy to [force auto-acceleration](configure-authentication-for-federated-users-portal.md).  
- Configure an HRD policy to [ignore domain hints](prevent-domain-hints-with-home-realm-discovery.md) for specific applications or domains.  

## Domain Confirmation Dialog  

Starting April 2023, organizations using auto-acceleration or smart links might encounter a new screen in the sign-in UI, called the Domain Confirmation Dialog. This screen is part of Microsoft's security hardening efforts and requires users to confirm the domain of the tenant they're signing into.  

### What You Need to Do  

When you see the Domain Confirmation Dialog:  

- **Check the domain**: Verify the domain name on the screen matches the organization you intend to sign in to, such as `contoso.com`.  
  - **If you recognize the domain**, select **Confirm** to proceed.  
  - **If you don't recognize the domain**, cancel the sign-in process and contact your IT Admin for assistance.  

### Components of the Domain Confirmation Dialog  

The following screenshot shows an example of what the domain confirmation dialog could look like for you:

:::image type="content" source="media/home-realm-discovery-policy/domain-confirmation-dialog-new.png" alt-text="Screenshot of the domain confirmation dialog listing the sign-in identifier '<kelly@contoso.com>' with a tenant domain of 'contoso.com'.":::

The identifier at the top of the dialog, `kelly@contoso.com`, represents the identifier used to sign-in. The tenant domain listed in the dialog's header and subheader shows the domain of the account's home tenant.

This dialog might not appear for every instance of auto-acceleration or smart links. Frequent domain confirmation dialogs might occur if your organization clears cookies due to browser policies. The Domain Confirmation Dialog shouldn't cause application breakages as Microsoft Entra ID manages the auto-acceleration sign-in flow.  

## Domain Hints  

Domain hints are directives in authentication requests from applications that can accelerate users to their federated IdP sign-in page. Multitenant applications can use them to direct users to the branded Microsoft Entra sign-in page for their tenant.  

For example, "largeapp.com" might allow access via a custom URL "contoso.largeapp.com" and include a domain hint to contoso.com in the authentication request.  

Domain hint syntax varies by protocol:  

- **WS-Federation**: `whr` query string parameter, for example, `whr=contoso.com`.  
- **SAML**: SAML authentication request with a domain hint or `whr=contoso.com`.  
- **OpenID Connect**: `domain_hint` query string parameter, for example, `domain_hint=contoso.com`.  

Microsoft Entra ID redirects sign-in to the configured IDP for a domain if **both** of the following cases are true:  

- A domain hint is included in the authentication request.  
- The tenant is federated with that domain.  

If the domain hint doesn't refer to a verified federated domain, it can be ignored.  

> [!NOTE]  
> A domain hint in an authentication request overrides auto-acceleration set for the application in HRD policy.  

### HRD Policy for Auto-acceleration  

Some applications don't allow configuration of authentication requests. In such cases, it's not possible to use domain hints to control auto-acceleration. Use [Home Realm Discovery](configure-authentication-for-federated-users-portal.md) policy to configure auto-acceleration.  

### HRD Policy to Prevent Auto-acceleration  

Some Microsoft and SaaS applications automatically include domain hints, which can disrupt managed credential rollouts like FIDO. Use [Home Realm Discovery policy to ignore domain hints](prevent-domain-hints-with-home-realm-discovery.md) from certain apps or domains during managed credential rollouts.  

## Enable direct ROPC authentication of federated users for legacy applications  

Best practice is for applications to use Microsoft Entra libraries and interactive sign-in for user authentication. Legacy applications using Resource Owner Password Credentials (ROPC) grants might submit credentials directly to Microsoft Entra ID without understanding federation. They don't perform HRD or interact with the correct federated endpoint. You can use [Home Realm Discovery policy to enable specific legacy applications](configure-authentication-for-federated-users-portal.md) to authenticate directly with Microsoft Entra ID. This option works, provided Password Hash Sync is enabled. 

> [!IMPORTANT]  
> Only enable direct authentication if Password Hash Sync is active and it's acceptable to authenticate the application without on-premises IdP policies. If Password Hash Sync or Directory Synchronization with AD Connect is disabled, remove this policy to prevent direct authentication with stale password hashes.  

## Set HRD Policy  

To set an HRD policy on an application for federated sign-in auto-acceleration or direct cloud-based applications:  

- Create an HRD policy.  
- Locate the service principal to attach the policy.  
- Attach the policy to the service principal.  

Policies take effect for a specific application when attached to a service principal. Only one HRD policy can be active on a service principal at a time. Use [Microsoft Graph PowerShell](/powershell/microsoftgraph/overview) cmdlets to create and manage HRD policy.  

Example HRD policy definition:  

```json  
{  
  "HomeRealmDiscoveryPolicy": {  
    "AccelerateToFederatedDomain": true,  
    "PreferredDomain": "federated.example.edu",  
    "AllowCloudPasswordValidation": false  
  }  
}  
```  

- **AccelerateToFederatedDomain**: Optional. If false, the policy doesn't affect auto-acceleration. If true and there's one verified federated domain, users are directed to the federated IdP. If multiple domains exist, specify **PreferredDomain**.  
- **PreferredDomain**: Optional. Indicates a domain for acceleration. Omit if only one federated domain exists. If omitted with multiple domains, the policy has no effect.  
- **AllowCloudPasswordValidation**: Optional. If true, allows federated user authentication via username/password credentials directly to Microsoft Entra token endpoint, requiring Password Hash Sync.  

Additional tenant-level HRD options:  

- **AlternateIdLogin**: Optional. Enables [AlternateLoginID](~/identity/authentication/howto-authentication-use-email-signin.md) for email sign-in instead of UPN at the Microsoft Entra sign-in page. Relies on users not being auto-accelerated to a federated IDP.  
- **DomainHintPolicy**: Optional complex object that [prevents domain hints from auto-accelerating users](prevent-domain-hints-with-home-realm-discovery.md) to federated domains. Ensures applications sending domain hints don't prevent cloud-managed credential sign-ins.  

### Priority and Evaluation of HRD Policies  

HRD policies can be assigned to organizations and service principals, allowing multiple policies to apply to an application. Microsoft Entra ID determines precedence using these rules:  

- If a domain hint is present, the tenant's HRD policy checks if domain hints should be ignored. If allowed, the domain hint behavior is used.  
- If a policy is explicitly assigned to the service principal, it's enforced.  
- If no domain hint or service principal policy exists, a policy assigned to the parent organization is enforced.  
- If no domain hint or policies are assigned, default HRD behavior applies.  

## Next Steps

- [Configure sign-in behavior for an application using a Home Realm Discovery policy](configure-authentication-for-federated-users-portal.md)
- [Disable auto-acceleration to a federated IDP during user sign-in with Home Realm Discovery policy](prevent-domain-hints-with-home-realm-discovery.md)
