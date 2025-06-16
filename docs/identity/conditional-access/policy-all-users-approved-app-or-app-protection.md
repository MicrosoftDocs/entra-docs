---
title: Conditional Access - Require approved app or app protection policy
description: Create a custom Conditional Access policy require approved app or app protection policy
author: MicrosoftGuyJFlo
ms.author: joflore
manager: femila
ms.reviewer: lhuangnorth
ms.date: 04/01/2025
ms.service: entra-id
ms.subservice: conditional-access
ms.topic: how-to
---
# Require approved client apps or app protection policy

People regularly use their mobile devices for both personal and work tasks. While making sure staff can be productive, organizations also want to prevent data loss from applications on devices they may not manage fully.

With Conditional Access, organizations can restrict access to [approved (modern authentication capable) client apps with Intune app protection policies](concept-conditional-access-grant.md#require-app-protection-policy). For older client apps that may not support app protection policies, administrators can restrict access to [approved client apps](concept-conditional-access-grant.md#require-approved-client-app).

> [!WARNING]
> App protection policies are supported on iOS and Android where applications meet specific requirements. **App protection policies are supported on Windows in preview for the Microsoft Edge browser only.** Not all applications that are supported as approved applications or support application protection policies. For a list of some common client apps, see [App protection policy requirement](concept-conditional-access-grant.md#require-app-protection-policy). If your application is not listed there, contact the application developer. In order to require approved client apps or to enforce app protection policies for iOS and Android devices, these devices must first register in Microsoft Entra ID.

> [!NOTE]
> **Require one of the selected controls** under grant controls is like an **OR** clause. This is used within policy to enable users to utilize apps that support either the **Require app protection policy** or **Require approved client app** grant controls. **Require app protection policy** is enforced when the app supports that grant control.

For more information about the benefits of using app protection policies, see the article [App protection policies overview](/mem/intune/apps/app-protection-policy).

The following policies are put in to [Report-only mode](howto-conditional-access-insights-reporting.md) to start so administrators can determine the impact they'll have on existing users. When administrators are comfortable that the policies apply as they intend, they can switch to **On** or stage the deployment by adding specific groups and excluding others.

## Require approved client apps or app protection policy with mobile devices.

The following steps help create a Conditional Access policy requiring an approved client app **or** an app protection policy when using an iOS/iPadOS or Android device. This policy prevents the use of Exchange ActiveSync clients using basic authentication on mobile devices. This policy works in tandem with an [app protection policy created in Microsoft Intune](/mem/intune/apps/app-protection-policies).

Organizations can choose to deploy this policy using the following steps or using the [Conditional Access templates](concept-conditional-access-policy-common.md).

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and exclude at least one account to prevent yourself from being locked out. If you don't exclude any accounts, you can't create the policy.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **All resources (formerly 'All cloud apps')**.
1. Under **Conditions** > **Device platforms**, set **Configure** to **Yes**.
   1. Under **Include**, **Select device platforms**.
   1. Choose **Android** and **iOS**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require approved client app** and **Require app protection policy**
   1. **For multiple controls** select **Require one of the selected controls**
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

> [!NOTE]
> When a policy is created in report-only mode for "Require app protection policy" control, your sign-in log may show the result as "Report-only: Failure" in "Conditional Access" tab when all configured policy conditions were satisfied. This is because the control was not satisified in report-only mode. Once you enabled the policy, the control is applied to the app and the sign-in will not be blocked.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

> [!TIP]
> Organizations should also deploy a policy that [blocks access from unsupported or unknown device platforms](policy-all-users-device-unknown-unsupported.md) along with this policy.

## Block Exchange ActiveSync on all devices

This policy blocks all Exchange ActiveSync clients using basic authentication from connecting to Exchange Online.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Conditional Access Administrator](~/identity/role-based-access-control/permissions-reference.md#conditional-access-administrator).
1. Browse to **Entra ID** > **Conditional Access**.
1. Select **Create new policy**.
1. Give your policy a name. We recommend that organizations create a meaningful standard for the names of their policies.
1. Under **Assignments**, select **Users or workload identities**.
   1. Under **Include**, select **All users**.
   1. Under **Exclude**, select **Users and groups** and exclude at least one account to prevent yourself from being locked out. If you don't exclude any accounts, you can't create the policy.
   1. Select **Done**.
1. Under **Target resources** > **Resources (formerly cloud apps)** > **Include**, select **Select resources**.
   1. Select **Office 365 Exchange Online**.
   1. Select **Select**.
1. Under **Conditions** > **Client apps**, set **Configure** to **Yes**.
   1. Uncheck all options except **Exchange ActiveSync clients**.
   1. Select **Done**.
1. Under **Access controls** > **Grant**, select **Grant access**.
   1. Select **Require app protection policy**
1. Confirm your settings and set **Enable policy** to **Report-only**.
1. Select **Create** to create to enable your policy.

[!INCLUDE [conditional-access-report-only-mode](../../includes/conditional-access-report-only-mode.md)]

## Related Content

- [App protection policies overview](/mem/intune/apps/app-protection-policy)
- [Conditional Access common policies](concept-conditional-access-policy-common.md)
- [Migrate approved client app to application protection policy in Conditional Access](migrate-approved-client-app.md)
