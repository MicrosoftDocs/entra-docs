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


## Guidance for Setting Up CRLs (Base and Delta CRL) for Microsoft Entra ID

1. Publish Accessible CRLs: 
- Ensure your Certificate Authority (CA) publishes both the base CRL and delta CRLs (if applicable) to internet-facing URLs accessible via HTTP. 
- Entra ID cannot validate certificates if CRLs are hosted on internal-only servers. The URLs should be highly available, performant, and resilient to prevent authentication failures due to unavailability. 
- Validate CRL accessibility by testing the CRL URL in a browser and using certutil -url for distribution checks.

2. Configure CRL URLs in Microsoft Entra ID: 
- Upload the CA public certificate to Microsoft Entra ID and configure the CRL distribution points (CDPs). 
- Base CRL URL: Contains all revoked certificates.
- Delta CRL URL (optional but recommended): Contains certificates revoked since the last base CRL was published.
- Use tools like certutil to verify CRL validity and troubleshoot certificate and CRL issues locally.


3.  Set Validity Periods
- Set the base CRL validity period long enough to balance operational overhead and security (typically days to weeks).
- Set the delta CRL validity period shorter (commonly 24 hours) to allow for timely recognition of revoked certificates.
- Shorter delta CRL validity improves security by reducing the window where revoked certificates remain valid but increases issuance and distribution load.
- The recommended 24-hour default validity for delta CRLs on Windows Servers is a widely accepted standard balancing security and performance.
- Entra ID is designed to efficiently handle frequent delta CRL updates without performance degradation, and ongoing improvements help enhance this further. 
- Entra ID applies throttling mechanisms to protect against DDoS attacks during delta CRL downloads, which can result in temporary errors like "AADSTS2205013" for a small subset of users.

4. Ensure High Availability & Performance
- Host CRLs on reliable web servers or content delivery networks (CDNs) to minimize delays or failures during retrieval.
- Monitor CRL publication and accessibility proactively.

5. Protect Against Throttling & DDoS
- To protect Entra ID services and users, throttling is applied to CRL fetch operations during high load or potential abuse.
- Schedule CRL publication and expiration cycles during off-peak hours to minimize the likelihood of throttling impacting users.

6. CRL Size Management
- Keep CRL payloads as small as possible, ideally by frequent delta CRL issuance and archival of old entries, to improve fetch speed and reduce bandwidth.

