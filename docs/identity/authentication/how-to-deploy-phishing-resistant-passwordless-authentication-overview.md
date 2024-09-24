---
title: Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID
description: Detailed guidance for deploying passwordless and phishing-resistant authentication for organizations that use Microsoft Entra ID.

ms.service: entra-id 
ms.subservice: authentication
ms.topic: how-to
ms.date: 09/19/2024

ms.author: justinha
author: mepples21
manager: amycolannino
ms.reviewer: miepping

ms.collection: M365-identity-device-management
# Customer intent: As an identity administrator, I want to understand how to plan phishing-resistant and passwordless authentication deployment in Microsoft Entra ID

---
# Plan a phishing-resistant passwordless authentication deployment in Microsoft Entra ID

Passwords are the primary attack vector for modern adversaries, and a source of friction for users and administrators. 
As part of an overall [Zero Trust security strategy](https://www.microsoft.com/en-us/security/business/zero-trust), Microsoft recommends [moving to phishing-resistant passwordless](https://www.microsoft.com/security/business/solutions/passwordless-authentication) in your authentication solution. 
This guide helps you select, prepare, and deploy the right phishing-resistant passwordless credentials for your organization. 
Use this guide to plan and execute your phishing-resistant passwordless project.

Features like multifactor authentication (MFA) are a great way to secure your organization. 
But users often get frustrated with the extra security layer on top of their need to remember passwords. 
Phishing-resistant passwordless authentication methods are more convenient. 

For example, an analysis of Microsoft consumer accounts shows that sign-in with a password can take up to 9 seconds on average, but passkeys only take around 3 seconds in most cases.
The speed and ease of passkey sign-in is even greater when compared with traditional password and MFA sign in. 
Passkey users don’t need to remember their password, or wait around for SMS messages.

Phishing-resistant passwordless methods also have extra security baked in. 
They automatically count as MFA by using something that the user has (a physical device or security key) and something the user knows or is, like a biometric or PIN. 
And unlike traditional MFA, phishing-resistant passwordless methods deflect phishing attacks against your users by using hardware-backed credentials that can’t be easily compromised. 

Microsoft Entra ID offers the following phishing-resistant passwordless authentication options:

- Passkeys (FIDO2)
  - Windows Hello for Business
  - Platform credential for macOS (preview)
  - Microsoft Authenticator app passkeys (preview)
  - FIDO2 security keys
  - Other passkeys and providers, such as iCloud
- Certificate-based authentication/smartcards

:::image type="content" border="true" source="media/how-to-deploy-phishing-resistant-passwordless-authentication/methods.png" alt-text="Diagram that shows the relative convenience and security of different sign-in methods.":::

## Next steps

[Prerequisites](how-to-plan-prerequisites-phishing-resistant-passwordless-authentication.md)
[Plan](how-to-plan-phishing-resistant-passwordless-authentication.md)
[Deploy](how-to-deploy-phishing-resistant-passwordless-authentication.md)
[Considerations for specific personas in a phishing-resistant passwordless authentication deployment in Microsoft Entra ID](how-to-plan-persona-phishing-resistant-passwordless-authentication.md)
