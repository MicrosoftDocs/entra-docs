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
You can restrict the usage of some FIDO2 security keys based on their Authenticator Attestation GUIDs (AAGUIDs). The capability allows administrators to require a FIDO2 security key from a specific manufacture in order to access the resource. To require a specific FIDO2 security key, first complete the steps to create a [custom authentication strength](concept-authentication-strengths.md#custom-authentication-strengths). Then select **FIDO2 Security Key**, and click **Advanced options**. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot showing Advanced options for FIDO2 security key.":::

Next to **Allowed FIDO2 Keys** click **+**, copy the AAGUID value, and click **Save**.

:::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot showing how to add an Authenticator Attestation GUID.":::


## Certificate-based authentication advanced options

You can configure whether certificates are bound in the system to single-factor or multifactor authentication protection levels, based on the certificate issuer or policy OID. You can also require single-factor or multifactor authentication certificates for specific resources, based on Conditional Access authentication strength policy.

By using advanced options, you can require a specific certificate issuer or policy OID when users perform certificate-based authentication (CBA) to access sensitive resources. 

For example, Contoso issues smart cards to employees with three different types of multifactor certificates. One certificate is for confidential clearance, another for secret clearance, and a third is for top secret clearance. Each one is distinguished by properties of the certificate, such as Policy OID or issuer. Contoso wants to ensure that only users with the appropriate multifactor certificate can access data for each classification.  


1. Go to https://entra.microsoft.com/?Microsoft_AAD_ConditionalAccess_showCbaAdvancedOptions=true# > Entra ID > Protect and Secure > Conditional Access > Authentication Strength 
1. Click on New authentication Strength > provide a name > look for Certificate-based authentication (either single-factor or multifactor) and click on the advanced setting underneath.

   :::image type="content" border="true" source="./media/concept-authentication-strengths/certificate-advanced-options.png" alt-text="Screenshot showing Advanced options for certificate-based authentication.":::
    
1. Select certificate issuers from the drop-down or type the allowed policy OIDs. 

   - If both **Allowed certificate issuer** AND **Allowed Policy OID** are configured, there's an AND relationship. The user has to use a certificate that satisfies both conditions.

     :::image type="content" border="true" source="./media/concept-authentication-strengths/and.png" alt-text="Screenshot showing AND condition.":::

   - Between the **Allowed certificate issuer** list and the **Allowed Policy OID** list, there's an OR relationship. The user has to use a certificate that satisfied one of the issuers or policy OIDs.

     :::image type="content" border="true" source="./media/concept-authentication-strengths/or.png" alt-text="Screenshot showing OR condition.":::

1. When finish click on “next”, review the configuration and click “Create”.

## Next steps

- [Overview](concept-authentication-strengths.md)
- [How authentication strength works](concept-authentication-strength-howitworks.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
