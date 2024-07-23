---
title: Enable source IP restoration with the Global Secure Access
description: Learn how to enable source IP restoration to ensure the source IP matches in downstream resources.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 05/09/2024
ms.author: kenwith
author: kenwith
manager: amycolannino
ms.reviewer: alexpav
---
# Source IP restoration

With a cloud based network proxy between users and their resources, the IP address that the resources see doesn't match the actual source IP address. In place of the end-users’ source IP, the resource endpoints see the cloud proxy as the source IP address. Customers with these cloud proxy solutions can't use this source IP information. 

Source IP restoration in Global Secure Access allows backward compatibility for Microsoft Entra customers to continue using original user Source IP. Administrators can benefit from the following capabilities:

- Continue to enforce Source IP-based location policies across both [Conditional Access](/azure/active-directory/conditional-access/overview) and [continuous access evaluation](/azure/active-directory/conditional-access/concept-continuous-access-evaluation).
- [Identity Protection risk detections](/azure/active-directory/identity-protection/concept-identity-protection-risks) get a consistent view of original user Source IP address for assessing various risk scores.
- Original user Source IP is also made available in [Microsoft Entra sign-in logs](/azure/active-directory/reports-monitoring/concept-all-sign-ins).

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have both of the following role assignments depending on the tasks they're performing.
   * The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   * The [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.
* The product requires licensing. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).

### Known limitations

When source IP restoration is enabled, you can only see the source IP. The IP address of the Global Secure Access service isn't visible. If you want to see the Global Secure Access service IP address, disable source IP restoration.

Source IP restoration is currently supported for only [Microsoft traffic](/microsoft-365/enterprise/urls-and-ip-address-ranges), like SharePoint Online, Exchange Online, Teams, and Microsoft Graph. If you have any IP location-based Conditional Access policies for non-Microsoft resources protected by continuous access evaluation (CAE), these policies aren’t evaluated at the resource as the source IP address isn’t known to the resource. 

If you're using CAE’s [strict location enforcement](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md), users are blocked despite being in a trusted IP range. To resolve this condition, do one of the following recommendations:

- If you have IP location-based Conditional Access policies targeting non-Microsoft resources, don't enable strict location enforcement.  
- Ensure that the traffic is supported by Source IP Restoration, or don't send the relevant traffic through Global Secure Access.

## Enable Global Secure Access signaling for Conditional Access

To enable the required setting to allow source IP restoration, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session management** > **Adaptive Access**.
1. Select the toggle to **Enable Global Secure Access signaling in Conditional Access**.

This functionality allows services like Microsoft Graph, Microsoft Entra ID, SharePoint Online, and Exchange Online to see the actual source IP address.

:::image type="content" source="media/how-to-source-ip-restoration/toggle-enable-signaling-in-conditional-access.png" alt-text="Screenshot showing the toggle to enable signaling in Conditional Access.":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on IP location checks, and you disable Global Secure Access signaling in Conditional Access, you may unintentionally block targeted end-users from being able to access the resources. If you must disable this feature, first delete any corresponding Conditional Access policies. 

## Sign-in log behavior

To see source IP restoration in action, administrators can take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](/azure/active-directory/roles/permissions-reference#security-reader).
1. Browse to **Identity** > **Users** > **All users** > select one of your test users > **Sign-in logs**.
1. Click **Columns** and check the box for **Global Secure Access IP address**.
1. You can now compare the columns **IP address** and **Global Secure Access IP address**. **IP Address** indicates the restored egress IP and **Global Secure Access IP address** indicates the proxied IP address through the Microsoft SSE solution.

Sign-in log data might take some time to appear this delay is normal as there's some processing that must take place.

:::image type="content" source="media/how-to-source-ip-restoration/sign-inLogExample.png" alt-text="Screenshot of the sign-in logs showing events with different IP addresses highlighting both the restored and proxied IP address" lightbox="media/how-to-source-ip-restoration/sign-in-logs-enabled-disabled.png":::



## Related content

- [Set up tenant restrictions v2 (preview)](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
- [Strictly enforce location policies using continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md)
