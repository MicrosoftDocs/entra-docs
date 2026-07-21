---
title: Global Secure Access and Universal Tenant Restrictions
description: Learn about how Global Secure Access helps secure access to your corporate network by restricting access to external tenants.
ms.topic: how-to
ms.date: 04/03/2026
ms.reviewer: dhruvinrshah
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Turn on universal tenant restrictions

## Overview

Universal tenant restrictions enhance the functionality of [tenant restrictions v2](https://aka.ms/tenant-restrictions-enforcement). They use Global Secure Access to tag all traffic no matter the operating system, browser, or device form factor. They allow support for both client and remote network connectivity.

Administrators no longer have to manage proxy server configurations or complex network configurations. They can apply tenant restrictions v2 on any platform by using the Global Secure Access client or remote networks.

When you enable universal tenant restrictions, Global Secure Access adds policy information for tenant restrictions v2 to the authentication plane's network traffic. This traffic is from Microsoft Entra ID and Microsoft Graph. As a result, users who use devices and networks in your organization must use only authorized external tenants. This restriction helps prevent data exfiltration for any application integrated with your Microsoft Entra ID tenant through single sign-on (SSO).

The following diagram shows the steps that an example organization takes to help protect against malicious users by using tenant restrictions v2.

:::image type="content" source="./media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png" alt-text="Diagram that shows how tenant restrictions v2 helps protect against malicious users." lightbox="media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png":::

| Step | Description |
| --- | --- |
| **1** | Contoso configures a tenant restrictions v2 policy in its cross-tenant access settings to block all external accounts and external apps. Contoso enforces the policy by using Global Secure Access and universal tenant restrictions. |
| **2** | A user with a Contoso-managed device tries to access a Microsoft Entra-integrated app with an unsanctioned external identity. |
| **3** | *Authentication plane protection:* With Microsoft Entra ID, Contoso's policy blocks unsanctioned external accounts from accessing external tenants. Additionally, if a Microsoft Graph token is obtained through another device and is brought into the environment within its lifetime, this token can't be replayed from the devices that have the Global Secure Access client or through remote networks. |
| **4** | *Data plane protection:* If a Microsoft Graph token is obtained through another device and is brought into the environment within its lifetime, this token can't be replayed from the devices that have the Global Secure Access client or through remote networks. |

Universal tenant restrictions help prevent data exfiltration across browsers, devices, and networks in the following ways:

- They enable Microsoft Entra ID, Microsoft accounts, and Microsoft applications to look up and enforce the associated tenant restrictions v2 policy. This lookup enables consistent policy application.
- They work with all Microsoft Entra-integrated third-party apps at the authentication plane during sign-in.
- They help protect Microsoft Graph.

## Supported scenarios

### Microsoft Entra ID

Enforcement of tenant restrictions happens at the time of Microsoft Entra ID or Microsoft account authentication. When the user is connected with the Global Secure Access client or via remote network connectivity, the tenant restrictions v2 policy is checked to determine if authentication should be allowed. If the user is signing in to the organization's tenant, the tenant restrictions v2 policy isn't applied. If the user is signing in to a different tenant, the policy is enforced. This works for any application that uses the Entra ID (Work/School account) or Microsoft Account as its identity provider.

### Microsoft Graph

Tenant restrictions for Microsoft Graph ensures that tokens obtained on other devices can't be replayed from your organization's devices to exfiltrate data. If the malicious user signs in to their own tenant from their personal computer while connected to the public internet, extracts the access token for Microsoft Graph, and copies this token to their work device, tenant restrictions will block access with that token, since the token was not acquired from a trusted GSA network.

## Prerequisites

- Administrators who interact with Global Secure Access features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) to manage those features.
- Global Secure Access requires a license. For details, see [Licensing overview](overview-what-is-global-secure-access.md#licensing-overview). If you don't already have one, you can [purchase a license or get a trial license](https://aka.ms/azureadlicense).
- You must enable a [Microsoft traffic profile](concept-microsoft-traffic-profile.md). Fully qualified domain names (FQDNs) and IP addresses of services that have universal tenant restrictions must be set to tunnel mode.
- You must deploy [Global Secure Access clients](concept-clients.md) or configure [remote network connectivity](concept-remote-network-connectivity.md).

## Configure the tenant restrictions v2 policy

Before you can use universal tenant restrictions, you must configure both the default tenant restrictions and tenant restrictions for any specific partners.

For more information about configuring these policies, see [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2).

## Enable Universal Tenant Restrictions

After you create the tenant restriction v2 policies, you can use Global Secure Access to apply tagging for tenant restrictions v2. An administrator who has both the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference) and [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) roles must take the following steps to enable enforcement with Global Secure Access:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).

