---
title: Enable compliant network check with Conditional Access
description: Learn how to require known compliant network locations in order to connect to your secured resources with Conditional Access.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 08/13/2024
ms.author: kenwith
author: kenwith
manager: amycolannino
ms.reviewer: smistry
---
# Enable compliant network check with Conditional Access

Organizations who use Conditional Access along with the Global Secure Access, can prevent malicious access to Microsoft apps, third-party SaaS apps, and private line-of-business (LoB) apps using multiple conditions to provide defense-in-depth. These conditions might include device compliance, location, and more to provide protection against user identity or token theft. Global Secure Access introduces the concept of a compliant network within Microsoft Entra ID Conditional Access. This compliant network check ensures users connect from a verified network connectivity model for their specific tenant and are compliant with security policies enforced by administrators.


The Global Secure Access Client installed on devices or users behind configured remote networks allows administrators to secure resources behind a compliant network with advanced Conditional Access controls. This compliant network feature makes it easier for administrators to manage access policies, without having to maintain a list of egress IP addresses. This removes the requirement to hairpin traffic through organization's VPN.

## Compliant network check enforcement
Compliant network enforcement reduces the risk of token theft/replay attacks. Compliant network enforcement happens at the authentication plane (generally available) and at the data plane (preview). Authentication plane enforcement is performed by Microsoft Entra ID at the time of user authentication. If an adversary has stolen a session token and attempts to replay it from a device that is not connected to your organization’s compliant network (for example, requesting an access token with a stolen refresh token), Entra ID will immediately deny the request and further access will be blocked. Data plane enforcement works with services that support Continuous Access Evaluation (CAE) - currently, only SharePoint Online. With apps that support CAE, stolen access tokens that are replayed outside your tenant’s compliant network will be rejected by the application in near-real time. Without CAE, a stolen access token will last up to its full lifetime (default 60-90 minutes). 

This compliant network check is specific to each tenant.

- Using this check you can ensure that other organizations using Microsoft's Global Secure Access services can't access your resources.
  - For example: Contoso can protect their services like Exchange Online and SharePoint Online behind their compliant network check to ensure only Contoso users can access these resources.
  - If another organization like Fabrikam was using a compliant network check, they wouldn't pass Contoso's compliant network check.

The compliant network is different than [IPv4, IPv6, or geographic locations](../identity/conditional-access/concept-assignment-network.md) you might configure in Microsoft Entra. Administrators are not required to review and maintain compliant network IP addresses/ranges, strengthening the security posture and minimizing the ongoing administrative overhead. 

## Prerequisites

- Administrators who interact with **Global Secure Access** features must have one or more of the following role assignments depending on the tasks they're performing.
   - The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   - [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator) to create and interact with Conditional Access policies and named locations.
- The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
- To use the Microsoft traffic forwarding profile, a Microsoft 365 E3 license is recommended.

### Known limitations

- Compliant network check data plane enforcement (preview) with Continuous Access Evaluation is supported for SharePoint Online and Exchange Online.
- Enabling Global Secure Access Conditional Access signaling enables signaling for both authentication plane (Microsoft Entra ID) and data plane signaling (preview). It is not currently possible to enable these settings separately.
- Compliant network check is currently not supported for Private Access applications.
 

## Enable Global Secure Access signaling for Conditional Access

To enable the required setting to allow the compliant network check, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](../identity/role-based-access-control/permissions-reference.md#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session management** > **Adaptive access**.
1. Select the toggle to **Enable CA Signaling for Entra ID (covering all cloud apps)**. This will automatically enable CAE signaling for Office 365 (preview).
1. Browse to **Protection** > **Conditional Access** > **Named locations**.
   1. Confirm you have a location called **All Compliant Network locations** with location type **Network Access**. Organizations can optionally mark this location as trusted.

:::image type="content" source="media/how-to-compliant-network/toggle-enable-signaling-in-conditional-access.png" alt-text="Screenshot showing the toggle to enable signaling in Conditional Access.":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on compliant network check, and you disable Global Secure Access signaling in Conditional Access, you may unintentionally block targeted end-users from being able to access the resources. If you must disable this feature, first delete any corresponding Conditional Access policies.

## Protect your resources behind the compliant network

The compliant network Conditional Access policy can be used to protect your Microsoft and third-party applications. A typical policy will have a 'Block' grant for all network locations except Compliant Network. The following example demonstrates the steps to configure this type of policy:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and choose your organization's [emergency access or break-glass accounts](#user-exclusions).
1. Under **Target resources** > **Include**, and select **All cloud apps**.
   1. If your organization is enrolling devices into Microsoft Intune, it is recommended to exclude the applications **Microsoft Intune Enrollment** and **Microsoft Intune** from your Conditional Access policy to avoid a circular dependency.
1. Under **Network**.
   1. Set **Configure** to **Yes**.
   1. Under **Include**, select **Any location**.
   1. Under **Exclude**, select the **All Compliant Network locations** location.
1. Under **Access controls**:
   1. **Grant**, select **Block Access**, and select **Select**.
1. Confirm your settings and set **Enable policy** to **On**.
1. Select the **Create** button to create to enable your policy.

> [!NOTE]
> You can use Global Secure Access traffic profiles along with a Conditional Access policy requiring a compliant network for **All cloud apps**. There's no exclusion required when setting up a policy using the **All Compliant Network locations** location and **All cloud apps**.
> 
> Authentication to Global Secure Access traffic profiles are automatically excluded from Conditional Access enforcement when a compliant network is required. This exclusion enables the Global Secure Access client to access required resources to start and authenticate the user.
>
> Sign-in events for authentication of excluded Global Secure Access traffic profiles appear in the Microsoft Entra ID sign-in logs as "ZTNA Network Access Traffic Profile".

### User exclusions

[!INCLUDE [entra-policy-exclude-user](../includes/entra-policy-exclude-user.md)]

## Try your compliant network policy

1. On an end-user device with the [Global Secure Access client installed and running](how-to-install-windows-client.md), browse to [https://outlook.office.com/mail/](https://outlook.office.com/mail/) or `https://yourcompanyname.sharepoint.com/`, you have access to resources.
1. Pause the Global Secure Access client by right-clicking the application in the Windows tray and selecting **Pause**.
1. Browse to [https://outlook.office.com/mail/](https://outlook.office.com/mail/) or `https://yourcompanyname.sharepoint.com/`, you're blocked from accessing resources with an error message that says **You cannot access this right now**.

:::image type="content" source="media/how-to-compliant-network/you-cannot-access-this-right-now-error.png" alt-text="Screenshot showing error message in browser window You can't access this right now.":::

## Troubleshooting

Verify the new named location was automatically created using [Microsoft Graph](https://developer.microsoft.com/graph/graph-explorer).

`GET https://graph.microsoft.com/beta/identity/conditionalAccess/namedLocations`

:::image type="content" source="media/how-to-compliant-network/graph-explorer-expected-result-location-creation.png" alt-text="Screenshot showing Graph Explorer results of query":::



## Next steps

[Universal Tenant Restrictions](how-to-universal-tenant-restrictions.md)
