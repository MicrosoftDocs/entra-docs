---
title: Fraud Protection Integration
description: Learn how to configure Arkose Labs and Human fraud protection with Microsoft Entra External ID to block bot attacks and fake account creation during user sign-up flows.
author: csmulligan
ms.author: cmulligan
manager: dougeby
ms.service: entra-external-id
ms.subservice: external
zone_pivot_groups: fraud-protection-integration
ms.topic: how-to
ms.date: 09/24/2025
#Customer intent: As an IT admin, I want to integrate Arkose Labs and Human with Microsoft Entra External ID to prevent fake account sign-ups and bot attacks using the Microsoft Entra admin center.
---
# Integrate Microsoft Entra External ID with Arkose Labs and Human for fraud protection (preview)

[!INCLUDE [applies-to-external-only](../includes/applies-to-external-only.md)]

Microsoft Entra External ID supports integration with third-party fraud protection providers, such as [Arkose Labs](https://www.arkoselabs.com/solutions/fake-account-creation/) and [HUMAN](https://www.humansecurity.com/), to help prevent fake account sign-ups and bot attacks. These providers offer comprehensive fraud protection solutions that enable organizations to detect and block automated attacks, such as bot-driven registrations, during the user sign-up process.  

By integrating Arkose Labs, HUMAN, or both with Microsoft Entra External ID, you can leverage their advanced risk assessment capabilities to ensure that only legitimate users create accounts.  

This article explains how to integrate fraud protection providers with Microsoft Entra External ID.

::: zone pivot="arkose"

## How Arkose Labs works

When a user attempts to sign up, the Arkose Labs service evaluates the request and determines if it's likely to be fraudulent. If the request is flagged as suspicious, the user is presented with a challenge (like a CAPTCHA) to verify that they're human. If the user successfully completes the challenge, they can proceed with the sign-up process. Once this feature is enabled, you'll be able to view Arkose challenge metrics in the Arkose Labs dashboard. Additionally, you can fine-tune risk policies by coordinating with Arkose Labs support.

You can complete the integration in both the Microsoft Entra admin center and the Microsoft Graph API. This article provides instructions for the Microsoft Entra admin center.

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the tenant.
- An account with at least an [Authentication Extensibility Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-extensibility-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role in the external tenant.
- An Arkose Labs account. Go to arkoselabs.com to [request a demo](https://www.arkoselabs.com/bot-management-demo/)
- The following configuration values from Arkose:
    - Public key (GUID format).
    - Private key (GUID format).
    - Client subdomain: use only the subdomain prefix (for example, "client-api"), not the full domain. 
    - Verify subdomain: use only the subdomain prefix (for example, "verify-api"), not the full domain.

## Configure Arkose Labs in the Microsoft Entra admin center

To integrate Arkose Labs with Microsoft Entra External ID, you can use the Service Integration wizard in Microsoft Entra admin center to create a fraud protection provider policy.  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Extensibility Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-extensibility-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant from the **Directories + subscriptions** menu.
1. Browse to **Home** > **Service Integrations** > **Sign-up protection (Preview)** to start the wizard.

   :::image type="content" source="media/how-to-integrate-fraud-protection/configure-sign-up-protection.png" alt-text="Screenshot showing the Sign-up protection (Preview) page.":::

1. Enter a name for the policy, such as *ArkosePolicy*.
1. Select the scenarios to apply the fraud protection policy to and select **Next**.

   :::image type="content" source="media/how-to-integrate-fraud-protection/policy-set-up.png" alt-text="Screenshot showing setting up a protection policy.":::

1. In the **Choose a fraud protection provider for sign-up** step, select **Arkose Labs** as the provider and select **Next**.

   :::image type="content" source="media/how-to-integrate-fraud-protection/choose-fraud-protection-provider.png" alt-text="Screenshot showing selecting the Arkose Labs fraud protection provider.":::

1. In the **Configure Arkose Labs for sign-up protection** step, select the **Create new** configuration, and enter the configuration values you received from Arkose Labs:
    - **Public key**: Enter the public key (GUID format).
    - **Private key**: Enter the private key (GUID format).
    - **Client subdomain**: Enter only the subdomain prefix (for example, "client-api"), not the full domain.
    - **Verify subdomain**: Enter only the subdomain prefix (for example, "verify-api"), not the full domain.

1. Or select an existing configuration if you have already set one up and select **Next**.

   :::image type="content" source="media/how-to-integrate-fraud-protection/provider-configuration.png" alt-text="Screenshot showing configuring the Arkose Labs provider.":::

1. Select the app you want to protect with Arkose Labs fraud protection. You can select one or more applications that you have registered in your external tenant.

   :::image type="content" source="media/how-to-integrate-fraud-protection/select-apps-to-protect.png" alt-text="Screenshot showing selecting an application to protect.":::

1. Review the configuration and select **Create policy** to create the fraud protection policy.

   :::image type="content" source="media/how-to-integrate-fraud-protection/create-policy.png" alt-text="Screenshot showing creating a policy for Arkose Labs.":::

1. Once you receive the confirmation that the policy was created successfully, select **Done** to finish the wizard.

Once the policy is created, it's applied to the selected applications. When a user attempts to sign up, the Arkose Labs service evaluates the request and determines if it's likely to be fraudulent. If the request is flagged as suspicious, the user is presented with a challenge (like a CAPTCHA) to verify that they're human. If the user successfully completes the challenge, they can proceed with the sign-up process.

## Edit the Arkose Labs configuration in the Microsoft Entra admin center  

1. Browse to **Home** > **Service Integrations** > **Sign-up protection (Preview)** to view the list of configurations.
1. Select the **Edit provider configurations** option to edit the Arkose Labs policy. If you want to edit the fraud protection policy, select the pencil icon.
1. In the **Configure Arkose Labs for sign-up protection** step, select the configuration you want to edit and select **Next**.
1. Select the app you want to protect with Arkose Labs fraud protection or remove the existing ones. You can select one or more applications that you have registered in your external tenant. Once you selected the app, select **Next**.
1. Select **Done** to finish the wizard.

::: zone-end  

::: zone pivot="human"

## How HUMAN Security works

When a user initiates the sign-up process, it is critical to prevent automated bots and malicious actors from creating fraudulent accounts. To address this, Entra External ID supports integration with third-party fraud detection providers such as HUMAN Security. This integration enables real-time analysis of sign-up attempts, leveraging HUMAN Security’s advanced detection algorithms to identify and block suspicious activity before account creation is completed. The solution is natively integrated with Microsoft identity infrastructure, allowing for streamlined deployment and management. By implementing this approach, organizations can access detailed telemetry and actionable insights to monitor sign-up flows, fine-tune detection thresholds, and respond proactively to emerging threats, thereby maintaining the integrity of their user base.

## Prerequisites

- An [external tenant](how-to-create-external-tenant-portal.md).
- A [registered application](/entra/identity-platform/quickstart-register-app) in the tenant.
- An account with at least an [Authentication Extensibility Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-extensibility-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator) role in the external tenant.
- Create a HUMAN Security account: Contact Human Security (entra@humansecurity.com) to create and set up a free HUMAN Security account. 
- The following configuration values from HUMAN Security:
  - Application ID
  - Server token

You can find these values in the HUMAN Security admin console in the [application settings](https://docs.humansecurity.com/applications-and-accounts/docs/managing-applications#adding-server-tokens) page. If you're unsure about any value, contact HUMAN Security for assistance.

## Configure HUMAN Security in the Microsoft Entra admin center

To integrate HUMAN Security with Microsoft Entra External ID, you can use the Service Integration wizard in Microsoft Entra admin center to create a fraud protection provider policy.  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Extensibility Administrator](/entra/identity/role-based-access-control/permissions-reference#authentication-extensibility-administrator) or [Application Administrator](/entra/identity/role-based-access-control/permissions-reference#application-administrator).
1. If you have access to multiple tenants, use the **Settings** icon :::image type="icon" source="media/common/admin-center-settings-icon.png" border="false"::: in the top menu to switch to the external tenant from the **Directories + subscriptions** menu.
1. Browse to **Home** > **Service Integrations** > **Sign-up protection (Preview)** to start the wizard.

   :::image type="content" source="media/how-to-integrate-fraud-protection/configure-sign-up-protection.png" alt-text="Screenshot showing the Sign-up protection (Preview) page.":::

1. Enter a name for the policy, such as *HUMANPolicy*.
1. Select the scenarios to apply the fraud protection policy to and select **Next**.

   :::image type="content" source="media/how-to-integrate-fraud-protection/policy-set-up-human.png" alt-text="Screenshot showing setting up a protection policy.":::

1. In the **Choose a fraud protection provider for sign-up** step, select **HUMAN Security** as the provider and select **Next**.

   :::image type="content" source="media/how-to-integrate-fraud-protection/choose-fraud-protection-provider-human.png" alt-text="Screenshot showing selecting the HUMAN Security fraud protection provider.":::

1. In the **Configure HUMAN Security for sign-up protection** step, select the **Create new** configuration, and enter the configuration values you received from HUMAN Security:
    - **App Id**: Enter the Application ID from HUMAN Security.
    - **Server token**: Enter the Server token from HUMAN Security that you can find in the HUMAN Security admin console.

1. Or select an existing configuration if you have already set one up and select **Next**.
1. Select the app you want to protect with HUMAN Security fraud protection. You can select one or more applications that you have registered in your external tenant.

   :::image type="content" source="media/how-to-integrate-fraud-protection/select-apps-to-protect.png" alt-text="Screenshot showing selecting an application to protect.":::

1. Review the configuration and select **Create policy** to create the fraud protection policy.
1. Once you receive the confirmation that the policy was created successfully, select **Done** to finish the wizard.

Once the policy is created, it's applied to the selected applications. When a user attempts to sign up, HUMAN Security evaluates the request in real-time to determine if it's likely to be fraudulent. If the request is flagged as suspicious, appropriate measures are taken to block the sign-up attempt, thereby preventing fake account registrations.

## Edit the HUMAN Security configuration in the Microsoft Entra admin center  

1. Browse to **Home** > **Service Integrations** > **Sign-up protection (Preview)** to view the list of configurations.
1. Select the **Edit provider configurations** option to edit the HUMAN Security policy. If you want to edit the fraud protection policy, select the pencil icon.
1. In the **Configure HUMAN Security for sign-up protection** step, select the configuration you want to edit and select **Next**.
1. Select the app you want to protect with HUMAN Security fraud protection or remove the existing ones. You can select one or more applications that you have registered in your external tenant. Once you selected the app, select **Next**.
1. Select **Done** to finish the wizard.

::: zone-end  


