---
title: Overview of custom authentication strengths and advanced options for FIDO2 security keys and certificate-based authentication in Microsoft Entra ID
description: Learn how admins can create custom authentication strengths with advanced options for FIDO2 security keys and certificate-based authentication.
ms.service: entra-id
ms.subservice: authentication
ms.topic: conceptual
ms.date: 03/04/2025
ms.author: justinha
author: inbarckms
manager: femila
ms.reviewer: inbarc
ms.custom: sfi-image-nochange
---
# Custom Conditional Access authentication strengths

Administrators can also create up to 15 of their own custom authentication strengths to exactly suit their requirements. A custom authentication strength can contain any of the supported combinations in the preceding table. 

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an Administrator.
1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Select any of the available methods you want to allow.
1. Choose **Next** and review the policy configuration.

   :::image type="content" border="true" source="media/concept-authentication-strengths/authentication-strength-custom.png" alt-text="Screenshot showing the creation of a custom authentication strength.":::

#### Update and delete custom authentication strengths

You can edit a custom authentication strength. If it's referenced by a Conditional Access policy, it can't be deleted, and you need to confirm any edit. 
To check if an authentication strength is referenced by a Conditional Access policy, click the **Conditional Access policies** column.


## FIDO2 security key advanced options
You can restrict the usage of FIDO2 security keys based on their Authenticator Attestation GUIDs (AAGUIDs). This capability allows administrators to require a FIDO2 security key from a specific manufacturer in order to access the resource. To require a specific FIDO2 security key, first create a custom authentication strength. Then select **FIDO2 Security Key**, and click **Advanced options**. 

:::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot showing Advanced options for FIDO2 security key.":::

Next to **Allowed FIDO2 Keys** click **+**, copy the AAGUID value, and click **Save**.

:::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot showing how to add an Authenticator Attestation GUID.":::


## Certificate-based authentication advanced options

