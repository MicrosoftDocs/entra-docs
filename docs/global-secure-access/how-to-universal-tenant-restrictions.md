---
title: Global Secure Access and Universal Tenant Restrictions
description: Learn about how Global Secure Access helps secure access to your corporate network by restricting access to external tenants.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/21/2025
ms.author: kenwith
author: kenwith
manager: dougeby
ms.reviewer: alexpav
ai-usage: ai-assisted
ms.custom: sfi-image-nochange
---

# Turn on universal tenant restrictions

Universal tenant restrictions enhance the functionality of [tenant restrictions v2](https://aka.ms/tenant-restrictions-enforcement). They use Global Secure Access to tag all traffic no matter the operating system, browser, or device form factor. They allow support for both client and remote network connectivity.

Administrators no longer have to manage proxy server configurations or complex network configurations. They can apply tenant restrictions v2 on any platform by using the Global Secure Access client or remote networks.

When you enable universal tenant restrictions, Global Secure Access adds policy information for tenant restrictions v2 to the authentication plane's network traffic. This traffic is from Microsoft Entra ID and Microsoft Graph. As a result, users who use devices and networks in your organization must use only authorized external tenants. This restriction helps prevent data exfiltration for any application integrated with your Microsoft Entra ID tenant through single sign-on (SSO).

The following diagram shows the steps that an example organization takes to help protect against malicious users by using tenant restrictions v2.

:::image type="content" source="./media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png" alt-text="Diagram that shows how tenant restrictions v2 helps protect against malicious users." lightbox="media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png":::

| Step | Description |
| --- | --- |
| **1** | Contoso configures a tenant restrictions v2 policy in its cross-tenant access settings to block all external accounts and external apps. Contoso enforces the policy by using Global Secure Access and universal tenant restrictions. |
| **2** | A user with a Contoso-managed device tries to access a Microsoft Entra-integrated app with an unsanctioned external identity. |
| **3** | *Authentication plane protection:* With Microsoft Entra ID, Contoso's policy blocks unsanctioned external accounts from accessing external tenants. Additionally, if a Microsoft Graph token is obtained through another device and is brought into the environment within its lifetime, this token can't be replayed from the devices that have the Global Secure Access client or via remote networks. |
| **4** | *Data plane protection:* If a Microsoft Graph token is obtained through another device and is brought into the environment within its lifetime, this token can't be replayed from the devices that have the Global Secure Access client or via remote networks. |

Universal tenant restrictions help prevent data exfiltration across browsers, devices, and networks in the following ways:

- They enable Microsoft Entra ID, Microsoft accounts, and Microsoft applications to look up and enforce the associated tenant restrictions v2 policy. This lookup enables consistent policy application.
- They work with all Microsoft Entra-integrated third-party apps at the authentication plane during sign-in.
- They help protect Microsoft Graph.

## Enforcement points for universal tenant restrictions

### Authentication plane (Microsoft Entra ID)

Authentication plane enforcement happens at the time of Microsoft Entra ID or Microsoft account authentication.

When the user is connected with the Global Secure Access client or via remote network connectivity, the tenant restrictions v2 policy is checked to determine if authentication should be allowed. If the user is signing in to the organization's tenant, the tenant restrictions v2 policy is not applied. If the user is signing in to a different tenant, the policy is enforced.

Any application that's integrated with Microsoft Entra ID or that uses a Microsoft account for authentication supports universal tenant restrictions at the authentication plane.

### Data plane (Microsoft Graph)

Data plane enforcement is currently supported for Microsoft Graph. Data plane protection ensures that imported authentication artifacts can't be replayed from your organization's devices to exfiltrate data. An example of such an artifact is an access token that's obtained on another device and bypasses authentication plane enforcements defined in your tenant restrictions v2 policy.

## Prerequisites

- Administrators who interact with Global Secure Access features must have the [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) to manage those features.
- Global Secure Access requires a license. For details, see [Licensing overview](overview-what-is-global-secure-access.md#licensing-overview). If you don't already have one, you can [purchase a license or get a trial license](https://aka.ms/azureadlicense).
- You must enable a [Microsoft traffic profile](concept-microsoft-traffic-profile.md). Fully qualified domain names (FQDNs) and IP addresses of services that will have universal tenant restrictions must be set to tunnel mode.
- You must deploy [Global Secure Access clients](concept-clients.md) or configure [remote network connectivity](concept-remote-network-connectivity.md).

## Configure the tenant restrictions v2 policy

Before you can use universal tenant restrictions, you must configure both the default tenant restrictions and tenant restrictions for any specific partners.

For more information about configuring these policies, see [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2).

## Enable Global Secure Access signaling for tenant restrictions

After you create the tenant restriction v2 policies, you can use Global Secure Access to apply tagging for tenant restrictions v2. An administrator who has both the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference) and [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) roles must take the following steps to enable enforcement with Global Secure Access:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).

1. Browse to **Global Secure Access** > **Settings** > **Session Management** > **Universal Tenant Restrictions**.

1. Turn on the **Enable Tenant Restrictions for Entra ID (covering all cloud apps)** toggle.

## Try universal tenant restrictions

Tenant restrictions are not enforced when a user (or a guest user) tries to access resources in the tenant where the policies are configured. Tenant restrictions v2 policies are processed only when an identity from a different tenant attempts to sign in or accesses resources.

