---
title: Understand Microsoft Entra certificate-based authentication Certificate revocation list
description: Learn how certificate revocation list works with Microsoft Entra certificate-based authentication
ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 08/26/2025
ms.author: justinha
author: vimrang
manager: dougeby
ms.reviewer: vranganathan
ms.custom: has-adal-ref, sfi-image-nochange
ms.localizationpriority: high
---

# Microsoft Entra certificate-based authentication Certificate Revocation List (CRL)

A Certificate Revocation List (CRL) is a list of certificates that have been revoked by the issuing Certificate Authority (CA) before their scheduled expiration date. CRLs are essential for maintaining authentication integrity. When a certificate is revoked, it’s marked as untrusted even if not expired. Incorporating CRLs in certificate-based authentication ensures only valid, non-revoked certificates are accepted, and Microsoft Entra ID blocks any attempt using a revoked certificate.

CRLs are digitally signed by the CA and published to publicly accessible locations, allowing them to be downloaded over the internet to verify the revocation status of certificates. When a client presents a certificate for authentication, the system checks the CRL to determine if the certificate has been revoked. 

If the certificate is found in the CRL, the authentication attempt is rejected. CRLs are usually updated periodically, and organizations should ensure they have the latest version of the CRL to make accurate decisions about certificate validity. 

In Microsoft Entra certificate-based authentication (CBA), when CRLs are configured, the system must retrieve and validate the CRL during authentication. If Microsoft Entra ID cannot access the CRL endpoint, authentication fails because the CRL is required to confirm certificate validity.

## How a CRL works in certificate-based authentication

A CRL works by providing a mechanism to check the validity of certificates used for authentication. The process involves several key steps:

- **Certificate Issuance:** When a certificate is issued by a CA, it is valid until its expiration date unless it is revoked earlier. Each certificate contains a public key and is signed by the CA.
- **Revocation:** If a certificate needs to be revoked (for example, if  the private key is compromised or the certificate is no longer needed), the CA adds it to the CRL.
- **CRL Distribution:** The CA publishes the CRL to a location accessible by clients, such as a web server or a directory service. The CRL is typically signed by the CA to ensure its integrity.
- **Client Check:** When a client presents a certificate for authentication, the system retrieves the CRL for each CA in the certificate chain from its published locations and checks for any revoked CAs. If any CRL location is unavailable, authentication fails because the system cannot verify the certificate’s revocation status.
- **Authentication:** If the certificate is found in the CRL, the authentication attempt is rejected, and the client is denied access. If the certificate is not in the CRL, the authentication proceeds as normal.
- **CRL Updates:** The CRL is updated periodically by the CA, and clients should ensure they have the latest version to make accurate decisions about certificate validity. The system does cache the CRL for a certain period to reduce network traffic and improve performance, but it does also check for updates regularly.

## Understanding the certificate revocation process in Microsoft Entra certificate-based authentication

The certificate revocation process enables Authentication Policy Administrators to revoke a previously issued certificate so it can't be used for future authentication. 


