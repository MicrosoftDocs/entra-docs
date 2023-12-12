---
title: Overview of authentication strength advanced options for FIDO2 security keys and certificate-based authentication in Microsoft Entra ID
description: Learn how admins can use advanced options for FIDO2 security keys and certificate-based authentication when they configure authentication strength requirements.

services: multi-factor-authentication
ms.service: active-directory
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/12/2023

ms.author: justinha
author: inbarckms
manager: amycolannino
ms.reviewer: inbarc

ms.collection: M365-identity-device-management
---
# Advanced options for Conditional Access authentication strength 


## FIDO2 security key advanced options
Custom authentication strengths allow customers to further restrict the usage of some FIDO2 security keys based on their Authenticator Attestation GUIDs (AAGUIDs). The capability allows administrators to require a FIDO2 key from a specific manufacture in order to access the resource. To require a specific FIDO2 security key, complete the preceding steps to create a custom authentication strength, select **FIDO2 Security Key**, and click **Advanced options**. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot showing Advanced options.":::

Next to **Allowed FIDO2 Keys** click **+**, copy the AAGUID value, and click **Save**.

:::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot showing how to add an Authenticator Attestation GUID.":::

## Next steps

- [Overview](concept-authentication-strengths.md)
- [How authentication strength works](concept-authentication-strength-howitworks.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
