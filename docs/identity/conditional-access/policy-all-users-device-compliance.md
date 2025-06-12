---
title: Enforce device compliance with Conditional Access
description: Require devices accessing resources be marked as compliant with your organization's configuration policies.

ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
ms.date: 04/01/2025

ms.author: joflore
author: MicrosoftGuyJFlo
manager: femila
ms.reviewer: jodah
---
# Require device compliance with Conditional Access

Microsoft Intune and Microsoft Entra work together to secure your organization through [device compliance policies](/mem/intune/protect/device-compliance-get-started) and Conditional Access. Device compliance policies are a great way to ensure user devices meet minimum configuration requirements. The requirements can be enforced when users access services protected with Conditional Access policies.

Some organizations might not be ready to require device compliance for all users. These organizations might instead choose to deploy the following policies: 

- [Require compliant or Microsoft Entra hybrid joined device for their administrators](policy-alt-admin-device-compliand-hybrid.md)
- [Require a compliant device, Microsoft Entra hybrid joined device, **OR** multifactor authentication for all users](policy-alt-all-users-compliant-hybrid-or-mfa.md)
- [Block unknown or unsupported device platforms](policy-all-users-device-unknown-unsupported.md)
- [Disable browser persistence](policy-all-users-persistent-browser.md)

## User exclusions
[!INCLUDE [active-directory-policy-exclusions](~/includes/entra-policy-exclude-user.md)]

[!INCLUDE [active-directory-policy-deploy-template](~/includes/entra-policy-deploy-template.md)]

## Create a Conditional Access policy

The following steps help create a Conditional Access policy to require devices accessing resources be marked as compliant with your organization's [Intune compliance policies](/mem/intune/protect/create-compliance-policy). 

> [!WARNING]
> Without a compliance policy created in Microsoft Intune, this Conditional Access policy won't function as intended. Create a compliance policy first and ensure you have at least one compliant device before proceeding.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](../role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access** > **Policies**.
1. Select **New policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**
   1. Under **Exclude**: 
      1. Select **Users and groups** 
         1. Choose your organization's emergency access or break-glass accounts.
         1. If you use hybrid identity solutions like Microsoft Entra Connect or Microsoft Entra Connect Cloud Sync, select **Directory roles**, then select **Directory Synchronization Accounts**
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Access controls** > **Grant**.
   1. Select **Require device to be marked as compliant**.
   1. Select **Select**.
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!NOTE]
> You can enroll your new devices to Intune even if you select **Require device to be marked as compliant** for **All users** and **All resources (formerly 'All cloud apps')** using the previous steps. The **Require device to be marked as compliant** control doesn't block Intune enrollment.

### Known behavior

On iOS, Android, macOS, and some non-Microsoft web browsers, Microsoft Entra ID identifies the device using a client certificate that is provisioned when the device is registered with Microsoft Entra ID. When a user first signs in through the browser the user is prompted to select the certificate. The end user must select this certificate before they can continue to use the browser.

#### Subscription activation

Organizations that use the [Subscription Activation](/windows/deployment/windows-10-subscription-activation) feature to enable users to "step-up" from one version of Windows to another, might want to exclude the Windows Store for Business, AppID 45a330b1-b1ec-4cc1-9161-9f03992aa49f from their device compliance policy.

## Related content

- [Create a compliance policy in Microsoft Intune](/mem/intune/protect/create-compliance-policy)
- [Conditional Access grant controls](/entra/identity/conditional-access/concept-conditional-access-grant#require-device-to-be-marked-as-compliant)