1. Go to **Global Secure Access** > **Settings** > **Session Management**.

1. On the **Universal Tenant Restrictions** tab, turn on the **Enable Tenant Restrictions for Microsoft Entra ID and Microsoft Graph** toggle.

## Try universal tenant restrictions

Tenant restrictions aren't enforced when a user (or a guest user) tries to access resources in the tenant where the policies are configured. Tenant restrictions v2 policies are processed only when an identity from a different tenant attempts to sign in or accesses resources.

For example, if you configure a tenant restrictions v2 policy in the tenant contoso.com to block all organizations except fabrikam.com, the policy applies according to this table:

| User | Type | Tenant | Tenant restrictions v2 policy processed? |Authenticated access allowed? |
| ---------- | ----------- | ------------ | ----------- | --------------- |
|`alice@contoso.com`| Member | contoso.com | No (same tenant) | Yes |
|`alice@fabrikam.com`|Member|fabrikam.com|Yes|Yes (tenant allowed by policy)|
|`bob@northwindtraders.com`|Member|northwindtraders.com|Yes|No (tenant not allowed by policy)|
|`bob_northwindtraders.com#EXT#@contoso.com`|Guest|contoso.com|No (guest user)|Yes|

### Validate tenant restrictions enforcement

1. Turn on universal tenant restrictions in the Microsoft Entra Admin Center. 
    1. Go to **Global Secure Access** > **Settings** > **Session Management**.
    1. On the **Universal Tenant Restrictions** tab, turn on the **Enable Tenant Restrictions for Microsoft Entra ID and Microsoft Graph** toggle.

1. Sign out of the My Apps portal and restart your browser.

1. With the Global Secure Access client enabled and connected, go to the [My Apps portal](https://myapps.microsoft.com/) by using the same identity (in the preceding example, the Fabrikam user in the Fabrikam tenant).

   You're blocked from authenticating to the My Apps portal. An error message like this one appears: "Access is blocked. The Contoso IT department has restricted which organizations can be accessed. Contact the Contoso IT department to gain access."

## Known limitations

If you enabled universal tenant restrictions and you access the Microsoft Entra admin center for a tenant on the tenant restrictions v2 allow list, you might get an "Access denied" error. To correct this error, add the following feature flag to the Microsoft Entra admin center: `?feature.msaljs=true&exp.msaljsexp=true`.

For example, assume that you work for Contoso. Fabrikam, a partner tenant, is on the allow list. You might get the error message for the Fabrikam tenant's Microsoft Entra admin center.

If you received the "Access denied" error message for the URL `https://entra.microsoft.com/`, add the feature flag as follows: `https://entra.microsoft.com/?feature.msaljs%253Dtrue%2526exp.msaljsexp%253Dtrue#home`.

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Related content

- [Enable Global Secure Access signaling for Microsoft Entra ID and Microsoft Graph](how-to-source-ip-restoration.md#enable-global-secure-access-signaling-for-microsoft-entra-id-and-microsoft-graph)
- [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable source IP restoration](how-to-source-ip-restoration.md)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