7. Enable CRL Validation
- Enforce CRL validation in Microsoft Entra ID policies to ensure revoked certificates are detected. [Enable CRL validation](./concept-certificate-based-authentication-certificaterevocationlist.md#Enable CRL validation)
- Consider temporary bypass of CRL checking only as a last resort during troubleshooting, with understanding of the security risks.

8. Test and Monitor
- Perform regular tests to verify that CRLs are downloadable and recognized correctly by Entra ID.
- Use monitoring to detect and quickly remediate any CRL availability or validation issues.

## Troubleshooting CRL issues

**Microsoft Entra Certificate-Based Authentication (CBA) – CRL Error Reference Table**

| Error Code / Message                             | Description                                           | Common Causes                                                                                                   | Recommended Actions                                                                                                                                                      |
|--------------------------------------------------|-------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **AADSTS500171: Certificate has been revoked. Please contact your administrator.**         | Certificate is in the CRL indicating its revoked              |     Certificate is revoked by the admin                   |   If a certificate was mistakenly included in the CRL, the issuing Certificate Authority (CA) should reissue the CRL with an updated list that accurately reflects the intended revocations      |
| **AADSTS500172: Certificate '{name}' issued by '{issuer}' is not valid. Current time: '{curTime}'. Certificate NotBefore: '{startTime}'. Certificate NotAfter: '{endTime}'.**         | CRL is not valid in time.              |           The CRLs or delta CRLs used to validate the certificate have timing issues such as expired CRLs or incorrectly configured publication/validity times.             |    - Confirm that the certificate’s "Not Before" and "Not After" dates properly encompass the current time.<br/> - Verify that the base and delta CRLs published by your Certificate Authority (CA) are not expired.    |
| **AADSTS500173: >Unable to download a Certificate Revocation List (CRL). Invalid status code {code} from CRL distribution point. Please contact your administrator.**         | CRL could not be downloaded due to endpoint issues.  | - CRL endpoint returns HTTP errors (e.g., 403)<br>- CRL expired with no update                                  | - Confirm endpoint returns valid data<br>- Ensure CA regularly publishes updated CRLs<br>- Enable CRL fail-safe to block unverifiable certificates                       |
| **AADSTS500174: Unable to construct valid Certificate Revocation List (CRL) from response.**         |        Microsoft Entra ID cannot parse or use the CRL retrieved from the specified distribution point.      |   -  The CRL URL is inaccessible due to network issues, firewall blocks, or server downtime.  <br/> - The downloaded CRL file is corrupted, incomplete, or incorrectly formatted.<br/> -  The URLs in the certificate’s CDP fields do not point to valid CRL files or are misconfigured.        |    - Verify CRL Accessibility, Validity,  and Integrity. <br/> -  Inspect the CRL file for corruption or incomplete content.   |
| **AADSTS500175: Revocation check failed because the Certificate Revocation List (CRL) for one certificate in the chain is missing.**         |    During certificate revocation checking, Entra could not locate a required segment or portion of the Certificate Revocation List (CRL).            |     - The CRL file downloaded from the CRL Distribution Point (CDP) is corrupted or truncated.<br/> - Incorrect or incomplete publication of the CRL by the Certificate Authority (CA).<br/> - Network issues causing incomplete or failed CRL downloads.<br/> - Misconfiguration of the CRL distribution point URLs or file segments.                    |   - Verify CRL Integrity<br/> - Republish or Regenerate CRL <br/> - Check Network and Proxy Settings <br/> - Ensure Correct CDP Configuration on all the CAs      |
| **AADSTS500176: The certificate authority that issued your certificate has not been set up in the tenant. Please contact your administrator.**         |       Entra could not locate the issuing Certificate Authority (CA) certificate in its trusted certificate store. This prevents successful validation of the user certificate’s chain of trust.        |          - The issuing CA certificate (root or intermediate) has not been uploaded or configured in the Microsoft Entra ID trusted certificates list.<br/>- The certificate chain stored on the client or device does not properly link to a trusted CA certificate.<br/>- Mismatched or missing Subject Key Identifier (SKI) and Authority Key Identifier (AKI) references in the certificate chain.<br/>- The issuing certificate may be expired, revoked, or otherwise invalid.              |    - Tenant administrator should upload all relevant root and intermediate CA certificates to the Microsoft Entra trusted certificate store via the Entra admin center.<br/> - Confirm that the SKI of the issuing CA certificate matches the AKI in the user’s certificate to ensure proper chain linkage.<br/> - Use tools like certutil or OpenSSL to verify that the full certificate chain is intact, unbroken, and trusted. <br/> - Replace any expired or revoked CA certificates in the trusted store to maintain chain validity.     |
| **AADSTS500177: Certificate Revocation List (CRL) misconfigured. Delta CRL distribution point is configured without a corresponding base CRL distribution point. Please contact your administrator.**         |    Indicates that your Certificate Authority (CA) configuration includes a Delta CRL distribution point, but the corresponding Base CRL distribution point is missing or not configured properly.       |         - The CRL distribution points (CDPs) configured in the certificates or CA settings are invalid, inaccessible, or incorrect URLs.<br/> - The CA has not published the CRL properly or the CRL has expired, causing validation failures.<br/> - Devices or Microsoft Entra ID services cannot access the CRL URLs due to firewall rules, proxy restrictions, or network connectivity issues.<br/> - Misconfigured settings either in Microsoft Entra or the issuing Certificate Authority related to CRL handling.                | - Confirm and update CRL distribution points to accurate, publicly accessible URLs.<br/>- Ensure CRLs are published and renewed regularly before expiry. Automate CRL publication if possible.<br/>- Allow necessary network traffic to CRL distribution points by updating firewall, proxy, or security device rules.<br/>- Verify the downloaded CRLs for corruption or truncation, and republish if necessary.<br/>- Double-check Entra ID and CA configurations related to CRL publishing, URLs, and validation policies.<br/>   |
| **AADSTS500178: Unable to retrieve valid CRL segments for {type}. Please try again later.**     | Microsoft Entra ID fails to download or process all required segments of the Certificate Revocation List (CRL) during certificate validation.         |  - The CRL is published in multiple segments, and one or more segments are missing, corrupt, or inaccessible.<br/>- Network restrictions or firewalls block access to one or more CRL segments.<br/>- The CRL segments available may have expired or are not properly updated.<br/>- Incorrect URLs or missing entries in the certificate’s CRL distribution points where segments are hosted.               | - Manually download all CRL segments from their distribution points and check for completeness and validity.<br/>- Ensure all CRL segment URLs are correctly configured and accessible. Update certificates or CA configurations if CDP URLs have changed.<br/>- Confirm the CA publishes and maintains all CRL segments properly without corruption or missing parts.<br/>     |
| **AADSTS500179: CRL validation timed out. Please try again later.** | CRL download timed out or was interrupted.           | - CRL size exceeds limits<br>- Network latency or instability                                                   | - Keep CRL size under 20MB (commercial) or 45MB (US Gov)<br>- Set `Next Update` interval to at least one week<br>- Monitor CRL download performance via sign-in logs     |
| **AADSTS500183: Certificate has been revoked. Please contact your administrator**         |    an Authentication attempt failed because the client device presented a certificate that has been revoked by the issuing Certificate Authority (CA).           |       The certificate used for authentication is found in the Certificate Revocation List (CRL) or flagged as revoked by the CA.                 |     - Tenant Administrator should ensure the new certificate is correctly provisioned and trusted by Microsoft Entra ID.<br/> - Verify that the CRLs and delta CRLs published by your CA are up to date and accessible for the devices.    |
| **AADSTS2205011: The downloaded Certificate Revocation List (CRL) is not in a valid ASN.1 encoding format. Please contact your administrator.**         |    CRL file fetched by Entra is not correctly encoded following the ASN.1 (Abstract Syntax Notation One) DER (Distinguished Encoding Rules) standard, which is required for parsing and validating the CRL data.          |         - The CRL file is corrupted or truncated during publication or transmission.<br/>- The CRL was generated or encoded incorrectly by the Certificate Authority (CA) and does not conform to ASN.1 DER standards.<br/>- File format conversions (e.g., improper base64/PEM encoding) have corrupted the CRL data.<br/>               |    - Manually download the CRL and inspect it with tools like openssl or specialized ASN.1 parsers to confirm if it's corrupted or malformed.<br/>- Regenerate and republish the CRL from the CA ensuring compliance with ASN.1 DER encoding standards.<br/>- Ensure the CA software or tools generating CRLs comply with RFC 5280 and correctly encode CRLs in ASN.1 DER format.<br/>     |
| **AADSTS2205012: The attempt to download the Certificate Revocation List (CRL) from '{uri}' during the interactive sign-in has timed out. We are trying to download again. Please try again in a few minutes.** |  Microsoft Entra ID could not retrieve the CRL file within the expected time from the specified URL. | - Entra ID services cannot reach the CRL distribution point due to network outages, firewall restrictions, or DNS failures.<br/>- The server hosting the CRL is down, overloaded, or not responding in a timely manner.<br/>- Large CRLs take longer to download, potentially causing timeouts.<br/>   |   - Use delta CRLs to keep CRL file sizes smaller and refresh more frequently to reduce download time.<br/>- Publish or refresh CRLs during off-peak hours to reduce server load and improve response times.<br/>- Monitor and maintain high availability and performance of the CRL hosting servers.<br/> |
| **AADSTS2205013: Certificate Revocation List (CRL) download is currently in progress. Please try again in a few minutes.**         |   Happens when multiple authentication attempts simultaneously trigger CRL downloads, and the system is still processing the current CRL retrieval.           |       - When a CRL has expired or is about to expire, multiple users signing in concurrently can cause simultaneous attempts to download the fresh CRL.<br/>-  Microsoft Entra ID applies a locking mechanism to prevent concurrent downloads of the same CRL to reduce load and potential race conditions.This causes some authentication requests to be temporarily denied with this retry message.<br/>- Large user populations or heavy sign-in bursts can increase the frequency of this error.   |     - Allow a few minutes for the ongoing CRL download to finish before retrying sign-in.<br/>- Ensure CRLs are published and updated regularly before expiry to reduce forced re-downloads.    |
| **AADSTS2205014:The attempt to download the Certificate Revocation List (CRL) from '{uri}' during the interactive sign-in has exceeded the maximum allowed size ({size} bytes). The CRL is being provisioned with CRL's service download limit, please try again in a few minutes.**         |    The CRL file Microsoft Entra ID tried to download is larger than the size limit set by the service. Entra will try to download in background with higher limits.         |   - The CRL file published by the Certificate Authority (CA) is too large, often due to a high number of revoked certificates.<br/>- Large CRLs can occur if revoked certificates are not cleaned up or if the CA keeps long expiration periods for revocation data.<br/> - Large CRL sizes increase download times and resource consumption during certificate-based authentication.<br/> | - Remove stale or expired revoked certificates from the CA database.<br/> - Shorten CRL validity periods and increase publishing frequency to keep CRL sizes manageable.<br/>- Implement delta CRLs to distribute only incremental revocation information and reduce bandwidth.<br/>   |
| **AADSTS2205015: The Certificate Revocation List (CRL) failed signature validation. The expected SubjectKeyIdentifier {expectedSKI} does not match CRL's AuthorityKeyIdentifier {crlAK}. Please contact your administrator.**  | The cryptographic signature on the CRL could not be validated because the CRL was signed by a certificate whose Subject Key Identifier (SKI) does not match the Authority Key Identifier (AKI) expected by Microsoft Entra ID.  | - The CA certificate used to sign the CRL has changed but the new SKI has not been updated or synchronized in the trusted certificates list.<br/> - The CRL is outdated or mismatched due to misconfiguration in the PKI hierarchy.<br/>- Incorrect or missing intermediate CA certificates in the trusted certificate list.<br/>- CRL signing certificate may not have the appropriate key usage for signing CRLs.<br/>  | - Check the Subject Key Identifier (SKI) of the CA certificate signing the CRL matches the Authority Key Identifier (AKI) in the CRL.<br/>- Confirm the signing CA certificate is uploaded and trusted in Microsoft Entra ID.<br/>- Validate that the CA certificate used to sign the CRL has the appropriate key usage flags enabled (e.g., CRL signing) and Verify the certificate chain is intact and unbroken.<br/> - Upload or update the correct root and intermediate CA certificates in Microsoft Entra ID’s trusted certificate authorities list and ensure the certificate used to sign the CRL is included and correctly configured.  |
| **AADSTS7000214: Certificate has been revoked.**         |   Certificate has been revoked.           | - Certificate listed in CRL           | - Replace revoked certificate<br>- Investigate revocation reason with CA<br>- Monitor certificate lifecycle and renewal       |
| | | | |


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

