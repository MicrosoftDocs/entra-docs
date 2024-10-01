---
title: Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Persona-specific guidance to deploy passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/01/2024

ms.author: justinha
author: mepples21
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Each persona has its own challenges and considerations that commonly come up during phishing-resistant passwordless deployments. As you identify which personas you need to accommodate, you should factor these considerations into your deployment project planning. The next sections provide specific guidance for each persona.

## Information workers

Information workers typically have the simplest requirements and are the easiest to begin your phishing-resistant passwordless deployment with. However, there are still some issues that frequently arise when deploying for these users. Common examples include:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/information-worker-examples.png" alt-text="Diagram that shows examples of requirements for information workers.":::

Information worker deployments, just like any other user persona, require proper communication and support. This commonly involves convincing users to install certain apps on their phones, distributing security keys where users won’t use apps, addressing concerns about biometrics, and developing processes for helping users recover from partial or total loss of their credentials.

When dealing with concerns about biometrics, make sure that you understand how technologies like Windows Hello for Business handle biometrics. The biometric data is stored only locally on the device and cannot be converted back into raw biometric data even if stolen:

- [Windows Hello for Business Biometric data storage](/windows/security/identity-protection/hello-for-business/how-it-works#biometric-data-storage)

### Information worker deployment flow  

Phases 1-3 of the deployment flow for information workers should typically follow the standard deployment flow, as shown in the following image. Adjust the methods used at each step as needed in your environment:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/information-worker-deployment.png" alt-text="Diagram that shows deployment flow for information workers.":::

1. Phase 1: Onboarding
   1. Microsoft Entra Verified ID service used to acquire a Temporary Access Pass
1. Phase 2: Portable credential registration
   1. Microsoft Authenticator app passkey (preferred)
   1. FIDO2 security key
1. Phase 3: Local credential registration
   1. Windows Hello for Business
   1. Platform SSO Secure Enclave Key

## Frontline workers

Frontline workers often have more complicated requirements due to increased needs for the portability of their credentials and limitations on which devices they can carry in retail or manufacturing settings. Security keys are a great option for Frontline workers, but have a cost that must be considered. In order to achieve phishing-resistance, be sure to balance the cost challenges of security keys against the added deployment burden of smart cards and certificate-based authentication. Consider if there may be different FLW user personas in your environment, its possible there are some users where security keys are better and other users where smart cards are better.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/frontline-worker-examples.png" alt-text="Diagram that shows examples of requirements for frontline workers.":::

### Frontline worker deployment flow
 
Phases 1-3 of the deployment flow for frontline workers should typically follow a modified flow that emphasizes portable credentials. Many frontline workers may not have a permanent computing device, and they never need a local credential on a Windows or Mac workstation. Instead, they largely rely on portable credentials that they can take with them from device to device. Adjust the methods used at each step as needed in your environment:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/frontline-worker-deployment.png" alt-text="Diagram that shows deployment flow for frontline workers.":::

1. Phase 1: Onboarding
   1. FIDO2 security key on-behalf-of registration (preferred)
   1. Microsoft Entra Verified ID service used to acquire a Temporary Access Pass
1. Phase 2: Portable credential registration
   1. FIDO2 security key (preferred)
   1. Smart card
   1. Microsoft Authenticator app passkey 
1. Phase 3 (Optional): Local credential registration
   1. Optional: Windows Hello for Business
   1. Optional: Platform SSO Secure Enclave Key


## IT pros/DevOps workers

IT pros and DevOps workers are especially reliant on remote access and multiple user accounts, which is why they are considered different from information workers. Many of the challenges posed by phishing-resistant passwordless for IT pros are caused by their increased need for remote access to systems and ability to run automations.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/it-pro-examples.png" alt-text="Diagram that shows examples of requirements for IT pros/DevOps workers.":::

Understand the supported options for phishing-resistant with RDP especially for this persona. 

Make sure to understand where users are using scripts that run in the user context and are therefore not using MFA today. Instruct your IT pros on the proper way to run automations using service principals and managed identities. You should also consider processes to allow IT pros and other professionals to request new service principals and get the proper permissions assigned to them.

- [What are managed identities for Azure resources?](~/identity/managed-identities-azure-resources/overview.md)
- [Securing service principals in Microsoft Entra ID](~/architecture/service-accounts-principal.md)

### IT pros/DevOps worker deployment flow

Phases 1-3 of the deployment flow for IT pro/DevOps workers should typically follow the standard deployment flow as pictured above for the user’s primary account. IT pros/DevOps workers often have secondary accounts that require different considerations. Adjust the methods used at each step as needed in your environment for the primary accounts:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/it-pro-deployment.png" alt-text="Diagram that shows deployment flow for IT pros/DevOps workers.":::

1. Phase 1: Onboarding
   1. Microsoft Entra Verified ID service used to acquire a Temporary Access Pass
1. Phase 2: Portable credential registration
   1. Microsoft Authenticator app passkey (preferred)
   1. FIDO2 security key
1. Phase 3: Local credential registration
   1. Windows Hello for Business
   1. Platform SSO Secure Enclave Key

If your IT pro/DevOps workers have secondary accounts you may need to handle those accounts differently. For example, for secondary accounts you may choose to use alternative portable credentials and forego local credentials on your computing devices entirely:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/it-pro-secondary.png" alt-text="Diagram that shows an alternative deployment flow for IT pros/DevOps workers.":::

1. Phase 1: Onboarding
   1. Microsoft Entra Verified ID service used to acquire a Temporary Access Pass (preferred)
   1. Alternate process to provide TAPs for secondary accounts to the IT pro/DevOps worker
1. Phase 2: Portable credential registration
   1. Microsoft Authenticator app passkey (preferred)
   1. FIDO2 security key
   1. Smart card
1. Phase 3: Portable credentials used rather than local credentials

## Highly regulated workers

Highly regulated workers pose more challenges than the average information worker because they may work on locked down devices, work in locked down environments, or have special regulatory requirements they must satisfy.

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/regulated-worker-examples.png" alt-text="Diagram that shows examples of requirements for highly regulated workers.":::

Highly regulated workers often use smart cards due to regulated environments already having heavy adoption of PKI and smart card infrastructure. However, consider when smart cards are desirable and required and when they can be balanced with more user-friendly options, such as Windows Hello for Business.

### Highly regulated worker deployment flow without PKI

If you don't plan to use certificates, smart cards, and PKI, then the highly regulated worker deployment closely mirrors the information worker deployment. For more information, see [Information workers](#information-workers).

### Highly regulated worker deployment flow with PKI

If you plan to use certificates, smart cards, and PKI, then the deployment flow for highly regulated workers typically differs from the information worker setup flow in key places. There's an increased need to identify if local authentication methods are viable for some users. Similarly, you need to identify if there are some users who need portable-only credentials, such as smart cards, that can work without internet connections. Depending on your needs, you may adjust the deployment flow further, and tailor it to the various user personas identified in your environment. Adjust the methods used at each step as needed in your environment:

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/regulated-worker-deployment.png" alt-text="Diagram that shows deployment flow for highly regulated workers.":::

1. Phase 1: Onboarding
   1. Microsoft Entra Verified ID service used to acquire a Temporary Access Pass (preferred)
   1. Smart card registration on behalf of the user, following an identity proofing process
1. Phase 2: Portable credential registration
   1. Smart card (preferred)
   1. FIDO2 security key
   1. Microsoft Authenticator app passkey
1. Phase 3 (Optional): Local credential registration
   1. Optional: Windows Hello for Business
   1. Optional: Platform SSO Secure Enclave Key

>[!NOTE]
>It's always recommended that users have at least two credentials registered. This ensures the user has a backup credential available if something happens to their other credentials. For Highly regulated workers. it's recommended that you deploy passkeys or Windows Hello for Business in addition to any smart cards you deploy.

## Next steps

[Deploy a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-deploy-phishing-resistant-passwordless-authentication.md)

