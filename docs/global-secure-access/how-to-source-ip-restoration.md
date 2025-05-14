---
title: Enable Source IP Restoration with Global Secure Access
description: Learn how to enable source IP restoration to ensure the source IP matches in downstream resources.
ms.service: global-secure-access
ms.topic: how-to
ms.date: 02/21/2025
ms.author: kenwith
author: kenwith
manager: femila
ms.reviewer: alexpav
ai-usage: ai-assisted
---
# Source IP Restoration
Use of cloud-based network proxy and SSE solutions abstracts the original source IP of the user from the service to which the user is connecting. Instead, the service will detect the user's IP address to be the egress address of the cloud-based network proxy. While this helps with privacy-related concerns in consumer scenarios, not having the original source IP information makes it difficult to achieve enterprise security goals. For example, without an actual client egress IP address, applying Entra ID Conditional Access policies based on organization's well-known IP addresses is not possible, and audit logs will not reflect accurate location information.

Source IP Restoration is part of the Adaptive Access feature of Microsoft Entra Internet Access for Microsoft Services. Source IP Restoration detects and securely communicates the original egress IP address of the end user to Entra ID and Microsoft Graph, bringing the following benefits to the organization:

- Continue to enforce IP-based location policies in [Microsoft Entra ID Conditional Access](/azure/active-directory/conditional-access/overview).
- Improve accuracy of risk detection in [Microsoft Entra ID Protection risk detections](/entra/id-protection/concept-identity-protection-risks).
- Elevate your threat detection and response with accurate source IP recorded in [Microsoft Entra sign-in logs](/azure/active-directory/reports-monitoring/concept-all-sign-ins) and in [Microsoft Entra audit logs](/entra/identity/monitoring-health/concept-audit-logs).

## Prerequisites

* Administrators who interact with **Global Secure Access** features must have both of the following role assignments depending on the tasks they're performing.
   * The [Global Secure Access Administrator role](/azure/active-directory/roles/permissions-reference) role to manage the Global Secure Access features.
   * The [Conditional Access Administrator](/azure/active-directory/roles/permissions-reference#conditional-access-administrator) to create and interact with Conditional Access policies.
* The product requires Microsoft Entra ID P1 licenses. For details, see the licensing section of [What is Global Secure Access](overview-what-is-global-secure-access.md). If needed, you can [purchase licenses or get trial licenses](https://aka.ms/azureadlicense).
* You must enable the [Microsoft Traffic Profile](concept-microsoft-traffic-profile.md) to use Source IP Restoration.

### Known limitations

[!INCLUDE [known-limitations-include](../includes/known-limitations-include.md)]

## Enable Global Secure Access signaling for Conditional Access

> **Note:** Source IP restoration is now enabled by default for new tenants. If you have enabled Global Secure Access features in your tenant prior to June 2025, you may need to explicitly enable Source IP Restoration.

To enable the required setting to allow source IP restoration, an administrator must take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Secure Access Administrator](/azure/active-directory/roles/permissions-reference#global-secure-access-administrator).
1. Browse to **Global Secure Access** > **Settings** > **Session management** > **Adaptive Access**.
1. Select the toggle to **Enable Global Secure Access signaling in Conditional Access**.

This functionality allows Entra ID and Microsoft Graph to receive the public egress source IP address of the user.

:::image type="content" source="media/how-to-source-ip-restoration/toggle-enable-signaling-in-conditional-access.png" alt-text="Screenshot showing the toggle to enable signaling in Conditional Access.":::

> [!CAUTION]
> If your organization has active Conditional Access policies based on IP location checks, and you disable Global Secure Access signaling in Conditional Access, you may unintentionally block targeted end-users from being able to access the resources. If you must disable this feature, first delete any corresponding Conditional Access policies. 

## Sign-in log behavior

To see source IP restoration in action, administrators can take the following steps.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Reader](/azure/active-directory/roles/permissions-reference#security-reader).
1. Browse to **Entra ID** > **Users** > select one of your test users > **Sign-in logs**.
1. With source IP restoration enabled, you see IP addresses that include their actual IP address. 
   - If source IP restoration is disabled, you can't see their actual IP address.

Sign-in log data might take some time to appear this delay is normal as there's some processing that must take place.

:::image type="content" source="media/how-to-source-ip-restoration/sign-in-logs-enabled-disabled.png" alt-text="Screenshot of the sign-in logs showing events with source IP restoration on, then off, then on again." lightbox="media/how-to-source-ip-restoration/sign-in-logs-enabled-disabled.png":::

## Related content

- [Set up tenant restrictions v2 (preview)](/azure/active-directory/external-identities/tenant-restrictions-v2)
- [Enable compliant network check with Conditional Access](how-to-compliant-network.md)
- [Strictly enforce location policies using continuous access evaluation](../identity/conditional-access/concept-continuous-access-evaluation-strict-enforcement.md)
- [Microsoft Traffic Profile](concept-microsoft-traffic-profile.md) 