In the [Authentication methods policy](how-to-certificate-based-authentication.md#step-3-configure-authentication-binding-policy), you can configure whether certificates are bound in the system to single-factor or multifactor authentication protection levels, based on the certificate issuer or policy OID. You can also require single-factor or multifactor authentication certificates for specific resources, based on Conditional Access authentication strength policy.

By using authentication strength advanced options, you can require a specific certificate issuer or policy OID to further restrict sign-ins to an application. 

For example, Contoso issues smart cards to employees with three different types of multifactor certificates. One certificate is for confidential clearance, another for secret clearance, and a third is for top secret clearance. Each one is distinguished by properties of the certificate, such as policy OID or issuer. Contoso wants to ensure that only users with the appropriate multifactor certificate can access data for each classification.  

The next sections show how to configure advanced options for CBA by using the Microsoft Entra admin center and Microsoft Graph. 

### Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an Administrator.
1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.
1. Select **New authentication strength**.
1. Provide a descriptive **Name** for your new authentication strength.
1. Optionally provide a **Description**.
1. Below Certificate-based authentication (either single-factor or multifactor), click **Advanced options**.

   :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certificate-advanced-options.png" alt-text="Screenshot showing Advanced options for certificate-based authentication.":::
    
1. You can select certificate issuers from the drop-down menu, type the certificate issuers and type the allowed policy OIDs. The drop-down menu lists all certificate authorities from the tenant irrespective of whether they're single-factor or multifactor. Certificate issuers can be configured either by using the drop down **Certificate issuers from the certificate authorities in your tenant** or by using **Other certificate issuer by SubjectkeyIdentifier** for scenarios where the certificate you would like to use is not uploaded to the Certificate authorities in your tenant. One such example is external user scenarios, where the user could be authenticating in their home tenant and auth strength is being enforced on the resource tenant.

   :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/or-other-issuer.png" alt-text="Screenshot showing the configuration options - certificate issuers from the drop-down menu, type the certificate issuers and type the allowed policy OIDs .":::

   - If both attributes Certificate issuers AND  Policy OIDs are configured, there's a AND relationship and the user has to use a certificate that has atleast one of the issuers AND one of the policy OID from the list to satisfy the authentication strength.
   - If only Certificate issuers attribute is configured then the user has to use a certificate that has atleast one of the issuers to satisfy the authentication strength .
   - If only Policy OIDs attribute is configured then the user has to use a certificate that has atleast one of the policy OIDs to satisfy the authentication strength.

  >[!NOTE]
  > We allow a max of 5 issuers and 5 OIDs to be configured in authentication strengths configuration.

1. Click **Next** to review the configuration, then click **Create**.

### Microsoft Graph

To create a new Conditional Access authentication strength policy with certificate combinationConfiguration:

```json
POST  /beta/identity/conditionalAccess/authenticationStrength/policies
{
    "displayName": "CBA Restriction",
    "description": "CBA Restriction with both IssuerSki and OIDs",
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

## Limitations

### FIDO2 security key advanced options
- FIDO2 security key Advanced options - Advanced options aren't supported for external users with a home tenant that is located in a different Microsoft cloud than the resource tenant.

### Certificate-based authentication advanced options

- Only one certificate can be used in each browser session. After you sign in with a certificate, it's cached in the browser for the duration of the session. You won't be prompted to choose another certificate if it doesn’t meet the authentication strength requirements. You need to sign out and sign back in to restart the session. Then choose the relevant certificate.

- Certificate Authorities and user certificates should conform to the X.509 v3 standard. Specifically, to enforce issuer SKI CBA restrictions, certificates need valid AKIs:

  :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/subject-key-identifier.png" alt-text="Screenshot showing an authority key identifier.":::

  >[!NOTE]
  >If the certificate doesn't conform, user authentication might succeed, but not satisfy the issuerSki restrictions for the authentication strength policy.

- During sign-in, the first 5 policy OIDs from the end user certificate are considered, and compared with the policy OIDs configured in the authentication strength policy. If the end user certificate has more than 5 policy OIDs, the first 5 policy OIDs in lexical order that match the authentication strength requirements are taken into account. 

- For B2B users, let's take an example where Contoso has invited users from Fabrikam to their tenant. In this case, Contoso is the resource tenant and Fabrikam is the home tenant.
  - When cross-tenant access setting is **Off** (Contoso doesn't accept MFA that was performed by the home tenant) - Using certificate-based authentication on the resource tenant isn't supported.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso are on the same Microsoft cloud – meaning, both Fabrikam and Contoso tenants are on the Azure commercial cloud or on the Azure for US Government cloud. In addition, Contoso trusts MFA that was performed on the home tenant. In this case:
    - Access to a specific resource can be restricted by using the policy OIDs or the "other certificate issuer by SubjectkeyIdentifier" in the custom authentication strength policy.
    - Access to specific resources can be restricted by using the "Other certificate issuer by SubjectkeyIdentifier" setting in the custom authentication strength policy.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso aren't on the same Microsoft cloud – for example, Fabrikam’s tenant is on the Azure commercial cloud and Contoso’s tenant is on the Azure for US Government cloud – access to specific resources can't be restricted by using the issuer ID or policy OIDs in the custom authentication strength policy. 

## Troubleshooting  authentication strength advanced options

### Users can't use their FIDO2 security key to sign in
A Conditional Access Administrator can restrict access to specific security keys. When a user tries to sign in by using a key they can't use, this **You can't get there from here** message appears. The user has to restart the session, and sign-in with a different FIDO2 security key.

:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/restricted-security-key.png" alt-text="Screenshot of a sign-in error when using a restricted FIDO2 security key.":::


### How to check certificate policy OIDs and issuer

You can confirm the personal certificate properties match the configuration in authentication strength advanced options.
On the user’s device, sign in as an Administrator. Click **Run**, type `certmgr.msc`, and press Enter. To check policy OIDs, click **Personal**, right-click the certificate and click **Details**.  

:::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certificate-manager-msc.png" alt-text="Screenshot showing how to check certificate policy OIDs and issuer.":::

## Next steps

- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