Authentication Policy Administrators configure the CRL distribution point during the setup process for trusted issuers in the Microsoft Entra tenant. Each trusted issuer should have a CRL that you can reference by using an internet-facing URL. For more information, see [Configure Certificate Authorities](./how-to-certificate-based-authentication.md#step-1-configure-the-cas-with-a-pki-based-trust-store).

Microsoft Entra ID supports only one CRL endpoint and supports only HTTP or HTTPS. We recommend using HTTP instead of HTTPS for CRL distribution. CRL checks occur during certificate-based authentication, and any delay or failure in retrieving the CRL can block authentication. Using HTTP minimizes latency and avoids potential circular dependencies caused by HTTPS (which itself requires certificate validation). To ensure reliability, host CRLs on highly available HTTP endpoints and verify that they're accessible over the internet.
 
>[!IMPORTANT]
>The maximum size of a CRL for Microsoft Entra ID to successfully download on an interactive sign-in is 20 MB in public Microsoft Entra ID and 45 MB in Azure US Government clouds. The time required to download the CRL must not exceed 10 seconds. If Microsoft Entra ID can't download a CRL, certificate-based authentications by using certificates issued by the corresponding CA fail. As a best practice to keep CRL files within size limits, keep certificate lifetimes within reasonable limits and clean up expired certificates.

1. When a user performs an interactive sign-in with a certificate, Microsoft Entra ID downloads and caches the customer's certificate revocation list (CRL) from their certificate authority to check if certificates are revoked during the authentication of the user. Microsoft Entra uses the SubjectKeyIdentifier attribute instead of SubjectName to build the certificate chain. When CRLs are enabled, PKI configurations must include SubjectKeyIdentifier and Authority Key Identifier values to ensure proper revocation checking.

   SubjectKeyIdentifier provides a unique, immutable identifier for the certificate’s public key, making it more reliable than SubjectName, which can change or be duplicated across certificates. This attribute ensures accurate chain building and consistent CRL validation in complex PKI environments.


   >[!IMPORTANT]
   >If an Authentication Policy Administrator skips the configuration of the CRL, Microsoft Entra ID doesn't perform any CRL checks during the certificate-based authentication of the user. This behavior can be helpful for initial troubleshooting, but shouldn't be considered for production use.

   - Base CRL only: If only the base CRL is configured, Microsoft Entra ID downloads and caches it until the Next Update timestamp. Authentication fails if the CRL has expired and can't be refreshed due to connectivity issues or if the CRL endpoint doesn't provide an updated version. Microsoft Entra strictly enforces CRL versioning: when a new CRL is published, its CRL Number must be higher than the previous version.

     CRL Number ensures monotonic versioning, preventing replay attacks where an older CRL could be reintroduced to bypass revocation checks. By requiring each new CRL to have a higher version number, Microsoft Entra ID guarantees that the most recent revocation data is always used.

   - Base + Delta CRL: When both are configured, both must be valid and accessible. If either is missing or expired, certificate validation fails per RFC 5280 standards.

1. The user certificate-based authentication fails if a CRL is configured for the trusted issuer and Microsoft Entra ID can't download the CRL, due to availability, size, or latency constraints. This limitation makes the CRL endpoint a critical single point of failure, reducing the resiliency of Microsoft Entra ID’s certificate-based authentication. To mitigate this risk, we recommend using highly available solutions that ensure continuous uptime for CRL endpoints.

1. If the CRL exceeds the interactive limit for a cloud, the user's initial sign-in fails with the following error:

   `The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Microsoft Entra ID. Try again in few minutes. If the issue persists, contact your tenant administrators.`

1. Microsoft Entra ID attempts to download the CRL subject to the service-side limits (45 MB in public Microsoft Entra ID and 150 MB in Azure for US Government).

1. Users can retry the authentication after a few minutes. If the user's certificate is revoked and appears in the CRL, the authentication fails.

   >[!IMPORTANT]
   >Token revocation for a revoked certificate isn't immediate because of CRL caching. If a CRL is already cached, newly revoked certificates aren't detected until the cache refreshes with an updated CRL. Delta CRLs typically include these updates, so revocation takes effect once the delta CRL is loaded. If delta CRLs aren't used, revocation depends on the base CRL’s validity period. Administrators should manually revoke tokens only when immediate revocation is critical, such as in high-security scenarios. For more information, see [Configure revocation](./certificate-based-authentication-federation-get-started.md#step-3-configure-revocation).

1. We don't support Online Certificate Status Protocol (OCSP) because of performance and reliability reasons. Instead of downloading the CRL at every connection by the client browser for OCSP, Microsoft Entra ID downloads it once at the first sign-in and caches it. This action improves the performance and reliability of CRL verification. We also index the cache so the search is much faster every time. 

1. If Microsoft Entra successfully downloads the CRL, it caches and reuses the CRL for any subsequent usage. It honors the **Next update date** and, if available, **Next CRL Publish date** (used by Windows Server CAs) in the CRL document.


1. If the user's certificate is listed as revoked on the CRL, user authentication fails.
   
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificate-revocation-list/user-cert.png" alt-text="Screenshot of the revoked user certificate in the CRL." ::: 

   >[!IMPORTANT]
   >Due to the nature of CRL caching and publishing cycles, it's highly recommended that, if there's a certificate revocation, you also revoke all sessions of the affected user in Microsoft Entra ID.

1. Microsoft Entra ID attempts to pre-fetch a new CRL from the distribution point if the cached CRL document is expired. If CRL has a "Next Publish Date" Microsoft Entra does a CRL pre-fetch even if the CRL in cache is not expired. As of now, there's no way to manually force or retrigger the download of the CRL.

   >[!NOTE]
   >Microsoft Entra ID checks the CRL of the issuing CA and other CAs in the PKI trust chain up to the root CA.    We have a limit of up to 10 CAs from the leaf client certificate for CRL validation in the PKI chain. The    limitation is to make sure a bad actor doesn't bring down the service by uploading a PKI chain with a huge    number of CAs with a bigger CRL size.
   >If the tenant's PKI chain has more than 10 CAs, and if there's a CA compromise, Authentication Policy Administrators should remove the compromised trusted issuer from the Microsoft Entra tenant configuration. For more information, see [CRL Pre-fetching](/windows/win32/seccrypto/certificate-revocation-list-semantics#crl-pre-fetching).

### How to configure revocation

[!INCLUDE [Configure revocation](../../includes/entra-authentication-configure-revocation.md)]

## Enforce CRL validation for CAs

When you upload CAs to the Microsoft Entra trust store, you don't need to include a CRL or the CrlDistributionPoint attribute. You can upload a CA without a CRL endpoint, and certificate-based authentication doesn't fail if an issuing CA doesn't specify a CRL. 

To strengthen security and avoid misconfigurations, an Authentication Policy Administrator can require CBA authentication to fail if a CA that issues an end user certificate doesn't configure a CRL.

### Enable CRL validation

1. Select **Require CRL validation (recommended)** to enable CRL validation. 

   :::image type="content" border="true" source="./media/   concept-certificate-based-authentication-certificate-revocation-list/require-validation.png"    alt-text="Screenshot of how to require CRL validation." :::  
   
   When you enable this setting, CBA fails if the end user certificate comes from a CA that doesn't configure a CRL.

1. An Authentication Policy Administrator can exempt a CA if its CRL has issues that need to be fixed. Select **Add Exemption** and choose any CAs to exempt.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificate-revocation-list/exempt-validation.png" alt-text="Screenshot of how to exempt CAs from CRL validation." :::  

1. CAs in the exempted list don't need to configure a CRL, and the end-user certificates they issue don't fail authentication.

   Select CAs and select **Add**. Use the **Search** text box to filter the CA lists and select specific CAs.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-certificate-revocation-list/exempted.png" alt-text="Screenshot of CAs that are exempted from CRL validation." ::: 


## Guidance for setting up CRLs (base and delta CRL) for Microsoft Entra ID

1. Publish accessible CRLs: 
   - Ensure your CA publishes both the base CRL and delta CRLs (if applicable) to internet-facing URLs accessible via HTTP. 
   - Microsoft Entra ID can't validate certificates if CRLs are hosted on internal-only servers. The URLs should be highly available, performant, and resilient to prevent authentication failures due to unavailability. 
   - Validate CRL accessibility by testing the CRL URL in a browser and using certutil -url for distribution checks.

1. Configure CRL URLs in Microsoft Entra ID: 
   - Upload the CA public certificate to Microsoft Entra ID and configure the CRL distribution points (CDPs). 
   - Base CRL URL: Contains all revoked certificates.
   - Delta CRL URL (optional but recommended): Contains certificates revoked since the last base CRL was    published.
   - Use tools like certutil to verify CRL validity and troubleshoot certificate and CRL issues locally.
   

1. Set validity periods:
   - Set the base CRL validity period long enough to balance operational overhead and security (typically days to weeks).
   - Set the delta CRL validity period shorter (commonly 24 hours) to allow for timely recognition of revoked certificates.
   - Shorter delta CRL validity improves security by reducing the window where revoked certificates remain valid but increases issuance and distribution load.
   - The recommended 24-hour default validity for delta CRLs on Windows Servers is a widely accepted standard security and performance.
   - Microsoft Entra ID is designed to efficiently handle frequent delta CRL updates without performance    degradation, and ongoing improvements help enhance this further. 
   - Microsoft Entra ID applies throttling mechanisms to protect against DDoS attacks during delta CRL downloads, which can result in temporary errors like "AADSTS2205013" for a small subset of users.
   
1. Ensure high availability and performance:
   - Host CRLs on reliable web servers or content delivery networks (CDNs) to minimize delays or failures during retrieval.
   - Monitor CRL publication and accessibility proactively.
   
1. Protect against throttling and distributed denial-of-service (DDoS) attacks:
   - To protect Microsoft Entra ID services and users, throttling is applied to CRL fetch operations during high load or potential abuse.
   - Schedule CRL publication and expiration cycles during off-peak hours to minimize the likelihood of    throttling impacting users.
   
1. CRL size management
   - Keep CRL payloads as small as possible, ideally by frequent delta CRL issuance and archival of old entries, to improve fetch speed and reduce bandwidth.

1. Enable CRL validation
   - Enforce CRL validation in Microsoft Entra ID policies to ensure revoked certificates are detected. For more information, see [Enable CRL validation](concept-certificate-based-authentication-certificate-revocation-list.md#enable-crl-validation).
   - Consider temporary bypass of CRL checking only as a last resort during troubleshooting, with an understanding of the security risks.

1. Test and monitor
   - Perform regular tests to verify that CRLs are downloadable and recognized correctly by Microsoft Entra ID.
   - Use monitoring to detect and quickly remediate any CRL availability or validation issues.
   
## CRL error eeference 

| Error code and message | Description | Common causes | Recommendations  |
|-------------------------|-------------|---------------|----------------------|
| **AADSTS500171: Certificate has been revoked. Please contact your administrator.**| Certificate is in the CRL, indicating it's revoked.   | Certificate is revoked by the admin. |   If a certificate is mistakenly included in the CRL, have the issuing CA reissue the CRL with an updated list that accurately reflects the intended revocations.      |
| **AADSTS500172: Certificate '{name}' issued by '{issuer}' is not valid. Current time: '{curTime}'. Certificate NotBefore: '{startTime}'. Certificate NotAfter: '{endTime}'.** | CRL isn't valid in time. | The CRLs or delta CRLs used to validate the certificate have timing issues such as expired CRLs or incorrectly configured publication/validity times.| - Confirm that the certificate’s NotBefore and NotAfter dates properly encompass the current time.<br/>- Verify that the base and delta CRLs published by your CA aren't expired.    |
| **AADSTS500173: >Unable to download a Certificate Revocation List (CRL). Invalid status code {code} from CRL distribution point. Please contact your administrator.** | CRL couldn't be downloaded due to endpoint issues.  | - CRL endpoint returns HTTP errors (such as 403)<br>- CRL expired with no update | - Confirm CRL endpoint returns valid data<br>- Ensure CA regularly publishes updated CRLs<br> - The CRL URL is inaccessible due to network issues, firewall blocks, or server downtime.<br/>- Enable CRL fail-safe to block unverifiable certificates. |
| **AADSTS500174: Unable to construct valid Certificate Revocation List (CRL) from response.** |        Microsoft Entra ID can't parse or use the CRL retrieved from the specified distribution point.  | -  The CRL URL is inaccessible due to network issues, firewall blocks, or server downtime.  <br/>- The downloaded CRL file is corrupted, incomplete, or incorrectly formatted.<br/>-  The URLs in the certificate’s CDP fields don't point to valid CRL files or are misconfigured.        |    - Verify CRL accessibility, validity, and integrity. <br/>-  Inspect the CRL file for corruption or incomplete content.   |
| **AADSTS500175: Revocation check failed because the Certificate Revocation List (CRL) for one certificate in the chain is missing.**         |    During certificate revocation checking, Microsoft Entra couldn't locate a required segment or portion of the Certificate Revocation List (CRL).            |     - The CRL file downloaded from the CRL Distribution Point (CDP) is corrupted or truncated.<br/>- Incorrect or incomplete publication of the CRL by the CA.<br/>- Network issues causing incomplete or failed CRL downloads.<br/>- Misconfiguration of the CRL distribution point URLs or file segments.                    |   - Verify CRL Integrity<br/>- Republish or Regenerate CRL <br/>- Check Network and Proxy Settings <br/>- Ensure Correct CDP Configuration on all the CAs      |
| **AADSTS500176: The certificate authority that issued your certificate hasn't been set up in the tenant. Please contact your administrator.**         |       Microsoft Entra couldn't locate the issuing CA certificate in its trusted certificate store. This prevents successful validation of the user certificate’s chain of trust.        |          - The issuing CA certificate (root or intermediate) isn't uploaded or configured in the Microsoft Entra ID trusted certificates list.<br/>- The certificate chain stored on the client or device doesn't properly link to a trusted CA certificate.<br/>- Mismatched or missing Subject Key Identifier (SKI) and Authority Key Identifier (AKI) references in the certificate chain.<br/>- The issuing certificate might be expired, revoked, or otherwise invalid.              |    - Tenant administrator should upload all relevant root and intermediate CA certificates to the Microsoft Entra trusted certificate store via the Microsoft Entra admin center.<br/>- Confirm that the SKI of the issuing CA certificate matches the AKI in the user’s certificate to ensure proper chain linkage.<br/>- Use tools like certutil or OpenSSL to verify that the full certificate chain is intact, unbroken, and trusted. <br/>- Replace any expired or revoked CA certificates in the trusted store to maintain chain validity.     |
| **AADSTS500177: Certificate Revocation List (CRL) misconfigured. Delta CRL distribution point is configured without a corresponding base CRL distribution point. Please contact your administrator.**         |    Indicates that your CA configuration includes a Delta CRL distribution point, but the corresponding Base CRL distribution point is missing or not configured properly.       |         - The CRL distribution points (CDPs) configured in the certificates or CA settings are invalid, inaccessible, or incorrect URLs.<br/>- The CA hasn't published the CRL properly or the CRL has expired, causing validation failures.<br/>- Devices or Microsoft Entra ID services can't access the CRL URLs due to firewall rules, proxy restrictions, or network connectivity issues.<br/>- Misconfigured settings either in Microsoft Entra or the issuing Certificate Authority related to CRL handling.                | - Confirm and update CRL distribution points to accurate, publicly accessible URLs.<br/>- Ensure CRLs are published and renewed regularly before expiry. Automate CRL publication if possible.<br/>- Allow necessary network traffic to CRL distribution points by updating firewall, proxy, or security device rules.<br/>- Verify the downloaded CRLs for corruption or truncation, and republish if necessary.<br/>- Double-check Microsoft Entra ID and CA configurations related to CRL publishing, URLs, and validation policies.<br/>   |
| **AADSTS500178: Unable to retrieve valid CRL segments for {type}. Please try again later.**     | Microsoft Entra ID fails to download or process all required segments of the Certificate Revocation List (CRL) during certificate validation.         |  - The CRL is published in multiple segments, and one or more segments are missing, corrupt, or inaccessible.<br/>- Network restrictions or firewalls block access to one or more CRL segments.<br/>- The CRL segments available might have expired or aren't properly updated.<br/>- Incorrect URLs or missing entries in the certificate’s CRL distribution points where segments are hosted.               | - Manually download all CRL segments from their distribution points and check for completeness and validity.<br/>- Ensure all CRL segment URLs are correctly configured and accessible. Update certificates or CA configurations if CDP URLs have changed.<br/>- Confirm the CA publishes and maintains all CRL segments properly without corruption or missing parts.    |
| **AADSTS500179: CRL validation timed out. Please try again later.** | CRL download timed out or was interrupted.           | - CRL size exceeds limits<br>- Network latency or instability                                                   | - Keep CRL size under 20MB (commercial Azure) or 45MB (Azure for US Government)<br>- Set `Next Update` interval to at least one week<br>- Monitor CRL download performance via sign-in logs.     |
| **AADSTS500183: Certificate has been revoked. Please contact your administrator**         |    An Authentication attempt failed because the client device presented a certificate that was revoked by the issuing CA.           |       The certificate used for authentication is found in the Certificate Revocation List (CRL) or flagged as revoked by the CA.                 |     - Tenant Administrator should ensure the new certificate is correctly provisioned and trusted by Microsoft Entra ID.<br/>- Verify that the CRLs and delta CRLs published by your CA are up to date and accessible for the devices.    |
| **AADSTS2205011: The downloaded Certificate Revocation List (CRL) isn't in a valid ASN.1 encoding format. Please contact your administrator.**         |    CRL file fetched by Microsoft Entra isn't correctly encoded following the Abstract Syntax Notation One (ASN.1) Distinguished Encoding Rules (DER) standard, which is required for parsing and validating the CRL data.          |         - The CRL file is corrupted or truncated during publication or transmission.<br/>- The CRL was generated or encoded incorrectly by the CA and doesn't conform to ASN.1 DER standards.<br/>- File format conversions (such as improper base64/PEM encoding) corrupted the CRL data.             |    - Manually download the CRL and inspect it with tools like openssl or specialized ASN.1 parsers to confirm if it's corrupted or malformed.<br/>- Regenerate and republish the CRL from the CA ensuring compliance with ASN.1 DER encoding standards.<br/>- Ensure the CA software or tools generating CRLs comply with RFC 5280 and correctly encode CRLs in ASN.1 DER format.<br/>     |
| **AADSTS2205012: The attempt to download the Certificate Revocation List (CRL) from '{uri}' during the interactive sign-in has timed out. We're trying to download again. Please try again in a few minutes.** |  Microsoft Entra ID couldn't retrieve the CRL file within the expected time from the specified URL. | - Microsoft Entra ID services can't reach the CRL distribution point due to network outages, firewall restrictions, or DNS failures.<br/>- The server hosting the CRL is down, overloaded, or not responding in a timely manner.<br/>- Large CRLs take longer to download, potentially causing timeouts.<br/>   |   - Use delta CRLs to keep CRL file sizes smaller and refresh more frequently to reduce download time.<br/>- Publish or refresh CRLs during off-peak hours to reduce server load and improve response times.<br/>- Monitor and maintain high availability and performance of the CRL hosting servers.<br/> |
| **AADSTS2205013: Certificate Revocation List (CRL) download is currently in progress. Please try again in a few minutes.**         |   Happens when multiple authentication attempts simultaneously trigger CRL downloads, and the system is still processing the current CRL retrieval.           |       - When a CRL expires or is about to expire, multiple users signing in concurrently can cause simultaneous attempts to download the fresh CRL.<br/>-  Microsoft Entra ID applies a locking mechanism to prevent concurrent downloads of the same CRL to reduce load and potential race conditions.This causes some authentication requests to be temporarily denied with this retry message.<br/>- Large user populations or heavy sign-in bursts can increase the frequency of this error.   |     - Allow a few minutes for the ongoing CRL download to finish before retrying sign-in.<br/>- Ensure CRLs are published and updated regularly before expiry to reduce forced re-downloads.    |
| **AADSTS2205014:The attempt to download the Certificate Revocation List (CRL) from '{uri}' during the interactive sign-in has exceeded the maximum allowed size ({size} bytes). The CRL is being provisioned with CRL's service download limit, please try again in a few minutes.**         |    The CRL file Microsoft Entra ID tried to download is larger than the size limit set by the service. Microsoft Entra will try to download in background with higher limits.         |   - The CRL file published by the CA is too large, often due to a high number of revoked certificates.<br/>- Large CRLs can occur if revoked certificates aren't cleaned up or if the CA keeps long expiration periods for revocation data.<br/>- Large CRL sizes increase download times and resource consumption during certificate-based authentication. | - Remove stale or expired revoked certificates from the CA database.<br/>- Shorten CRL validity periods and increase publishing frequency to keep CRL sizes manageable.<br/>- Implement delta CRLs to distribute only incremental revocation information and reduce bandwidth.   |
| **AADSTS2205015: The Certificate Revocation List (CRL) failed signature validation. The expected SubjectKeyIdentifier {expectedSKI} doesn't match CRL's AuthorityKeyIdentifier {crlAK}. Please contact your administrator.**  | The cryptographic signature on the CRL couldn't be validated because the CRL was signed by a certificate whose Subject Key Identifier (SKI) doesn't match the Authority Key Identifier (AKI) expected by Microsoft Entra ID.  | - The CA certificate used to sign the CRL changed but the new SKI wasn't updated or synchronized in the trusted certificates list.<br/>- The CRL is outdated or mismatched due to misconfiguration in the PKI hierarchy.<br/>- Incorrect or missing intermediate CA certificates in the trusted certificate list.<br/>- CRL signing certificate might not have the appropriate key usage for signing CRLs. | - Check the Subject Key Identifier (SKI) of the CA certificate signing the CRL matches the Authority Key Identifier (AKI) in the CRL.<br/>- Confirm the signing CA certificate is uploaded and trusted in Microsoft Entra ID.<br/>- Validate that the CA certificate used to sign the CRL has the appropriate key usage flags enabled (such as CRL signing) and verify the certificate chain is intact and unbroken.<br/>- Upload or update the correct root and intermediate CA certificates in Microsoft Entra ID’s trusted certificate authorities list and ensure the certificate used to sign the CRL is included and correctly configured.  |
| **AADSTS7000214: Certificate has been revoked.**         |   Certificate has been revoked.           | - Certificate listed in CRL           | - Replace revoked certificate<br>- Investigate revocation reason with CA<br>- Monitor certificate lifecycle and renewal       |


## Frequently asked questions

This next sections cover common questions and answers related to Certificate Revocation Lists. 

### Is there a limit for CRL size?
        
The following CRL size limits apply: 

- Interactive sign-in download limit: 20 MB (Azure Global includes GCC), 45 MB for (Azure US government, includes GCC High, Dept. of Defense)
- Service download limit: 65 MB (Azure Global includes GCC), 150 MB for (Azure US government, includes GCC High, Dept. of Defense)

When a CRL download fails, the following message appears: 
    
"The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Microsoft Entra ID. Try again in few minutes. If the issue persists, contact your tenant administrators."
    
Download remains in the background with higher limits.

We're reviewing the impact of these limits and have plans to remove them.

### I see a valid Certificate Revocation List (CRL) endpoint set, but why don't I see any CRL revocation?
    
- Make sure the CRL distribution point is set to a valid HTTP URL.
- Make sure the CRL distribution point is accessible via an internet-facing URL.
- Make sure the CRL sizes are within limits. 

### How do I instantly revoke a certificate?
        
Follow the steps to [manually revoke a certificate](./certificate-based-authentication-federation-get-started.md#step-3-configure-revocation). 

### How can I turn certificate revocation checking on or off for a particular CA?
        
We recommend against disabling certificate revocation list (CRL) checking because you won't be able to revoke certificates. 
However, if you need to investigate issues with CRL checking, you can exempt a CA from CRL checking in the Microsoft Entra admin center. 
In the CBA Authentication methods policy, select **Configure** and then select **Add exemption**. Choose the CA that you want to exempt, and select **Add**. 

### After a CRL endpoint is configured, end users can't sign in and they see "AADSTS500173: Unable to download CRL. Invalid status code Forbidden from CRL distribution point."

When a problem prevents Microsoft Entra from downloading the CRL, the cause is often firewall restrictions. In most cases, you can resolve the issue by updating firewall rules to allow the required IP addresses so Microsoft Entra can successfully download the CRL. For more information, see [List of Microsoft IPAddress](/microsoft-365/enterprise/urls-and-ip-address-ranges#microsoft-365-unified-domains).

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