For example, if you configure a tenant restrictions v2 policy in the tenant contoso.com to block all organizations except fabrikam.com, the policy applies according to this table:

| User | Type | Tenant | Tenant restrictions v2 policy processed? |Authenticated access allowed? | Anonymous access allowed? |
| ---------- | ----------- | ------------ | ----------- | --------------- | ------- |
|`alice@contoso.com`| Member | contoso.com | No (same tenant) | Yes | No |
|`alice@fabrikam.com`|Member|fabrikam.com|Yes|Yes (tenant allowed by policy)|No|
|`bob@northwindtraders.com`|Member|northwindtraders.com|Yes|No (tenant not allowed by policy)|No|
|`alice@contoso.com`|Member|contoso.com|No (same tenant)|Yes|No|
|`bob_northwindtraders.com#EXT#@contoso.com`|Guest|contoso.com|No (guest user)|Yes|No|

### Validate the authentication plane protection

1. Ensure that signaling for universal tenant restrictions is turned off in Global Secure Access settings.

1. In a browser, go to the [My Apps portal](https://myapps.microsoft.com/). Sign in with the identity from a tenant that's different from yours and that isn't on the allowlist in a tenant restrictions v2 policy. You might need to use a private browser window and/or sign out of your primary account to perform this step.

   For example, if your tenant is Contoso, sign in as a Fabrikam user in the Fabrikam tenant. The Fabrikam user should be able to access the My Apps portal, because signaling for universal tenant restrictions is turned off in Global Secure Access.

1. Turn on universal tenant restrictions in the Microsoft Entra admin center. Go to **Global Secure Access** > **Session Management** > **Universal Tenant Restrictions**, and then turn on the **Enable Tenant Restrictions for Entra ID (covering all cloud apps)** toggle.

1. Sign out of the My Apps portal and restart your browser.

1. With the Global Secure Access client running, go to the [My Apps portal](https://myapps.microsoft.com/) by using the same identity (in the preceding example, the Fabrikam user in the Fabrikam tenant).

   You should be blocked from authenticating to the My Apps portal. An error message like this one should appear: "Access is blocked. The Contoso IT department has restricted which organizations can be accessed. Contact the Contoso IT department to gain access."

### Validate the data plane protection

1. Ensure that signaling in universal tenant restrictions is turned off in Global Secure Access settings.

1. In a browser, go to [Graph Explorer](https://aka.ms/ge). Sign in with the identity from a tenant that's different from yours and that isn't on the allowlist in a tenant restrictions v2 policy. To perform this step, you might need to use a private browser window and/or sign out of your primary account.

   For example, if your tenant is Contoso, sign in as a Fabrikam user in the Fabrikam tenant. The Fabrikam user should be able to access Graph Explorer, because signaling in tenant restrictions v2 is turned off in Global Secure Access.

1. Optionally, in the same browser with Graph Explorer open, open **Developer Tools** by selecting F12 on the keyboard. Start capturing the network logs.

   You should see HTTP requests returning status `200` as you interact with Graph Explorer when everything is working as expected. For example, send a `GET` request to retrieve users in your tenant.

1. Ensure that the **Preserve log** option is selected.

1. Keep the browser window open with the logs.

1. Turn on universal tenant restrictions in the Microsoft Entra admin center. Go to **Global Secure Access** > **Session Management** > **Universal Tenant Restrictions**, and then turn on the **Enable Tenant Restrictions for Entra ID (covering all cloud apps)** toggle.

1. While you're signed in as the other user (the Fabrikam user in the preceding example), new logs appear in the browser with Graph Explorer open. The process might take a few minutes. Also, the browser might refresh itself, based on the request and responses happening in the back end. If the browser doesn't refresh itself after a couple of minutes, refresh the page.

   Your access is now blocked with this message: "Access is blocked. The Contoso IT department has restricted which organizations can be accessed. Contact the Contoso IT department to gain access."

1. In the logs, look for a `Status` value of `302`. This row shows universal tenant restrictions being applied to the traffic.

   In the same response, check the headers for the following information to confirm that universal tenant restrictions were applied:

   - `Restrict-Access-Confirm: 1`
   - `x-ms-diagnostics: 2000020;reason="xms_trpid claim was not present but sec-tenant-restriction-access-policy header was in requires";error_category="insufficient_claims"`

## Known limitations

If you enabled universal tenant restrictions and you access the Microsoft Entra admin center for a tenant on the tenant restrictions v2 allowlist, you might get an "Access denied" error. To correct this error, add the following feature flag to the Microsoft Entra admin center: `?feature.msaljs=true&exp.msaljsexp=true`.

For example, assume that you work for Contoso. Fabrikam, a partner tenant, is on the allowlist. You might get the error message for the Fabrikam tenant's Microsoft Entra admin center.

If you received the "Access denied" error message for the URL `https://entra.microsoft.com/`, add the feature flag as follows: `https://entra.microsoft.com/?feature.msaljs%253Dtrue%2526exp.msaljsexp%253Dtrue#home`.

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Related content

- [Enable Global Secure Access signaling for Conditional Access](how-to-source-ip-restoration.md#enable-global-secure-access-signaling-for-conditional-access)
- [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable source IP restoration](how-to-source-ip-restoration.md)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
