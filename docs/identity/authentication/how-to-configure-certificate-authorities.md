---
title: How to configure certificate authorities for Microsoft Entra certificate-based authentication
description: Topic that shows how to configure certificate authorities for Microsoft Entra certificate-based authentication.
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 07/02/2025
ms.author: justinha
author: vimrang
manager: dougeby
ms.reviewer: vraganathan
ms.custom: has-adal-ref, has-azure-ad-ps-ref, sfi-ga-nochange
---
# How to configure certificate authorities for Microsoft Entra certificate-based authentication

The best way to configure the certificate authorities (CAs) is with the PKI-based trust store. You can delegate configuration with a PKI-based trust store to least privileged roles. For more information see, [Step 1: Configure the certificate authorities with PKI-based trust store](how-to-certificate-based-authentication.md#step-1-configure-the-certificate-authorities-with-pki-based-trust-store).

As an alternative, a Global Administrator can follow steps in this topic to configure CAs by using the Microsoft Entra admin center, or Microsoft Graph REST APIs and the supported software development kits (SDKs), such as Microsoft Graph PowerShell. 

[!INCLUDE [least-privilege-note](../../includes/definitions/least-privilege-note.md)]

The public key infrastructure (PKI) infrastructure or PKI admin should be able to provide the list of issuing CAs. 

To make sure you configured all the CAs, open the user certificate and click **Certification path** tab. 
Make sure every CA until the root is uploaded to the Microsoft Entra ID trust store. 
Microsoft Entra certificate-based authentication (CBA) fails if there are missing CAs.

### Configure certificate authorities using the Microsoft Entra admin center

To configure certificate authorities to enable CBA in the Microsoft Entra admin center, complete the following steps:

[!INCLUDE [least-privilege-note](../../includes/definitions/least-privilege-note.md)]

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as a [Global Administrator](~/identity/role-based-access-control/permissions-reference.md#global-administrator).
1. Browse to **Entra ID** > **Identity Secure Score** > **Certificate authorities**.
1. To upload a CA, select **Upload**: 
   1. Select the CA file.
   1. Select **Yes** if the CA is a root certificate, otherwise select **No**.
   1. For **Certificate Revocation List URL**, set the internet-facing URL for the CA base CRL that contains all revoked certificates. If the URL isn't set, authentication with revoked certificates doesn't fail.
   1. For **Delta Certificate Revocation List URL**, set the internet-facing URL for the CRL that contains all revoked certificates since the last base CRL was published.
   1. Select **Add**.

      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/upload-certificate-authority.png" alt-text="Screenshot of how to upload certificate authority file.":::

1. To delete a CA certificate, select the certificate and select **Delete**.
1. Select **Columns** to add or delete columns.

> [!NOTE]
> Upload of a new CA fails if any existing CA expired. You should delete any expired CA, and retry to upload the new CA.

### Configure certificate authorities (CA) using PowerShell

Only one CRL Distribution Point (CDP) for a trusted CA is supported. The CDP can only be HTTP URLs. Online Certificate Status Protocol (OCSP) or Lightweight Directory Access Protocol (LDAP) URLs aren't supported.

[!INCLUDE [Configure certificate authorities](~/includes/entra-authentication-configure-certificate-authorities.md)]

### Connect

[!INCLUDE [Connect-AzureAD](~/includes/entra-authentication-connect.md)]

### Retrieve

[!INCLUDE [Get-AzureAD](~/includes/entra-authentication-get-trusted.md)]
### Add

>[!NOTE]
>Upload of new CAs will fail when any of the existing CAs are expired. Tenant Admin should delete the expired CAs and then upload the new CA.

Follow the preceding steps to add a CA in the Microsoft Entra admin center. 

**AuthorityType**
- Use 0 to indicate a Root certificate authority
- Use 1 to indicate an Intermediate or Issuing certificate authority

**crlDistributionPoint**

Download the CRL and compare the CA certificate and the CRL information. Make sure the crlDistributionPoint value in the preceding PowerShell example is valid for the CA you want to add.

The following table and graphic show how to map information from the CA certificate to the attributes of the downloaded CRL.

| CA Certificate Info |= |Downloaded CRL Info|
|----|:-:|----|
|Subject |=|Issuer |
|Subject Key Identifier |=|Authority Key Identifier (KeyID) |

:::image type="content" border="false" source="./media/how-to-certificate-based-authentication/certificate-crl-compare.png" alt-text="Compare CA Certificate with CRL Information.":::

>[!TIP]
>The value for crlDistributionPoint in the preceding example is the http location for the CA’s Certificate Revocation List (CRL). This value can be found in a few places:
>
>- In the CRL Distribution Point (CDP) attribute of a certificate issued from the CA.
>
>If the issuing CA runs Windows Server:
>
>- On the [Properties](/windows-server/networking/core-network-guide/cncg/server-certs/configure-the-cdp-and-aia-extensions-on-ca1#to-configure-the-cdp-and-aia-extensions-on-ca1)
 of the CA in the certificate authority Microsoft Management Console (MMC).
>- On the CA by running `certutil -cainfo cdp`. For more information, see [certutil](/windows-server/administration/windows-commands/certutil#-cainfo).

For more information, see [Understanding the certificate revocation process](./concept-certificate-based-authentication-certificaterevocationlist.md#enforcing-crl-validation-for-cas).

### Configure certificate authorities using the Microsoft Graph APIs

Microsoft Graph APIs can be used to configure certificate authorities. To update the Microsoft Entra Certificate Authority trust store, follow the steps at [certificatebasedauthconfiguration MSGraph commands](/graph/api/resources/certificatebasedauthconfiguration).

### Validate Certificate Authority configuration

Make sure the configuration allows Microsoft Entra CBA to: 

- Validate the CA trust chain
- Get the certificate revocation list (CRL) from the configured certificate authority CRL distribution point (CDP) 

To validate the CA configuration, install the [MSIdentity Tools](https://azuread.github.io/MSIdentityTools/) PowerShell module, and run [Test-MsIdCBATrustStoreConfiguration](https://github.com/AzureAD/MSIdentityTools/wiki/Test-MsIdCBATrustStoreConfiguration). 
This PowerShell cmdlet reviews the Microsoft Entra tenant CA configuration. 
It reports errors and warnings for common misconfigurations. 

## Related content

[How to configure Microsoft Entra certificate-based authentication](how-to-certificate-based-authentication.md)

