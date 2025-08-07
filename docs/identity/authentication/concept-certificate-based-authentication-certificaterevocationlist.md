---
title: Microsoft Entra certificate-based authentication Certificate revocation list
description: Learn how certificate revocation list works with Microsoft Entra certificate-based authentication
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 03/04/2025
ms.author: justinha
author: vimrang
manager: dougeby
ms.reviewer: vranganathan
ms.custom: has-adal-ref, sfi-image-nochange
ms.localizationpriority: high
---

# Microsoft Entra certificate-based authentication Certificate Revocation List (CRL)

## Overview
Certificate Revocation List (CRL) is a list of certificates that have been revoked by the issuing Certificate Authority (CA) before their scheduled expiration date. In the context of Microsoft Entra certificate-based authentication, 
CRLs are used to ensure that only valid certificates are accepted for authentication purposes.

CRLs are essential for maintaining the security and integrity of the authentication process. When a certificate is revoked, it means that it is no longer considered trustworthy, and any authentication attempts using that certificate should be denied.

CRLs are typically published by the CA and can be accessed during the authentication process. When a client presents a certificate for authentication, the system checks the CRL to determine if the certificate has been revoked. 
If the certificate is found in the CRL, the authentication attempt is rejected. CRLs are usually updated periodically, and organizations should ensure they have the latest version of the CRL to make accurate decisions about 
certificate validity. In Microsoft Entra certificate-based authentication (CBA), the system automatically retrieves and checks the CRL as part of the authentication process.


## How CRL works in certificate-based authentication

CRL works by providing a mechanism to check the validity of certificates used for authentication. The process involves several key steps:

- **Certificate Issuance:** When a certificate is issued by a CA, it is valid until its expiration date unless it is revoked earlier. Each certificate contains a public key and is signed by the CA.
- **Revocation:** If a certificate needs to be revoked (for example, if  the private key is compromised or the certificate is no longer needed), the CA adds it to the CRL.
- **CRL Distribution:** The CA publishes the CRL to a location accessible by clients, such as a web server or a directory service. The CRL is typically signed by the CA to ensure its integrity.
- **Client Check:** When a client presents a certificate for authentication, the system retrieves the CRL from the CA's published location. The system checks the presented certificate against the CRL to determine if it has been revoked.
- **Authentication:** If the certificate is found in the CRL, the authentication  attempt is rejected, and the client is denied access. If the certificate is not in the CRL, the authentication proceeds as normal.
- **CRL Updates:** The CRL is updated periodically by the CA, and clients should ensure they have the latest version to make accurate decisions about certificate validity. The system does cache the CRL for a certain period to reduce network traffic and improve performance, but it does also check for updates regularly.

## Understanding the certificate revocation process in Entra certificate-based authentication

The certificate revocation process allows Authentication Policy Administrators to revoke a previously issued certificate from being used for future authentication. 

Authentication Policy Administrators can configure the CRL distribution point during the setup process of the trusted issuers in the Microsoft Entra tenant. Each trusted issuer should have a CRL that can be referenced by using an internet-facing URL.
 
>[!IMPORTANT]
>The maximum size of a CRL for Microsoft Entra ID to successfully download on an interactive sign-in and cache is 20 MB in public Microsoft Entra ID and 45 MB in Azure US Government clouds, and the time required to download the CRL must not exceed 10 seconds. If Microsoft Entra ID can't download a CRL, certificate-based authentications using certificates issued by the corresponding CA fail. As a best practice to keep CRL files within size limits, keep certificate lifetimes within reasonable limits and to clean up expired certificates.

1. When a user performs an interactive sign-in with a certificate, Microsoft Entra ID downloads and caches the customers certificate revocation list (CRL) from their certificate authority to check if certificates are revoked during the authentication of the user. Microsoft Entra will use SubjectKeyIdentifier attribute over SubjectName for CA matching. Admin should make sure all CAs have a valid SKI and AKI attribute.

>[!IMPORTANT]
>If an Authentication Policy Administrator skips the configuration of the CRL, Microsoft Entra ID doesn't perform any CRL checks during the certificate-based authentication of the user. This can be helpful for initial troubleshooting, but shouldn't be considered for production use.

2. Base CRL Only: If only the base CRL is configured, Entra downloads and caches it until the Next Update timestamp. Authentication will fail if the CRL expires and cannot be refreshed due to connectivity issues. 

3. Base + Delta CRL: When both are configured, both must be valid and accessible. If either is missing or expired, certificate validation fails per RFC 5280 standards.

4. The user certificate-based authentication fails if a CRL is configured for the trusted issuer and Microsoft Entra ID can't download the CRL, due to availability, size, or latency constraints.

5. If the CRL exceeds the interactive limit for a cloud, the user's initial sign-in fails with the following error:

    "The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Microsoft Entra ID. Try again in few minutes. If the issue persists, contact your tenant administrators."

6. Microsoft Entra ID would attempt to download the CRL subject to the service-side limits (45 MB in public Microsoft Entra ID and 150 MB in Azure US Government clouds).

7. User can retry the authentication after few minutes. If the user's certificate is revoked and appears in the CRL the authentication will fail.

