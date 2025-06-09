---
author: csmulligan
ms.service: entra-external-id
ms.subservice: external
ms.topic: include
ms.date: 10/07/2024
ms.author: cmulligan
ms.manager: dougeby
---

To test a [user flow](/entra/external-id/customers/how-to-user-flow-sign-up-sign-in-customers) with this app registration, enable the implicit grant flow for authentication.

> [!IMPORTANT]
> The implicit flow should be used only for testing purposes and not for authenticating users in your production apps. Once you have finished testing, we recommend removing it.

To enable the implicit flow, follow these steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Application Developer](~/identity/role-based-access-control/permissions-reference.md#application-developer).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="~/external-id/customers/media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to your external tenant from the **Directories + subscriptions** menu.
1. Browse to **Entra ID** > **App registrations**.
1. Select the app registration you created.
1. Under **Manage**, select **Authentication**.
1. Under **Implicit grant and hybrid flows**, select the **ID tokens (used for implicit and hybrid flows)** checkbox.
1. Select **Save**.