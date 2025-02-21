---
title: Global Secure Access and Universal Tenant Restrictions
description: Learn about how Global Secure Access secures access to your corporate network by restricting access to external tenants.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 12/23/2024
ms.author: kenwith
author: kenwith
manager: rkarlin
ms.reviewer: alexpav
---
# Universal tenant restrictions

Universal tenant restrictions enhance the functionality of [tenant restriction v2](https://aka.ms/tenant-restrictions-enforcement) using Global Secure Access to tag all traffic no matter the operating system, browser, or device form factor. It allows support for both client and remote network connectivity. Administrators no longer have to manage proxy server configurations or complex network configurations.

Universal Tenant Restrictions does this enforcement using Global Secure Access based policy signaling for both the authentication plane (Generally Available) and data plane (Preview). Tenant restrictions v2 enables enterprises to prevent data exfiltration by users using external tenant identities for Microsoft Entra integrated applications like Microsoft Graph, SharePoint Online, and Exchange Online. These technologies work together to prevent data exfiltration universally across all devices and networks.

:::image type="content" source="media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png" alt-text="Diagram showing how tenant restrictions v2 protects against malicious users." lightbox="media/how-to-universal-tenant-restrictions/tenant-restrictions-v-2-universal-tenant-restrictions-flow.png":::

The following table explains the steps taken at each point in the previous diagram.

| Step | Description |
| --- | --- |
| **1** | Contoso configures a **tenant restrictions v2 ** policy in their cross-tenant access settings to block all external accounts and external apps. Contoso enforces the policy using Global Secure Access universal tenant restrictions. |
| **2** | A user with a Contoso-managed device tries to access a Microsoft Entra integrated app with an unsanctioned external identity. |
| **3** | *Authentication plane protection:* Using Microsoft Entra ID, Contoso's policy blocks unsanctioned external accounts from accessing external tenants. | 
| **4** | *Data plane protection:* If the user again tries to access an external unsanctioned application by copying an authentication response token they obtained outside of Contoso's network and pasting it into the device, they're blocked. The token mismatch triggers reauthentication and blocks access. For SharePoint Online, any attempt at anonymously accessing resources will be blocked. For Teams, attempts to join meetings anonymously will be denied.| 

Universal tenant restrictions help to prevent data exfiltration across browsers, devices, and networks in the following ways:

- It enables Microsoft Entra ID, Microsoft Accounts, and Microsoft applications to look up and enforce the associated tenant restrictions v2 policy. This lookup enables consistent policy application. 
- Works with all Microsoft Entra integrated third-party apps at the auth plane during sign in.
- Works with Exchange, SharePoint/OneDrive, Teams, and Microsoft Graph for data plane protection (Preview)

## Universal Tenant Restrictions enforcement points
### Authentication Plane
Authentication plane enforcement happens at the time of Entra ID or Microsoft Account authentication. When the user is connected with the Global Secure Access client or via Remote Network connectivity, Tenant Restrictions v2 policy is checked to determine if authentication should be allowed. If the user is signing in to the tenant of their organization, tenant restrictions policy is not applied. If the user is signing in to a different tenant, policy is enforced. Any application that is integrated with Entra ID or uses Microsoft Account for authentication supports Universal Tenant Restrictions at the authentication plane.

## Data Plane (Preview)
Data plane enforcement is done by the resource provider (a Microsoft service that supports tenant restrictions) at the time that the data is accessed. Data plane protection ensures that imported authentication artifacts (for example, an access token obtained on another device, bypassing authentication plane enforcements defined in your Tenant Restrictions v2 policy) cannot be replayed from your organization's devices to exfiltrate data. Additionally, data plane protection prevents the user of anonymous access links in SharePoint/OneDrive for Business, and prevents the users from joining Teams meetings anonymously.

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   * The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
* The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
* [Microsoft traffic profile](concept-microsoft-traffic-profile.md) must be enabled and FQDNs/IP addresses of services that will have Universal Tenant Restrictions are set to 'Tunnel' mode.
* [Global Secure Access clients](concept-clients.md) are deployed or [Remote Network connectivity](concept-remote-network-connectivity.md) is configured.

## Configure Tenant Restrictions v2 policy 

Before an organization can use universal tenant restrictions, they must configure both the default tenant restrictions and tenant restrictions for any specific partners.

For more information to configure these policies, see the article [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2).

## Enable Global Secure Access signaling for Tenant Restrictions

Once you have created the tenant restriction v2 policies, you can utilize Global Secure Access to apply tagging for tenant restrictions v2. An administrator with both the [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference) and [Security Administrator](/azure/active-directory/roles/permissions-reference#security-administrator) roles must take the following steps to enable enforcement with Global Secure Access.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session Management** > **Universal Tenant Restrictions**.
1. Select the toggle to **Enable Tenant Restrictions for Entra ID (covering all cloud apps)**.

## Try Universal Tenant Restrictions
Tenant restrictions are not enforced when a user (or a guest user) tries to access resources in the tenant where the policies are configured. Tenant Restrictions v2 policies are processed only when an identity from a different tenant attempts to signs in and/or accesses resources. For example, if you configure a Tenant Restrictions v2 policy in the tenant `contoso.com` to block all organizations except `fabrikam.com`, the policy will apply according to this table:

| User | Type | Tenant | TRv2 policy processed? |Authenticated access allowed? | Anonymous access allowed? |
| ---------- | ----------- | ------------ | ----------- | --------------- | ------- |
|`alice@contoso.com`| Member | contoso.com | No(same tenant) | Yes | No |
|`alice@fabrikam.com`|Member|fabrikam.com|Yes|Yes(tenant allowed by policy)|No|
|`bob@northwinds.com`|Member|northwinds.com|Yes|No(tenant not allowed by policy)|No|
|`alice@contoso.com`|Member|contoso.com|No(same tenant)|Yes|No|
|`bob_northwinds.com#EXT#@contoso.com`|Guest|contoso.com|No(guest user)|Yes|No|

### Validate the authentication plane protection

1. Ensure that Universal Tenant Restrictions signaling is turned off in Global Secure Access settings.
1. Use your browser to navigate to `https://myapps.microsoft.com/` and sign in with the identity from a tenant different than yours that isn't allow-listed in a tenant restrictions v2 policy. Note that you may need to use a private browser window and/or log out of your primary account to perform this step.
   1. For example, if your tenant is Contoso, sign in as a Fabrikam user in the Fabrikam tenant. 
   1. The Fabrikam user should be able to access the MyApps portal, since Tenant Restrictions signaling is disabled in Global Secure Access.
1. Turn on universal tenant restrictions in the Microsoft Entra admin center -> Global Secure Access -> Session Management -> Universal Tenant Restrictions.
1. Sign out from the MyApps portal and restart your browser.
1. As an end-user, with the Global Secure Access client running, access `https://myapps.microsoft.com/` using the same identity (Fabrikam user in the Fabrikam tenant).
   1. The Fabrikam user should be blocked from authenticating to MyApps with the error message: **Access is blocked, The Contoso IT department has restricted which organizations can be accessed. Contact the Contoso IT department to gain access.**

### Validate the data plane protection

1. Ensure that the Universal Tenant Restrictions signaling is turned off in Global Secure Access settings.
1. Use your browser to navigate to `https://yourcompany.sharepoint.com/` and sign in with the identity from a tenant different than yours that isn't allow-listed in a Tenant Restrictions v2 policy. Note that you may need to use a private browser window and/or log out of your primary account to perform this step.
   1. For example, if your tenant is Contoso, sign in as a Fabrikam user in the Fabrikam tenant. 
   1. The Fabrikam user should be able to access SharePoint, since Tenant Restrictions v2 signaling is disabled in Global Secure Access.
1. Optionally, in the same browser with SharePoint Online open, open Developer Tools, or press F12 on the keyboard. Start capturing the network logs. You should see HTTP requests returning status `200` as you navigate SharePoint when everything is working as expected. 
1. Ensure the **Preserve log** option is checked before continuing.
1. Keep the browser window open with the logs.  
1. Turn on Universal Tenant Restrictions in the Microsoft Entra admin center -> Global Secure Access -> Session Management -> Universal Tenant Restrictions.
1. As the Fabrikam user, in the browser with SharePoint Online open, within a few minutes, new logs appear. Also, the browser may refresh itself based on the request and responses happening in the back-end. If the browser doesn't automatically refresh after a couple of minutes, refresh the page.
   1. The Fabrikam user sees that their access is now blocked with the message: **Access is blocked, The Contoso IT department has restricted which organizations can be accessed. Contact the Contoso IT department to gain access.**
1. In the logs, look for a **Status** of `302`. This row shows universal tenant restrictions being applied to the traffic. 
   1. In the same response, check the headers for the following information identifying that universal tenant restrictions were applied:
      1. `Restrict-Access-Confirm: 1`
      1. `x-ms-diagnostics: 2000020;reason="xms_trpid claim was not present but sec-tenant-restriction-access-policy header was in requres";error_category="insufficiant_claims"`

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Next steps
- [Enable enhanced Global Secure Access signaling](how-to-source-ip-restoration.md#enable-global-secure-access-signaling-for-conditional-access)
- [Set up tenant restrictions v2](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Source IP restoration](how-to-source-ip-restoration.md)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