>[!IMPORTANT]
>The certificate revocation won't revoke already issued tokens of the user. Follow the steps to manually revoke tokens at [Configure revocation](./certificate-based-authentication-federation-get-started.md#step-3-configure-revocation).

8. As of now, we don't support Online Certificate Status Protocol (OCSP) because of performance and reliability reasons. Instead of downloading the CRL at every connection by the client browser for OCSP, Microsoft Entra ID downloads once at the first sign-in and caches it. This action improves the performance and reliability of CRL verification. We also index the cache so the search is much faster every time. Customers must publish CRLs for certificate revocation.
The following steps are a typical flow of the CRL check:

9. If there are no issues and Micrsoft Entra successfully downloads the CRL, it will cache and reuse the CRL for any subsequent usage. It honors the **Next update date** and, if available, **Next CRL Publish date** (used by Windows Server CAs) in the CRL document.

10. If the user's certificate is listed as revoked on the CRL, user authentication will fail.
   
     :::image type="content" border="true" source="./media/concept-certificate-based-authentication-crl/user-cert.png" alt-text="Screenshot of the revoked user certificate in the CRL." ::: 

>[!IMPORTANT]
>Due to the nature of CRL caching and publishing cycles, it's highly recommended that, if there's a certificate revocation, to also revoke all sessions of the affected user in Microsoft Entra ID.

11. Microsoft Entra ID attempts to download a new CRL from the distribution point if the cached CRL document is expired. As of now, there's no way to manually force or retrigger the download of the CRL.

>[!NOTE]
>Microsoft Entra ID checks the CRL of the issuing CA and other CAs in the PKI trust chain up to the root CA. We have a limit of up to 10 CAs from the leaf client certificate for CRL validation in the PKI chain. The limitation is to make sure a bad actor doesn't bring down the service by uploading a PKI chain with a huge number of CAs with a bigger CRL size.
If the tenant's PKI chain has more than 10 CAs, and if there's a CA compromise, Authentication Policy Administrators should remove the compromised trusted issuer from the Microsoft Entra tenant configuration.
  

### How to configure revocation

[!INCLUDE [Configure revocation](../../includes/entra-authentication-configure-revocation.md)]

## Enforcing CRL validation for CAs

When CAs are uploaded to the Microsoft Entra trust store, a CRL, or more specifically the CrlDistributionPoint attribute, isn't required. A CA can be uploaded without a CRL endpoint, and certificate-based authentication won't fail if an issuing CA doesn't have a CRL specified. 

To strengthen security and avoid misconfigurations, an Authentication Policy Administrator can require CBA authentication to fail if no CRL is configured for a CA that issues an end user certificate.

### Enable CRL validation

1. To enable CRL validation, select **Require CRL validation (recommended)**. 

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-crl/require-validation.png" alt-text="Screenshot of how to require CRL validation." :::  

Once enabled, any CBA fail is because the end user certificate was issued by a CA with no CRL configured.

2. An Authentication Policy Administrator can exempt a CA if its CRL has issues that should be fixed. Select **Add Exemption** and select any CAs that should be exempted.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-crl/exempt-validation.png" alt-text="Screenshot of how to exempt CAs from CRL validation." :::  

3. The CAs in the exempted list aren't required to have CRL configured and the end-user certificates that they issue don't fail authentication.

Select CAs and select **Add**. The **Search** text box can be used to filter the CA lists to select specific CAs.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-crl/exempted.png" alt-text="Screenshot of CAs that are exempted from CRL validation." ::: 


## Testing CRL 

