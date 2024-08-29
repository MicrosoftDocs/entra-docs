---
title: Enforce device compliance with Conditional Access
description: Require devices accessing resources be marked as compliant with your organization's configuration policies.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 08/28/2024

ms.author: joflore
author: MicrosoftGuyJFlo
manager: amycolannino
ms.reviewer: jodah
---
# Common policy: Create a Conditional Access policy requiring device compliance

Microsoft Intune and Microsoft Entra work together to secure your organization through [device compliance policies](/mem/intune/protect/device-compliance-get-started) and Conditional Access. Device compliance policies are a great way to ensure user devices meet minimum configuration requirements. The requirements can be enforced when users access services protected with Conditional Access policies.

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to require devices accessing resources be marked as compliant with your organization's [Intune compliance policies](/mem/intune/protect/create-compliance-policy). 

> [!WARNING]
> Without a compliance policy created in Microsoft Intune this Conditional Access policy will not function as intended. Create a compliance policy first and ensure you have at least one compliant device before proceeding.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Protection** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**, select **Users and groups** and choose your organization's emergency access or break-glass accounts. 
1. Under **Target resources** > **Cloud apps** > **Include**, select **All cloud apps**.
1. Under **Access controls** > **Grant**.
   1. Select **Require device to be marked as compliant**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

After administrators confirm the settings using [report-only mode](howto-conditional-access-insights-reporting.md), they can move the **Enable policy** toggle from **Report-only** to **On**.

> [!NOTE]
> You can enroll your new devices to Intune even if you select **Require device to be marked as compliant** for **All users** and **All cloud apps** using the previous steps. The **Require device to be marked as compliant** control does not block Intune enrollment.

### Known behavior

On Windows 7, iOS, Android, macOS, and some non-Microsoft web browsers, Microsoft Entra ID identifies the device using a client certificate that is provisioned when the device is registered with Microsoft Entra ID. When a user first signs in through the browser the user is prompted to select the certificate. The end user must select this certificate before they can continue to use the browser.

#### Subscription activation

Organizations that use the [Subscription Activation](/windows/deployment/windows-10-subscription-activation) feature to enable users to "step-up" from one version of Windows to another, might want to exclude the Windows Store for Business, AppID 45a330b1-b1ec-4cc1-9161-9f03992aa49f from their device compliance policy.

## Related content

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy)
- [Conditional Access grant controls](/entra/identity/conditional-access/concept-conditional-access-grant#require-device-to-be-marked-as-compliant)
