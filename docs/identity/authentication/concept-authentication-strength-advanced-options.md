---
title: Overview of authentication strength advanced options for FIDO2 security keys and certificate-based authentication in Microsoft Entra ID
description: Learn how admins can use advanced options for FIDO2 security keys and certificate-based authentication when they configure authentication strength requirements.

services: multi-factor-authentication
ms.service: active-directory
ms.subservice: authentication
ms.topic: conceptual
ms.date: 01/04/2024

ms.author: justinha
author: inbarckms
manager: amycolannino
ms.reviewer: inbarc

ms.collection: M365-identity-device-management
---
# Advanced options for Conditional Access authentication strength 

You can configure advanced options for authentication with FIDO2 security keys and certificate-based authentication (CBA) when you create a custom authentication strength. Advanced options allow you to further restrict sign in based upon specific properties of a FIDO2 security key or CBA. 

## FIDO2 security key advanced options
You can restrict the usage of FIDO2 security keys based on their Authenticator Attestation GUIDs (AAGUIDs). The capability allows administrators to require a FIDO2 security key from a specific manufacture in order to access the resource. To require a specific FIDO2 security key, first complete the steps to create a [custom authentication strength](concept-authentication-strengths.md#custom-authentication-strengths). Then select **FIDO2 Security Key**, and click **Advanced options**. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot showing Advanced options for FIDO2 security key.":::

Next to **Allowed FIDO2 Keys** click **+**, copy the AAGUID value, and click **Save**.

:::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot showing how to add an Authenticator Attestation GUID.":::


## Certificate-based authentication advanced options

You can configure whether certificates are bound in the system to single-factor or multifactor authentication protection levels, based on the certificate issuer or policy OID. You can also require single-factor or multifactor authentication certificates for specific resources, based on Conditional Access authentication strength policy.

By using advanced options, you can require a specific certificate issuer or policy OID when users perform certificate-based authentication (CBA) to access sensitive resources. 

For example, Contoso issues smart cards to employees with three different types of multifactor certificates. One certificate is for confidential clearance, another for secret clearance, and a third is for top secret clearance. Each one is distinguished by properties of the certificate, such as Policy OID or issuer. Contoso wants to ensure that only users with the appropriate multifactor certificate can access data for each classification.  

The next sections show how to configure advanced options for CBA by using the Microsoft Entra admin center and Microsoft Graph. 

### Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an Administrator.
1. Browse to **Protection** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Below Certificate-based authentication (either single-factor or multifactor), click **Advanced options**.

   :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certificate-advanced-options.png" alt-text="Screenshot showing Advanced options for certificate-based authentication.":::
    
1. Select certificate issuers from the drop- menu, or type the allowed policy OIDs. The drop-down menu lists all certificate authorities from the tenant irrespective of whether they're single-factor or multifactor.

   - If both **Allowed certificate issuer** AND **Allowed Policy OID** are configured, there's an AND relationship. The user has to use a certificate that satisfies both conditions.

     :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/and.png" alt-text="Screenshot showing AND condition.":::

   - Between the **Allowed certificate issuer** list and the **Allowed Policy OID** list, there's an OR relationship. The user has to use a certificate that satisfied one of the issuers or policy OIDs.

     :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/or.png" alt-text="Screenshot showing OR condition.":::

1. Use **Other certificate issuer by SubjectkeyIdentifier** if the certificate you would like to use is not uploaded to the **Certificate authorities** in your tenant. This setting can be used for external user scenarios, if the user is authenticating in their home tenant.


1. Click **Next** to review the configuration, then click **Create**.


### Microsoft Graph

To create a new Conditional Access authentication strength policy with Certificate combinationConfiguration:

```json
POST  /beta/identity/conditionalAccess/authenticationStrengths/policies
{
    "displayName": "CBA Restriction",
    "description": "CBA Restriction with both IssuerSki and OIDs ",
    "allowedCombinations": [
        " x509CertificateMultiFactor "
    ],
    "combinationConfigurations": [
        {
            "@odata.type": "#microsoft.graph.x509CertificateCombinationConfiguration",
            "appliesToCombinations": [
                "x509CertificateMultiFactor"
            ],
            "allowedIssuerSkis": ["9A4248C6AC8C2931AB2A86537818E92E7B6C97B6"],
            "allowedPolicyOIDs": [
                "1.2.3.4.6",
                "1.2.3.4.5.6"
            ]
        }
    ]
}
```

To add a new combinationConfiguration to an existing policy:

```json
POST beta/identity/conditionalAccess/authenticationStrength/policies/{authenticationStrengthPolicyId}/combinationConfigurations

{
    "@odata.type": "#microsoft.graph.x509CertificateCombinationConfiguration",
    "allowedIssuerSkis": [
        "9A4248C6AC8C2931AB2A86537818E92E7B6C97B6"
    ],
    "allowedPolicyOIDs": [],
    "appliesToCombinations": [
        "x509CertificateSingleFactor "
    ]
}
```

### Limitations

- Only one certificate can be used in each browser session. After you sign in with a certificate, it's cached in the browser for the duration of the session. You won't be prompted to choose another certificate if it doesn’t meet the authentication strength requirements. You need to sign out and sign back in to restart the session. Then choose the relevant certificate.

- Certificate Authorities and user certificates should conform to X.509 v3 standard. Specifically, to enforce issuer SKI CBA restrictions, certificates need valid AKIs:

  :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/authority-key-identifier.png" alt-text="Screenshot showing an authority key identifier.":::

  >[!NOTE]
  >If the certificate doesn't conform, user authentication might succeed, but not satisfy the issuerSki restrictions for the authentication strength policy.

- During sign-in, the first 5 policy OIDs from the end user certificate are considered, and compared with the Policy OIDs configured in the authentication strength policy. If the end user certificate has more than 5 Policy OIDs, the first 5 policy OIDs in lexical order that match the authentication strength requirements are taken into account. 

- For B2B users, let's take an example where Contoso has invited users from Fabrikam to their tenant. In this case, Contoso is the resource tenant and Fabrikam is the home tenant.
  - When cross-tenant access setting is **Off** – meaning when Contoso doesn't accept MFA that was performed by the home tenant. This use case isn't currently available. Using certificate-based authentication on the resource tenant isn't supported.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso are on the same Microsoft cloud – meaning, both Fabrikam and Contoso tenants are on the Azure commercial cloud or on the Azure for US Government cloud. In addition, Contoso trusts MFA that was performed on the home tenant. In this case:
    - Access to a specific resource can be restricted by using the policy OIDs in the custom authentication strength policy.
    - Access to specific resources cannot be restricted by using the Issuer ID in the custom authentication strength policy. It is on our roadmap, and we plan to enable this use case for public preview.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso aren't on the same Microsoft cloud – for example, Fabrikam’s tenant is on the Azure commercial cloud and Contoso’s tenant is on the Azure for US Government cloud – access to specific resources can't be restricted by using the Issuer ID or Policy OIDs in the custom authentication strength policy. This is on our roadmap and planned for public preview. 

### Check certificate policy OIDs and issuer

Sign in as an Administrator. Click **Run**, type certmgr.msc and press Enter. To check policy OIDs, click **Personal**, right-click the certificate and click **Details**.  

:::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certmgr.png" alt-text="Screenshot showing how to check certificate policy OIDs and issuer.":::

## Next steps

- [Overview](concept-authentication-strengths.md)
- [How authentication strength works](concept-authentication-strength-howitworks.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