1. Use the Public Key Infrastructure (Preview) blade to view and manage all uploaded CAs. This interface supports dynamic loading of large CA lists and bulk updates. 
1. Ensure CRL endpoints are publicly accessible. Entra ID cannot validate certificates if CRLs are hosted on internal-only servers. Validate CRL accessibility by testing the CRL URL in a browser and using certutil -url for distribution checks.
1. Use [EntraUserCBAAuthorizationInfo PowerShell commandlets](./concept-certificate-based-authentication-certificateuserids.md#how-to-find-the-correct-certificateuserids-values-for-a-user-from-the-end-user-certificate-using-powershell-module) to extract certificate binding values for accurate configuration of CertificateUserIds.

## Troubleshooting CRL issues

**Microsoft Entra Certificate-Based Authentication (CBA) – CRL Error Reference Table**

| Error Code / Message                             | Description                                           | Common Causes                                                                                                   | Recommended Actions                                                                                                                                                      |
|--------------------------------------------------|-------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **AADSTS500171: Certificate has been revoked.**         | Certificate is in the CRL.              |                        |   If a certificate was mistakenly included in the CRL, the issuing Certificate Authority (CA) should reissue the CRL with an updated list that accurately reflects the intended revocations.      |
| **AADSTS500172: Certificate '{name}' issued by '{issuer}' is not valid. Current time: '{curTime}'. Certificate NotBefore: '{startTime}'. Certificate NotAfter: '{endTime}'.**         | CRL is not valid in time.              |                        |         |
| **AADSTS500173: Unable to download CRL. Invalid status code {code} from CRL distribution point.**         | CRL could not be downloaded due to endpoint issues.  | - CRL endpoint returns HTTP errors (e.g., 403)<br>- CRL expired with no update                                  | - Confirm endpoint returns valid data<br>- Ensure CA regularly publishes updated CRLs<br>- Enable CRL fail-safe to block unverifiable certificates                       |
| **AADSTS500174: Unable to construct valid CRL from response.**         |              |                        |         |
| **AADSTS500175: Unable to find expected CrlSegment.**         |               |                        |         |
| **AADSTS500176: Cannot find issuing certificate in trusted certificates list.**         |               |                        |         |
| **AADSTS500177: Delta CRL distribution point is configured without a corresponding CRL distribution point.**         |               |                        |         |
| **AADSTS500178: Unable to retrieve valid CRL segments for {type}. Please try again later.**         |               |                        |         |
| **AADSTS500179: CRL validation timed out. Please try again later.** | CRL download timed out or was interrupted.           | - CRL size exceeds limits<br>- Network latency or instability                                                   | - Keep CRL size under 20MB (commercial) or 45MB (US Gov)<br>- Set `Next Update` interval to at least one week<br>- Monitor CRL download performance via sign-in logs     |
| **AADSTS500183: Certificate has been revoked on iOS and Android.**         |              |                        |         |
| **AADSTS2205011: The downloaded contents are not a valid ASN-Encoded Certificate Revocation List (CRL). Contact your IT Administrator and have them verify the CRL Distribution Point configured in the directory is responding with a valid ASN-encoded CRL.**         |              |                        |         |
| **AADSTS2205012: CRL download timed out.**         |              |                        |         |
| **AADSTS2205013: CRL download not allowed.**         |              |                        |         |
| **AADSTS2205014: The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Azure Active Directory. Please request your tenant administrators to reduce the size of the CRL and try again.**         |              |                        |         |
| **AADSTS2205015: The Certificate Revocation List (CRL) failed signature validation. Expected Subject Key Identifier {expectedSKI} does not match CRL Authority Key {crlAK}. Please request your tenant administrator to check the CRL configuration.**         |              |                        |         |
| **AADSTS7000214: Certificate has been revoked.**         |   Certificate has been revoked.           | - Certificate listed in CRL           | - Replace revoked certificate<br>- Investigate revocation reason with CA<br>- Monitor certificate lifecycle and renewal       |


## Frequently asked questions

1. **Is there a limit for CRL size?**
        
    The following CRL size limits apply: 

    - Interactive sign in download limit: 20 MB (Azure Global includes GCC), 45 MB for (Azure US government, includes GCC High, Dept. of Defense)
    - Service download limit: 65 MB (Azure Global includes GCC), 150 MB for (Azure US government, includes GCC High, Dept. of Defense)

    When a CRL download fails, the following message appears: 
    
    "The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Microsoft Entra ID. Try again in few minutes. If the issue persists, contact your tenant administrators."
    
    Download remains in the background with higher limits.

    We're reviewing the impact of these limits and have plans to remove them.

2. **I see a valid Certificate Revocation List (CRL) endpoint set, but why don't I see any CRL revocation?**
    
    - Make sure the CRL distribution point is set to a valid HTTP URL.
    - Make sure the CRL distribution point is accessible via an internet-facing URL.
    - Make sure the CRL sizes are within limits. 

3. **How do I instantly revoke a certificate?**
        
    Follow the steps to [manually revoke a certificate](./certificate-based-authentication-federation-get-started.md#step-3-configure-revocation). 

 4. **How can I turn certificate revocation checking on or off for a particular CA?**
        
    We highly recommend against disabling certificate revocation list (CRL) checking as you won't be able to revoke certificates. 
    However, if you need to investigate issues with CRL checking, you can exempt a CA from CRL checking in the Microsoft Entra admin center. 
    In the CBA Authentication methods policy, click **Configure** and then click **Add exemption**. Choose the CA that you want to exempt, and click **Add**. 

5. **After a CRL endpoint is configured, end users aren't able to sign in and they see the following diagnostic message: AADSTS500173: Unable to download CRL. Invalid status code Forbidden from CRL distribution point.** 

    This is commonly seen when a firewall rule setting blocks access to the CRL endpoint. 

## Next steps

- [Overview of Microsoft Entra CBA](concept-certificate-based-authentication.md)
- [How to configure Microsoft Entra CBA](how-to-certificate-based-authentication.md)
- [Microsoft Entra CBA on iOS devices](concept-certificate-based-authentication-mobile-ios.md)
- [Microsoft Entra CBA on Android devices](concept-certificate-based-authentication-mobile-android.md)
- [Windows smart card logon using Microsoft Entra CBA](concept-certificate-based-authentication-smartcard.md)
- [Certificate user IDs](concept-certificate-based-authentication-certificateuserids.md)
- [How to migrate federated users](concept-certificate-based-authentication-migration.md)
- [FAQ](certificate-based-authentication-faq.yml)
- [Troubleshoot Microsoft Entra CBA](./certificate-based-authentication-faq.yml)

