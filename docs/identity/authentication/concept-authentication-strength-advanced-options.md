---
title: Create and Manage Custom Conditional Access Authentication Strengths
description: Learn how admins can create custom authentication strengths with advanced options for passkey (FIDO2) security keys and certificate-based authentication.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 09/15/2025
ms.author: justinha
author: inbarckms
manager: dougeby
ms.reviewer: inbarc
ms.custom: sfi-image-nochange
---

# Create and manage custom Conditional Access authentication strengths

An authentication strength is a Microsoft Entra Conditional Access control that specifies combinations of authentication methods for access to a resource. As an administrator, you can create up to 15 custom authentication strengths to exactly suit your requirements.

## Prerequisites

- To use Conditional Access, your tenant needs to have Microsoft Entra ID P1 license. If you don't have this license, you can start a [free trial](https://www.microsoft.com/security/business/get-started/start-free-trial).

## Create a custom authentication strength

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Security Administrator](~/identity/role-based-access-control/permissions-reference.md#security-administrator).

1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.

1. Select **New authentication strength**.

1. For **Name**, provide a descriptive name for your new authentication strength.

1. For **Description**, you can provide an optional description.

1. Select the available methods that you want to allow, like those under **Phishing-resistant MFA**, **Passwordless MFA**, and **Temporary Access Pass**.

1. Select **Next** and review the policy configuration.

:::image type="content" border="true" source="media/concept-authentication-strengths/authentication-strength-custom.png" alt-text="Screenshot that shows the creation of a custom authentication strength.":::

## Update and delete custom authentication strengths

You can edit a custom authentication strength. If a Conditional Access policy references that authentication strength, you can't delete it, and you need to confirm any edit.

To check if a Conditional Access policy references an authentication strength, go to the **Conditional Access policies** column.

## Configure advanced options for passkeys (FIDO2)

You can restrict the usage of passkeys (FIDO2) based on their Authenticator Attestation GUIDs (AAGUIDs). You can use this capability to require a FIDO2 security key from a specific manufacturer for access to a resource. To require a specific FIDO2 security key:

1. After you create a custom authentication strength, select **Passkeys (FIDO2)** > **Advanced options**.

   :::image type="content" border="true" source="./media/concept-authentication-strengths/key.png" alt-text="Screenshot that shows the link for advanced options for passkeys (FIDO2).":::

1. Next to **Add AAGUID**, select the plus sign (**+**), copy the AAGUID value, and then select **Save**.

   :::image type="content" border="true" source="./media/concept-authentication-strengths/guid.png" alt-text="Screenshot that shows how to add an Authenticator Attestation GUID.":::

## Configure advanced options for certificate-based authentication

In the [authentication binding policy](how-to-certificate-based-authentication.md#step-3-configure-an-authentication-binding-policy), you can configure whether certificates are bound in the system to single-factor or multifactor authentication protection levels, based on the object identifier (OID) for the certificate issuer or policy. You can also require single-factor or multifactor authentication certificates for specific resources, based on a Conditional Access authentication strength policy.

By using advanced options for authentication strength, you can require a specific certificate issuer or policy OID to further restrict sign-ins to an application.

For example, assume that an organization named Contoso issues smart cards to employees with three different types of multifactor certificates. One certificate is for confidential clearance, another for secret clearance, and a third is for top-secret clearance. Each one is distinguished by properties of the certificate, such as policy OID or issuer. Contoso wants to ensure that only users who have the appropriate multifactor certificate can access data for each classification.

The next sections show how to configure advanced options for certificate-based authentication (CBA) by using the Microsoft Entra admin center and Microsoft Graph.

### Microsoft Entra admin center

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as an Administrator.

1. Browse to **Entra ID** > **Authentication methods** > **Authentication strengths**.

1. Select **New authentication strength**.

1. For **Name**, provide a descriptive name for your new authentication strength.

1. For **Description**, you can provide an optional description.

1. Below the option for certificate-based authentication (either single-factor or multifactor), select **Advanced options**.

   :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certificate-advanced-options.png" alt-text="Screenshot that shows the link for advanced options for certificate-based authentication.":::

1. Select or enter the certificate issuers, and enter the allowed policy OIDs.

   You can configure certificate issuers either by selecting them in the **Certificate issuers from the certificate authorities in your tenant** dropdown list. The dropdown menu lists all certificate authorities from the tenant,whether they're single-factor or multifactor.

   You can enter certificate issuers in the **Other Certificate Issuers by SubjectkeyIdentifier** box for scenarios where the certificate that you want to use is not uploaded to the certificate authorities in your tenant. One such example is external user scenarios, where the user could be authenticating in their home tenant and auth strength is being enforced on the resource tenant.

   :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/or-other-issuer.png" alt-text="Screenshot that shows the configuration options for certificate issuers and policy object identifiers.":::

   These conditions apply:

   - If you configure both attributes (certificate issuers and policy OIDs), the user must use a certificate that has at least one of the issuers *and* one of the policy OIDs from the list to satisfy the authentication strength.
   - If you configure only the certificate issuers attribute, the user must use a certificate that has at least one of the issuers to satisfy the authentication strength.
   - If you configure only the policy OIDs attribute, the user must use a certificate that has at least one of the policy OIDs to satisfy the authentication strength.

   > [!NOTE]
   > You can configure a maximum of five issuers and five OIDs for an authentication strength.

1. Select **Next** to review the configuration, and then select **Create**.

### Microsoft Graph

To create a new Conditional Access authentication strength policy by using `combinationConfigurations` for a certificate, use this code:

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

To add new `combinationConfiguration` information to an existing policy, use this code:

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

## Understand limitations

### Advanced options for passkeys (FIDO2)

Advanced options for passkeys (FIDO2) aren't supported for external users whose home tenant and resource tentant are located in a different Microsoft cloud services.

### Advanced options for certificate-based authentication

- A user can use only one certificate in each browser session. After the user signs in with a certificate, it's cached in the browser for the duration of the session. The user isn't prompted to choose another certificate if it doesn't meet the authentication strength requirements. The user needs to sign out and sign back in to restart the session, and then choose the relevant certificate.

- Certificate authorities and user certificates should conform to the X.509 v3 standard. Specifically, to enforce CBA restrictions for issuer subject key identifiers (SKIs), certificates need valid authority key identifiers (AKIs).

  :::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/subject-key-identifier.png" alt-text="Screenshot that shows an authority key identifier.":::

  > [!NOTE]
  > If the certificate doesn't conform, user authentication might succeed but not satisfy the issuer SKI restrictions for the authentication strength policy.

- During sign-in, the first five policy OIDs from the end user certificate are considered, and compared with the policy OIDs configured in the authentication strength policy. If the user certificate has more than five policy OIDs, Microsoft Entra ID takes into account the first five policy OIDs (in lexical order) that match the authentication strength requirements.

- For business-to-business users, let's take an example where Contoso invites users from another organization (Fabrikam) to its tenant. In this case, Contoso is the resource tenant and Fabrikam is the home tenant. Access dependson the cross-tenant access setting:
  - When cross-tenant access setting is **Off** (Contoso doesn't accept MFA that was performed by the home tenant) - Using certificate-based authentication on the resource tenant isn't supported.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso are on the same Microsoft cloud – meaning, both Fabrikam and Contoso tenants are on the Azure commercial cloud or on the Azure for US Government cloud. In addition, Contoso trusts MFA that was performed on the home tenant. In this case:
    - Access to a specific resource can be restricted by using the policy OIDs or the "other certificate issuer by SubjectkeyIdentifier" in the custom authentication strength policy.
    - Access to specific resources can be restricted by using the "Other certificate issuer by SubjectkeyIdentifier" setting in the custom authentication strength policy.
  - When cross-tenant access setting is **On**, Fabrikam and Contoso aren't on the same Microsoft cloud – for example, Fabrikam's tenant is on the Azure commercial cloud and Contoso's tenant is on the Azure for US Government cloud – access to specific resources can't be restricted by using the issuer ID or policy OIDs in the custom authentication strength policy.

## Troubleshoot advanced options for authentication strength

### Users can't use their passkey (FIDO2) to sign in

A Conditional Access Administrator can restrict access to specific security keys. When a user tries to sign in by using a key they can't use, this **You can't get there from here** message appears. The user has to restart the session, and sign-in with a different passkey (FIDO2).

:::image type="content" border="true" source="./media/troubleshoot-authentication-strengths/restricted-security-key.png" alt-text="Screenshot of a sign-in error when using a restricted passkey (FIDO2).":::

### How to check certificate policy OIDs and issuer

You can confirm the personal certificate properties match the configuration in authentication strength advanced options.

On the user's device, sign in as an Administrator. Click **Run**, type `certmgr.msc`, and press Enter. To check policy OIDs, click **Personal**, right-click the certificate and click **Details**.

:::image type="content" border="true" source="./media/concept-authentication-strength-advanced-options/certificate-manager-msc.png" alt-text="Screenshot that shows how to check certificate policy OIDs and issuer.":::

## Related content

- [Built-in Conditional Access authentication strengths](concept-authentication-strengths.md)
- [How authentication strength works for external users](concept-authentication-strength-external-users.md)
- [Troubleshoot authentication strengths](troubleshoot-authentication-strengths.md) 
