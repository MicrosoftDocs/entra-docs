---
title: Overview of authentication strength advanced options for FIDO2 security keys and certificate-based authentication in Microsoft Entra ID
description: Learn how admins can use advanced options for FIDO2 security keys and certificate-based authentication when they configure authentication strength requirements.

services: multi-factor-authentication
ms.service: active-directory
ms.subservice: authentication
ms.topic: conceptual
ms.date: 12/14/2023

ms.author: justinha
author: inbarckms
manager: amycolannino
ms.reviewer: inbarc

ms.collection: M365-identity-device-management
---
# Advanced options for Conditional Access authentication strength 

You can configure advanced options for authentication with FIDO2 security keys and certificates when you create a custom authentication strength. Advanced options allow you to further restrict sign in based upon specific properties of a FIDO2 security key or certificate. 

## FIDO2 security key advanced options
You can restrict the usage of some FIDO2 security keys based on their Authenticator Attestation GUIDs (AAGUIDs). The capability allows administrators to require a FIDO2 security key from a specific manufacture in order to access the resource. To require a specific FIDO2 security key, first complete the steps to create a [custom authentication strength](concept-authentication-strength-howitworks.md#custom-authentication-strengths). Then select **FIDO2 Security Key**, and click **Advanced options**. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot showing Advanced options.":::

Next to **Allowed FIDO2 Keys** click **+**, copy the AAGUID value, and click **Save**.

:::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot showing how to add an Authenticator Attestation GUID.":::


## Certificate-based authentication advanced options

You can configure whether certificates are bound in the system to single-factor or multifactor authentication protection levels, based on the certificate issuer or policy ID. You can also require single-factor or multifactor authentication certificates for specific resources, based on Conditional Access authentication strength policy.

Now you can require a specific certificate issuer or policy OID when users perform certificate-based authentication (CBA) to access sensitive resources. This advanced option controls access to sensitive resources that you only trust to users with certificates issued by specific issuers. 

For example, Contoso may issue three different types of multifactor certificates to employees by smart cards. They are distinguished by properties of the certificate, such as Policy OID or issuer:

- One for Confidential clearance
- One for Secret clearance
- One for Top Secret clearance 

Contoso wants to ensure that only users with the appropriate multifactor certificate can access data for each classification.  


1.	Go to https://entra.microsoft.com/?Microsoft_AAD_ConditionalAccess_showCbaAdvancedOptions=true# > Entra ID > Protect and Secure > Conditional Access > Authentication Strength 
2.	Click on New authentication Strength > provide a name > look for Certificate-based authentication (either single factor or multifactor) and click on the advanced setting underneath.



## Next steps

- [Overview](concept-authentication-strengths.md)
- [How authentication strength works](concept-authentication-strength-howitworks.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
