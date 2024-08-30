---
title: Microsoft Entra certificate-based authentication technical deep dive
description: Learn how Microsoft Entra certificate-based authentication works

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 08/30/2024


ms.author: justinha
author: vimrang
manager: amycolannino
ms.reviewer: vraganathan
ms.custom: has-adal-ref
ms.localizationpriority: high
---

# Microsoft Entra certificate-based authentication technical deep dive

This article explains how Microsoft Entra certificate-based authentication (CBA) works, and dives into technical details on Microsoft Entra CBA configurations.

<a name='how-does-microsoft-entra-certificate-based-authentication-work'></a>

## How does Microsoft Entra certificate-based authentication work?

The following image describes what happens when a user tries to sign in to an application in a tenant where Microsoft Entra CBA is enabled.

:::image type="content" border="false" source="./media/concept-certificate-based-authentication-technical-deep-dive/how-it-works.png" alt-text="Illustration with steps about how Microsoft Entra certificate-based authentication works." :::

Now we'll walk through each step:

1. The user tries to access an application, such as [MyApps portal](https://myapps.microsoft.com/).
1. If the user isn't already signed in, the user is redirected to the Microsoft Entra ID **User Sign-in** page at [https://login.microsoftonline.com/](https://login.microsoftonline.com/).
1. The user enters their username into the Microsoft Entra sign-in page, and then selects **Next**. Microsoft Entra ID does home realm discovery using the tenant name and the username is used to look up the user in the tenant.
   
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in.png" alt-text="Screenshot of the Sign-in for MyApps portal.":::
  
1. Microsoft Entra ID checks whether CBA is enabled for the tenant. If CBA is enabled, the user sees a link to **Use a certificate or smartcard** on the password page. If the user doesn't see the sign-in link, make sure CBA is enabled on the tenant. For more information, see [How do I enable Microsoft Entra CBA?](./certificate-based-authentication-faq.yml#how-can-an-administrator-enable-microsoft-entra-cba-).
   
   >[!NOTE]
   > If CBA is enabled on the tenant, all users see the link to **Use a certificate or smart card** on the password page. However, only the users in scope for CBA can authenticate successfully against an application that uses Microsoft Entra ID as their Identity provider (IdP).

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-cert.png" alt-text="Screenshot of the Use a certificate or smart card.":::

   If you enabled other authentication methods like **Phone sign-in** or **Security keys**, users might see a different sign-in screen.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-alt.png" alt-text="Screenshot of the Sign-in if FIDO2 is also enabled.":::

1. Once the user selects certificate-based authentication, the client is redirected to the certauth endpoint, which is [https://certauth.login.microsoftonline.com](https://certauth.login.microsoftonline.com) for public Microsoft Entra ID. For [Azure Government](/azure/azure-government/compare-azure-government-global-azure#guidance-for-developers), the certauth endpoint is [https://certauth.login.microsoftonline.us](https://certauth.login.microsoftonline.us).  

   <!---
   If you enable issuer hints, the certauth endpoint is `https://t{tenantid}.certauth.login.microsoftonline.com`.
   --->

   The endpoint performs TLS mutual authentication, and requests the client certificate as part of the TLS handshake. An entry for this request appears in the sign-in log.

   >[!NOTE]
   >The network administrator should allow access to the User sign-in page and certauth endpoint `*.certauth.login.microsoftonline.com` for the customer's cloud environment. Disable TLS inspection on the certauth endpoint to make sure the client certificate request succeeds as part of the TLS handshake.

   Make sure your TLS inspection disablement also works for the new url with issuer hints. Don't hardcode the url with tenantId because it might change for B2B users. Use a regular expression to allow both the old and new URL to work for TLS inspection disablement. For example, depending on the proxy, use `*.certauth.login.microsoftonline.com` or `*certauth.login.microsoftonline.com`. In Azure Government, use `*.certauth.login.microsoftonline.us` or `*certauth.login.microsoftonline.us`.

   Unless access is allowed, certificate-based authentication fails if you enable [issuer hints](#understanding-issuer-hints-preview).

1. Microsoft Entra ID requests a client certificate. The user picks the client certificate, and selects **Ok**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png" alt-text="Screenshot of the certificate picker." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png":::

1. Microsoft Entra ID verifies the certificate revocation list to make sure the certificate isn't revoked and is valid. Microsoft Entra ID identifies the user by using the [username binding configured](how-to-certificate-based-authentication.md#step-4-configure-username-binding-policy) on the tenant to map the certificate field value to the user attribute value.
1. If a unique user is found with a Conditional Access policy that requires multifactor authentication, and the [certificate authentication binding rule](how-to-certificate-based-authentication.md#step-3-configure-authentication-binding-policy) satisfies MFA, then Microsoft Entra ID signs the user in immediately. If MFA is required but the certificate satisfies only a single factor, either passwordless sign-in or FIDO2 is offered as a second factor if they're already registered.
1. Microsoft Entra ID completes the sign-in process by sending a primary refresh token back to indicate successful sign-in.
1. If the user sign-in is successful, the user can access the application.

## Understanding issuer hints (Preview)

Issuer hints send back a Trusted CA Indication as part of the TLS handshake. The trusted CA list is set to subject of the Certificate Authorities (CAs) uploaded by the tenant in the Entra trust store. Browsers client or native application client use the hints sent back by server to filter the certificates shown in certificate picker. The client shows only the authentication certificates issued by the CAs in the trust store. 

### Enable issuer hints

To enable click on the check box **Issuer Hints**. [Authentication Policy Administrators](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) should click **I acknowledge** after making sure that the proxy with TLS inspection enabled is updated correctly, and save.

>[!NOTE]
>If your organization has firewalls or proxies with TLS inspection, acknowledge that you have disabled TLS inspection of the certauth endpoint capable of matching any name under `[*.]certauth.login.microsoftonline.com`, customized according to the specific proxy in use. 


:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/issuer-hints.png" alt-text="Screenshot of how to enable issuer hints.":::

>[!Note] 
>The certificate authority URL will be of a format `t{tenantId}.certauth.login.microsoftonline.com` after issuer hints are enabled.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/issuer-hints-picker.png" alt-text="Screenshot of the certificate picker after issuer hints are enabled.":::

### CA trust store update propagation

After you enable issuer hints and add, update, or delete CAs from the trust state, there's a delay of up to 10 minutes to propagate the issuer hints back to client. Users can't authenticate with certificates issued by the new CAs until the hints are propagated. 

Authentication Policy Administrators should sign in with a certificate after they enable issuer hints to initiate the propagation. Users will see the error message below when CA trust store updates are in propagation.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/propagation-error.png" alt-text="Screenshot of an error users see if updates are in progress.":::

## Certificate-based authentication MFA capability

Microsoft Entra CBA is capable of multifactor authentication (MFA). Microsoft Entra CBA can be either single-factor (SF) or multifactor (MF) depending on the tenant configuration. Enabling CBA makes a user potentially capable to complete MFA. A user might need more configuration to complete MFA, and proof up to register other authentication methods when the user is in scope for CBA.

If the CBA-enabled user only has a Single Factor (SF) certificate and needs to complete MFA:
   1. Use a password and SF certificate.
   1. Issue a Temporary Access Pass.
   1. Authentication Policy Administrator adds a phone number and allows voice/text message authentication for the user account.

If the CBA-enabled user hasn't yet been issued a certificate and needs to complete MFA:
   1. Issue a Temporary Access Pass.
   1. Authentication Policy Administrator adds a phone number and allows voice/text message authentication for the user account.

If the CBA-enabled user can't use an MF cert, such as on mobile device without smart card support, and needs to complete MFA:
   1. Issue a Temporary Access Pass.
   1. User needs to register another MFA method (when user can use MF cert).
   1. Use password and MF cert (when user can use MF cert).
   1. Authentication Policy Administrator adds a phone number and allows voice/text message authentication for the user account.

## MFA with single-factor certificate-based authentication

Microsoft Entra CBA can be used as a second factor to meet MFA requirements with single-factor certificates. 
Some of the supported combinations are:

1. CBA (first factor) and [passkeys](../authentication/how-to-enable-authenticator-passkey.md) (second factor)
1. CBA (first factor) and [passwordless phone sign-in](../authentication/howto-authentication-passwordless-phone.md#enable-passwordless-phone-sign-in-authentication-methods) (second factor)
1. CBA (first factor) and [FIDO2 security keys](../authentication/howto-authentication-passwordless-security-key-windows.md) (second factor) 

Users need to have another way to get MFA and register passwordless sign-in or FIDO2 in advance to signing in with Microsoft Entra CBA.

>[!IMPORTANT]
>A user is considered MFA capable when they are included in the CBA method settings. This means the user can't use proof up as part of their authentication to register other available methods. Make sure users without a valid certificate aren't included in the CBA method settings. For more information about how authentication works, see [Microsoft Entra multifactor authentication](../authentication/concept-mfa-howitworks.md).

**Steps to set up passwordless phone sign in (PSI) with CBA**

For passwordless sign-in to work, users should disable legacy notification through their mobile app.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).

1. Follow the steps at [Enable passwordless phone sign-in authentication](../authentication/howto-authentication-passwordless-phone.md#enable-passwordless-phone-sign-in-authentication-methods).

   >[!IMPORTANT]
   >In the preceding configuration, make sure you chose **Passwordless** option. You need to change the **Authentication mode** for any groups added for PSI to **Passwordless**. If you choose **Any**, CBA and PSI don't work.

1. Select **Protection** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/configure.png" alt-text="Screenshot of how to configure multifactor authentication settings.":::

1. Under **Verification options**, clear **Notification through mobile app**, and select **Save**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/clear-notification.png" alt-text="Screenshot of how to remove notification through mobile app.":::

## MFA authentication flow using single factor certificates and passwordless sign in

Let's look at an example of a user who has single-factor certificate, and is configured for passwordless sign-in. 

1. Enter your user principal name (UPN) and select **Next**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/user-principal-name.png" alt-text="Screenshot of how to enter a user principal name.":::

1. Select **Sign in with a certificate**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-cert.png" alt-text="Screenshot of how to sign in with a certificate.":::

   If you enabled other authentication methods like Phone sign-in or FIDO2 security keys, users might see a different sign-in screen.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-alt.png" alt-text="Screenshot of alternate way to sign in with a certificate.":::

1. Pick the correct user certificate in the client certificate picker and select **OK**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png" alt-text="Screenshot of how to select a certificate.":::

1. Because the certificate is configured to be single-factor authentication strength, the user needs a second factor to meet MFA requirements. The user sees available second factors, which in this case is passwordless sign-in. Select **Approve a request on my Microsoft Authenticator app**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/second-factor-request.png" alt-text="Screenshot of second factor request.":::

1. You'll get a notification on your phone. Select **Approve Sign-in?**.
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/approve.png" alt-text="Screenshot of approval request.":::

1. Enter the number you see on the browser or app screen into Microsoft Authenticator.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/number.png" alt-text="Screenshot of number match.":::

1. Select **Yes** and user can authenticate and sign in.

## MFA with Certificate-based authentication as second factor (Preview)
CBA can be used as a second factor like Password (first factor) and CBA (second factor) to get MFA.

>[!NOTE]
On iOS, users with certificate-based authentication will see a "double prompt", where they must click the option to use certificate-based authentication twice.
On iOS, users with Microsoft Authenticator App will also see hourly login prompt to authenticate with CBA if there's an Authentication Strength policy enforcing CBA, or if they use CBA as the second factor or step-up authentication.

## Understanding the authentication binding policy

The authentication binding policy helps determine the strength of authentication as either single-factor or multifactor. Authentication Policy Administrators can change the default value from single-factor to multifactor, or set up custom policy configurations either by using issuer subject or policy OID or Issuer and Policy OID fields in the certificate.

### Certificate strengths

Authentication Policy Administrators can determine whether the certificates are single-factor or multifactor strength. For more information, see the documentation that maps [NIST Authentication Assurance Levels to Microsoft Entra auth Methods](https://aka.ms/AzureADNISTAAL), which builds upon [NIST 800-63B SP 800-63B, Digital Identity Guidelines: Authentication and Lifecycle Mgmt](https://csrc.nist.gov/publications/detail/sp/800-63b/final).

### Multifactor certificate authentication 

When a user has a multifactor certificate, they can perform multifactor authentication only with certificates. However, an Authentication Policy Administrator should make sure the certificates are protected with a PIN or biometric to be considered multifactor.

<a name='how-microsoft-entra-id-resolves-multiple-authentication-policy-binding-rules'></a>

### How Microsoft Entra ID resolves multiple authentication policy binding rules

Because multiple custom authentication binding policy rules can be created with different certificate fields like using issuer + policy OID, or just Policy OID or just issuer. Below are the steps used to determine the authentication protection level when custom rules overlap. They are as follows:

1. Issuer + policy OID rules take precedence over Policy OID rules. Policy OID rules take precedence over certificate issuer rules. 
1. Issuer + policy OID rules are evaluated first. If you have a custom rule with issuer CA1 and policy OID **1.2.3.4.5** with MFA, only certificate A satisfies both issuer value and policy OID will be given MFA.
1. Next, custom rules using policy OIDs are evaluated. If you have a certificate A with policy OID **1.2.3.4.5** and a derived credential B based on that certificate has a policy OID **1.2.3.4.5.6**, and the custom rule is defined as **Policy OID** with value **1.2.3.4.5** with MFA, only certificate A satisfies MFA, and credential B satisfies only single-factor authentication. If the user used derived credential during sign-in and was configured to have MFA, the user is asked for a second factor for successful authentication.
1. If there's a conflict between multiple policy OIDs (such as when a certificate has two policy OIDs, where one binds to single-factor authentication and the other binds to MFA) then treat the certificate as a single-factor authentication.
1. Next, custom rules using issuer CA are evaluated.
1. If a certificate has both policy OID and Issuer rules matching, the policy OID is always checked first, and if no policy rule is found then the issuer bindings are checked. Policy OID has a higher strong authentication binding priority than the issuer.
1. If one CA binds to MFA, all user certificates that the CA issues qualify as MFA. The same logic applies for single-factor authentication.
1. If one policy OID binds to MFA, all user certificates that include this policy OID as one of the OIDs (A user certificate could have multiple policy OIDs) qualify as MFA.
1. One certificate issuer can only have one valid strong authentication binding (that is, a certificate can't bind to both single-factor and MFA).

>[!IMPORTANT]
>There is a known issue where a Microsoft Entra Authentication Policy Administrator configures a CBA authentication policy rule using both Issuer and Policy OID impacts some device registration scenarios including:
>- Windows Hello For Business enrollment
>- Fido2 Security Key registration
>- Windows Passwordless Phone Sign-in
>  
>Device registration with Workplace Join, Microsoft Entra ID and Hybrid Microsoft Entra device join scenarios are not impacted. CBA authentication policy rules using either Issuer OR Policy OID are not impacted.
>To mitigate, Authentication Policy Administrators should :
>- Edit the certificate-based authentication policy rules currently using both Issuer and Policy OID options and remove either the Issuer or OID requirement and save. OR
>- Remove the authentication policy rule currently using both Issuer and Policy OID and create rules using only issuer or policy OID
>  
>We are working to fix the issue.

## Understanding the username binding policy

The username binding policy helps validate the certificate of the user. By default, Subject Alternate Name (SAN) Principal Name in the certificate is mapped to UserPrincipalName attribute of the user object to determine the user.

### Achieve higher security with certificate bindings

There are seven supported methods for certificate bindings. In general, mapping types are considered high-affinity if they're based on identifiers that you can't reuse, such as Subject Key Identifiers or SHA1 Public Key. These identifiers convey a higher assurance that only a single certificate can be used to authenticate the respective user. 

Mapping types based on user names and email addresses are considered low-affinity. Microsoft Entra ID implements three mappings considered low-affinity based on reusable identifiers. The others are considered high-affinity bindings. For more information, see [certificateUserIds](concept-certificate-based-authentication-certificateuserids.md). 

| Certificate mapping field | Examples of values in certificateUserIds | User object attributes | Type | 
|:--------------------------|:----------------------------------------:|:----------------------:|:----:|
|PrincipalName | `X509:<PN>bob@woodgrove.com` | userPrincipalName <br> onPremisesUserPrincipalName <br> certificateUserIds | low-affinity |
|RFC822Name	| `X509:<RFC822>user@woodgrove.com` | userPrincipalName <br> onPremisesUserPrincipalName <br> certificateUserIds | low-affinity |
|IssuerAndSubject (preview) | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest` | certificateUserIds | low-affinity |
|Subject (preview)| `X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest`  | certificateUserIds | low-affinity |
|SKI | `X509:<SKI>aB1cD2eF3gH4iJ5kL6-mN7oP8qR=` | certificateUserIds | high-affinity |
|SHA1PublicKey | `X509:<SHA1-PUKEY>aB1cD2eF3gH4iJ5kL6-mN7oP8qR` | certificateUserIds | high-affinity |
|IssuerAndSerialNumber (preview) | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT` <br> To get the correct value for serial number, run this command and store the value shown in CertificateUserIds:<br> **Syntax**:<br> `Certutil –dump –v [~certificate path~] >> [~dumpFile path~]` <br> **Example**: <br> `certutil -dump -v firstusercert.cer >> firstCertDump.txt` | certificateUserIds | high-affinity |

### Define Affinity binding at the tenant level and override with custom rules (Preview)

With this feature an Authentication Policy Administrator can configure whether a user can be authenticated by using low-affinity or high-affinity username binding mapping. You can set **Required affinity binding** for the tenant, which applies to all users. You can also override the tenant-wide default value by creating custom rules based on Issuer and Policy OID, or Policy OID, or Issuer.

<a name='how-microsoft-entra-id-resolves-multiple-username-policy-binding-rules'></a>

### How Microsoft Entra ID resolves multiple username policy binding rules

Use the highest priority (lowest number) binding.

1. Look up the user object by using the username or User Principal Name.
1. Get the list of all username bindings setup by the Authentication Policy Administrator in the CBA authentication method configuration ordered by the 'priority' attribute. Today the concept of priority is not exposed in Portal UX. Graph will return you the priority attribute for each binding and they are used in the evaluation process.
1. If the tenant has high affinity binding enabled or if the certificate value matches a custom rule that required high affinity binding, remove all the low affinity bindings from the list.
1. Evaluate each binding in the list until a successful authentication occurs.
1. If the X.509 certificate field of the configured binding is on the presented certificate, Microsoft Entra ID matches the value in the certificate field to the user object attribute value.
   1. If a match is found, user authentication is successful.
   1. If a match isn't found, move to the next priority binding.
1. If the X.509 certificate field isn't on the presented certificate, move to the next priority binding.
1. Validate all the configured username bindings until one of them results in a match and user authentication is successful.
1. If a match isn't found on any of the configured username bindings, user authentication fails.

<a name='securing-microsoft-entra-configuration-with-multiple-username-bindings'></a>

## Securing Microsoft Entra configuration with multiple username bindings

Each of the Microsoft Entra user object attributes (userPrincipalName, onPremiseUserPrincipalName, certificateUserIds) available to bind certificates to Microsoft Entra user accounts has a unique constraint to ensure a certificate only matches a single Microsoft Entra user account. However, Microsoft Entra CBA supports multiple binding methods in the username binding policy which allows an Authentication Policy Administrator to accommodate one certificate to multiple Microsoft Entra user accounts configurations.

>[!IMPORTANT]
>If you configure multiple bindings, Microsoft Entra CBA authentication is only as secure as your lowest affinity binding because CBA validates each binding to authenticate the user. To prevent a scenario where a single certificate matches multiple Microsoft Entra accounts, an Authentication Policy Administrator can:
>- Configure a single binding method in the username binding policy.
>- If a tenant has multiple binding methods configured and doesn't want to allow one certificate to map to multiple accounts, the Authentication Policy Administrator must ensure all allowable methods configured in the policy map to the same Microsoft Entra account. All user accounts should have values matching all of the bindings.
>- If a tenant has multiple binding methods configured, the Authentication Policy Administrator should make sure that they don't have more than one low-affinity binding. 

For example, lets suppose you have two username bindings on PrincipalName mapped to UPN and SubjectKeyIdentifier (SKI) to certificateUserIds. If you want a certificate to only be used for a single account, an Authentication Policy Administrator must make sure that account has the UPN that is present in the certificate, and implement the SKI mapping in the certificateUserId attribute of the same account.

<a name='support-for-multiple-certificates-with-one-entra-user-account-m1'></a>

### Support for multiple certificates with one Microsoft Entra user account (M:1)
There are scenarios where an organization issues multiple certificates for a single identity. Most commonly this could be a derived credential for a mobile device or can also be for a secondary smartcard or x509 credential holder capable device such as a Yubikey. 

**Cloud only accounts**
For cloud-only accounts you can map multiple certificates (up to 5) for use by populating the certificateUserIds field (Authorization info in the User Portal) with unique values identifying each certificate. If the organization is using high affinity bindings say Issuer + SerialNumber, values within CertificateUserIds may look like the following: 
 
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8-qR9sT0uV`
 
In this example the first value represents X509Certificate1 and the second value represents X509Certificate2. The user may present either certificate at sign-in and as long as the CBA Username Binding is set to point to the certificateUserIds field to look for the particular binding type (that is, Issuer+SerialNumber in this example), then the user will successfully sign-in. 

**Hybrid Synchronized accounts**
For synchronized accounts you can map multiple certificates for use by populating the altSecurityIdentities field in AD the values identifying each certificate. If the organization is using high affinity (that is, strong authentication) bindings say Issuer + SerialNumber, this could look like the following: 
 
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8-qR9sT0uV`
 
In this example the first value represents X509Certificate1 and the second value represents X509Certificate2. These values must then be synchronized to the certificateUserIds field in Microsoft Entra ID.  

<a name='support-for-one-certificate-with-multiple-entra-user-accounts-1m'></a>

### Support for one certificate with multiple Microsoft Entra user accounts (1:M)
There are scenarios where an organization needs the user to use the same certificate to authenticate into multiple identities. Most commonly this is for administrative accounts. It can also be for developer accounts or temporary duty accounts. In traditional AD the altSecurityIdentities field is used to populate the certificate values and a Hint is used during login to direct AD to the desired account to check for the login. With Microsoft Entra CBA this is different and there is no Hint. Instead, Home Realm Discovery identifies the desired account to check the certificate values. The other key difference is that Microsoft Entra CBA enforces uniqueness in the certificateUserIds field. This means that two accounts cannot both populate the same certificate values. 

>[!Important]
> It is not a very secure configuration to use same credential to authenticate into different Microsoft Entra accounts and it is recommended not to allow one certificate for multiple Microsoft Entra user accounts.

**Cloud only accounts**
For cloud-only accounts you need to create multiple username bindings and need to map unique values to each user account that will be utilizing the certificate. Each account will be authenticated into using a different username binding. This applies within the boundary of a single directory/tenant (that is, Authentication Policy Administrators can map the certificate for use in another directory/tenant as well, as long as the values remain unique per account too).  
 
Populate the certificateUserIds field (Authorization info in the User Portal) with a unique value identifying the desired certificate. If the organization is using high affinity bindings (that is, strong authentication) bindings say Issuer + SerialNumber and SKI, this could look like the following: 

Username bindings:
- Issuer + Serial Number -> CertificateUserIds
- SKI -> CertificateUserIds

User account CertificateUserIds values:\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>aB1cD2eF3gH4iJ5kL6-mN7oP8qR`\
`X509:<SKI>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`

Now, when either user presents the same certificate at sign-in the user will successfully sign-in because their account matches a unique value on that certificate. One account will be authenticated into using Issuer+SerialNumber and the other using SKI binding.

>[!Note]
> The number of accounts that can be used in this manner is limited by the number of username bindings configured on the tenant. If the organization is using only High Affinity bindings the number of accounts supported will be limited to 3. If the organization is also utilizing low affinity bindings then this number increases to 7 accounts (1 PrincipalName, 1 RFC822Name, 1 SubjectKeyIdentifier, 1 SHA1PublicKey, 1 Issuer+Subject, 1 Issuer+SerialNumber, 1 Subject).

**Hybrid Synchronized accounts**
For synchronized accounts the approach will be different. While Authentication Policy Administrators can map unique values to each user account that will be utilizing the certificate, the common practice of populating all values to each account in Microsoft Entra ID would make this difficult. Instead, Microsoft Entra Connect should filter the desired values per account to unique values populated into the account in Microsoft Entra ID. The uniqueness rule applies within the boundary of a single directory/tenant (that is, Authentication Policy Administrators can map the certificate for use in another directory/tenant as well, as long as the values remain unique per account too). Further, the organization may have multiple AD forests contributing users into a single Microsoft Entra tenant. In this case Microsoft Entra Connect will apply the filter to each of these AD forests with the same goal to populate only a desired unique value to the cloud account. 

Populate the altSecurityIdentities field in AD with the values identifying the desired certificate and to include the desired certificate value for that user account type (such as detailee, admin, developer, and so on). Select a key attribute in AD which will tell the synchronization which user account type the user is evaluating (such as msDS-cloudExtensionAttribute1). Populate this attribute with the user type value you desire such as detailee, admin, or developer. If this is the user’s primary account, the value can be left empty/null. 
 
The accounts could look like the following: 
 
Forest 1 - Account1 (bob@woodgrove.com):\
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`
 
Forest 1 - Account2 (bob-admin@woodgrove.com): \
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`
 
Forest 2 – ADAccount1 (bob-tdy@woodgrove.com):\
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`
 
These values must then be synchronized to the certificateUserIds field in Microsoft Entra ID.

**Steps to synchronize to certificateUserIds**
1. Configure Microsoft Entra Connect to add the alternativeSecurityIds field to the Metaverse
1. For each AD Forest, configure a new custom inbound rule with a high precedence (low number below 100). Add an Expression transform with the altSecurityIdentities field as the source. The target expression will use the Key Attribute that you selected and populated as well as the mapping to the User Types that you defined.
1. For example:

```powershell
IIF((IsPresent([msDS-cloudExtensionAttribute1]) && IsPresent([altSecurityIdentities])), 
    IIF((InStr(LCase([msDS-cloudExtensionAttribute1]),LCase("detailee"))>0), 
    Where($item,[altSecurityIdentities],(InStr($item, "X509:<SHA1-PUKEY>")>0)), 
        IIF((InStr(LCase([msDS-cloudExtensionAttribute1]),LCase("developer"))>0), 
        Where($item,[altSecurityIdentities],(InStr($item, "X509:<SKI>")>0)), NULL) ), 
    IIF(IsPresent([altSecurityIdentities]), 
    Where($item,[altSecurityIdentities],(BitAnd(InStr($item, "X509:<I>"),InStrRev($item, "<SR>"))>0)), NULL) 
)
```
In the example above, altSecurityIdentities and the key attribute msDS-cloudExtensionAttribute1is are first checked to see if they are populated. If not, altSecurityIdentities is checked to see if it's populated. If it is empty then we set it to NULL. Otherwise the account falls into the default case and in this example we filter to only the Issuer+SerialNumber mapping. If the key attribute is populated, then the value is checked to see if it is equal to one of our defined user types. In this example if that value is detailee, then we filter to the SHA1PublicKey value from altSecurityIdentities. If the value is developer, then we filter to the SubjectKeyIssuer value from altSecurityIdentities. There may be multiple certificate values of a specific type. For example, multiple PrincipalName values or multiple SKI or SHA1-PUKEY values. The filter will get all the values and sync into Microsoft Entra ID – not just the first one it finds.
1. A second example that shows how to push an empty value if the control attribute is empty is below.
 
```powershell
IIF((IsPresent([msDS-cloudExtensionAttribute1]) && IsPresent([altSecurityIdentities])), 
    IIF((InStr(LCase([msDS-cloudExtensionAttribute1]),LCase("detailee"))>0), 
    Where($item,[altSecurityIdentities],(InStr($item, "X509:<SHA1-PUKEY>")>0)), 
        IIF((InStr(LCase([msDS-cloudExtensionAttribute1]),LCase("developer")>0), 
        Where($item,[altSecurityIdentities],(InStr($item, "X509:<SKI>")>0)), NULL) ), 
    IIF(IsPresent([altSecurityIdentities]), 
    AuthoritativeNull, NULL) 
) 
```
If the value in altSecurityIdentities does not match any of the search values in the control attribute, then an AuthoritativeNull is passed. This ensures that prior or subsequent rules which populate alternativeSecurityId are ignored and the result is empty in Microsoft Entra ID. 
1. Configure a new custom outbound rule with a low precedence (high number above 160 – bottom of list).
1. Add a direct transform with the alternativeSecurityIds field as the source and the certificateUserIds field as the target.
1. Run a synchronization cycle to complete the population of the data in Microsoft Entra ID. 
 
Ensure that CBA in each tenant is configured with the Username Bindings pointing to the certificateUserIds field for the field types that you have mapped from the certificate. Now any of these users may present the certificate at sign-in and after the unique value from the certificate is validated against the certificateUserIds field, that user will be successfully signed-in. 

## Understanding the certificate revocation process

The certificate revocation process allows Authentication Policy Administrators to revoke a previously issued certificate from being used for future authentication. The certificate revocation won't revoke already issued tokens of the user. Follow the steps to manually revoke tokens at [Configure revocation](./certificate-based-authentication-federation-get-started.md#step-3-configure-revocation).

Microsoft Entra ID downloads and caches the customers certificate revocation list (CRL) from their certificate authority to check if certificates are revoked during the authentication of the user.

Authentication Policy Administrators can configure the CRL distribution point during the setup process of the trusted issuers in the Microsoft Entra tenant. Each trusted issuer should have a CRL that can be referenced by using an internet-facing URL.
 
>[!IMPORTANT]
>The maximum size of a CRL for Microsoft Entra ID to successfully download on an interactive sign-in and cache is 20 MB in public Microsoft Entra ID and 45 MB in Azure US Government clouds, and the time required to download the CRL must not exceed 10 seconds. If Microsoft Entra ID can't download a CRL, certificate-based authentications using certificates issued by the corresponding CA fail. As a best practice to keep CRL files within size limits, keep certificate lifetimes within reasonable limits and to clean up expired certificates. For more information, see [Is there a limit for CRL size?](certificate-based-authentication-faq.yml#is-there-a-limit-for-crl-size-).

When a user performs an interactive sign-in with a certificate, and the CRL exceeds the interactive limit for a cloud, their initial sign-in fails with the following error:

"The Certificate Revocation List (CRL) downloaded from {uri} has exceeded the maximum allowed size ({size} bytes) for CRLs in Microsoft Entra ID. Try again in few minutes. If the issue persists, contact your tenant administrators."

After the error, Microsoft Entra ID attempts to download the CRL subject to the service-side limits (45 MB in public Microsoft Entra ID and 150 MB in Azure US Government clouds).

>[!IMPORTANT]
>If an Authentication Policy Administrator skips the configuration of the CRL, Microsoft Entra ID doesn't perform any CRL checks during the certificate-based authentication of the user. This can be helpful for initial troubleshooting, but shouldn't be considered for production use.

As of now, we don't support Online Certificate Status Protocol (OCSP) because of performance and reliability reasons. Instead of downloading the CRL at every connection by the client browser for OCSP, Microsoft Entra ID downloads once at the first sign-in and caches it, thereby improving the performance and reliability of CRL verification. We also index the cache so the search is much faster every time. Customers must publish CRLs for certificate revocation.

The following steps are a typical flow of the CRL check:

1. Microsoft Entra ID attempts to download the CRL at the first sign-in event of any user with a certificate of the corresponding trusted issuer or certificate authority. 
1. Microsoft Entra ID caches and reuses the CRL for any subsequent usage. It honors the **Next update date** and, if available, **Next CRL Publish date** (used by Windows Server CAs) in the CRL document.
1. The user certificate-based authentication fails if:
   - A CRL has been configured for the trusted issuer and Microsoft Entra ID can't download the CRL, due to availability, size, or latency constraints.
   - The user's certificate is listed as revoked on the CRL.
   
     :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/user-cert.png" alt-text="Screenshot of the revoked user certificate in the CRL." :::  

   - Microsoft Entra ID attempts to download a new CRL from the distribution point if the cached CRL document is expired. 

>[!NOTE]
>Microsoft Entra ID checks the CRL of the issuing CA and other CAs in the PKI trust chain up to the root CA. We have a limit of up to 10 CAs from the leaf client certificate for CRL validation in the PKI chain. The limitation is to make sure a bad actor doesn't bring down the service by uploading a PKI chain with a huge number of CAs with a bigger CRL size.
If the tenant's PKI chain has more than 5 CAs and in case of a CA compromise, Authentication Policy Administrators should remove the compromised trusted issuer from the Microsoft Entra tenant configuration.
 

>[!IMPORTANT]
>Due to the nature of CRL caching and publishing cycles, it is highly recommended in case of a certificate revocation to also revoke all sessions of the affected user in Microsoft Entra ID.

As of now, there's no way to manually force or retrigger the download of the CRL. 

### How to configure revocation

[!INCLUDE [Configure revocation](../../includes/entra-authentication-configure-revocation.md)]

### Understanding CRL validation

A CRL is a record of digital certificates that have been revoked before the end of their validity period by a certificate authority (CA).
When CAs are uploaded to the Microsoft Entra trust store, a CRL, or more specifically the CrlDistributionPoint attribute, isn't required. A CA can be uploaded without a CRL endpoint, and certificate-based authentication won't fail if an issuing CA doesn't have a CRL specified. 

To strengthen security and avoid misconfigurations, an Authentication Policy Administrator can require CBA authentication to fail if no CRL is configured for a CA that issues an end user certificate.

### Enable CRL validation

To enable CRL validation, click **Require CRL validation (recommended)**. 

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/require-validation.png" alt-text="Screenshot of how to require CRL validation." :::  

Once enabled, any CBA will fail is the end user certificate was issued by a CA with no CRL configured.

An Authentication Policy Administrator can exempt a CA if its CRL has issues that should be fixed. Click **Add Exemption** and select any CAs that should be exempted.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/exempt-validation.png" alt-text="Screenshot of how to exempt CAs from CRL validation." :::  

The CAs in the exempted list aren't required to have CRL configured and the end uer certificates that they issue don't fail authentication.

>[!NOTE]
>There's a known issue with the object picker where the selected items aren't displayed correctly. Use the **Certificate Authorities** tab to select or remove CAs.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/exempted.png" alt-text="Screenshot of CAs that are exempted from CRL validation." :::  


## How CBA works with a Conditional Access authentication strength policy

Customers can create a Conditional Access authentication strength policy to specify that CBA be used to access a resource.  

You can use the built-in **Phishing-resistant MFA** authentication strength. That policy only allows authentication methods that are phishing-resistant like CBA, FIDO2 security keys, and Windows Hello for Business. 

You can also create a custom authentication strength to allow only CBA to access sensitive resources. You can allow CBA as a single-factor, multifactor, or both. For more information, see [Conditional Access authentication strength](concept-authentication-strengths.md).

### CBA authentication strength with advanced options

In the CBA Authentication methods policy, an Authentication Policy Administrator can determine the strength of the certificate by using [authentication binding policy](#understanding-the-authentication-binding-policy) on the CBA method. Now you can configure **Advanced options** when you create a custom authentication strength to require a specific certificate to be used, based on issuer and policy OIDs, when users perform CBA to access certain sensitive resources. This feature provides a more precise configuration to determine the certificates and users that can access resources. For more information, see [Advanced options for Conditional Access authentication strength](concept-authentication-strength-advanced-options.md).

## Understanding Sign-in logs

Sign-in logs provide information about sign-ins and how your resources are used by your users. For more information about sign-in logs, see [Sign-in logs in Microsoft Entra ID](../monitoring-health/concept-sign-ins.md).

Let's walk through two scenarios, one where the certificate satisfies single-factor authentication and another where the certificate satisfies MFA.

For the test scenarios, choose a user with a Conditional Access policy that requires MFA. 
Configure the user binding policy by mapping SAN Principal Name to UserPrincipalName.

The user certificate should be configured like this screenshot:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/user-certificate.png" alt-text="Screenshot of the user certificate." :::  

### Troubleshooting sign-in issues with dynamic variables in sign-in logs
Although sign-in logs provide all the information to debug a user's sign-in issues, there are times when specific values are required and since sign-in logs do not support dynamic variables, the sign-in logs would have missing information.
For ex: The failure reason in sign-in log would show something like "The Certificate Revocation List (CRL) failed signature validation. Expected Subject Key Identifier {expectedSKI} does not match CRL Authority Key {crlAK}. Please request your tenant administrator to check the CRL configuration." where {expectedSKI} and {crlAKI} are not populated with correct values.

When users sign-in with CBA fails, please copy the log details from 'More Details' link in the error page. For more detailed info, look at [understanding CBA error page](./concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-certificate-based-authentication-error-page)

### Test single-factor authentication 

For the first test scenario, configure the authentication policy where the Issuer subject rule satisfies single-factor authentication.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/single-factor.png" alt-text="Screenshot of the Authentication policy configuration showing single-factor authentication required." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/single-factor.png":::  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as the test user by using CBA. The authentication policy is set where Issuer subject rule satisfies single-factor authentication.
1. Search for and select **Sign-in logs**.

   Let's look closer at some of the entries you can find in the **Sign-in logs**.

   The first entry requests the X.509 certificate from the user. The status **Interrupted** means that Microsoft Entra ID validated that CBA is enabled in the tenant and a certificate is requested for authentication.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/entry-one.png" alt-text="Screenshot of single-factor authentication entry in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/entry-one.png":::  

   The **Activity Details** shows this is just part of the expected login flow where the user selects a certificate. 
   
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-activity-details.png" alt-text="Screenshot of activity details in the sign-in logs." :::  

   The **Additional Details** show the certificate information.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/additional-details.png" alt-text="Screenshot of multifactor additional details in the sign-in logs." :::  

   These additional entries show that the authentication is complete, a primary refresh token is sent back to the browser, and user is given access to the resource.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/refresh-token.png" alt-text="Screenshot of refresh token entry in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/refresh-token.png":::  

### Test multifactor authentication

For the next test scenario, configure the authentication policy where the **policyOID** rule satisfies multifactor authentication.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/multifactor.png" alt-text="Screenshot of the Authentication policy configuration showing multifactor authentication required." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/multifactor.png":::  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) using CBA. Since the policy was set to satisfy multifactor authentication, the user sign-in is successful without a second factor.
1. Search for and select **Sign-ins**.

   You'll see several entries in the Sign-in logs, including an entry with **Interrupted** status. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/several-entries.png" alt-text="Screenshot of several entries in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/several-entries.png":::  

    The **Activity Details** shows this is just part of the expected login flow where the user selects a certificate. 
   
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/mfacert-activity-details.png" alt-text="Screenshot of second-factor sign-in details in the sign-in logs." :::  
   
   The entry with **Interrupted** status has more diagnostic info on the **Additional Details** tab. 

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/interrupted-user-details.png" alt-text="Screenshot of interrupted attempt details in the sign-in logs." :::  

   The following table has a description of each field.

   | Field   | Description  |
   |---------|--------------|
   | User certificate subject name | Refers to the subject name field in the certificate. |
   | User certificate binding | Certificate: Principal Name; User Attribute: userPrincipalName; Rank: 1<br>This shows which SAN PrincipalName certificate field was mapped to userPrincipalName user attribute and was priority 1. |
   | User certificate authentication level | multiFactorAuthentication |
   | User certificate authentication level type | PolicyId<br>This shows policy OID was used to determine the authentication strength. |
   | User certificate authentication level identifier | 1.2.3.4<br>This shows the value of the identifier policy OID from the certificate. |

## Understanding the certificate-based authentication error page

Certificate-based authentication can fail for reasons such as the certificate being invalid, or the user selected the wrong certificate or an expired certificate, or because of a Certificate Revocation List (CRL) issue. When certificate validation fails, the user sees this error:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/validation-error.png" alt-text="Screenshot of a certificate validation error." :::  

If CBA fails on a browser, even if the failure is because you cancel the certificate picker, you need to close the browser session and open a new session to try CBA again. A new session is required because browsers cache the certificate. When CBA is retried, the browser sends the cached certificate during the TLS challenge, which causes sign-in failure and the validation error.
 
Select **More details** to get logging information that can be sent to an Authentication Policy Administrator, who in turn can get more information from the Sign-in logs.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/details.png" alt-text="Screenshot of error details." :::  

Select **Other ways to sign in** to try other methods available to the user to sign in. 
 
>[!NOTE]
>If you retry CBA in a browser, it'll keep failing due to the browser caching issue. Users need to open a new browser session and sign in again.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/new-sign-in.png" alt-text="Screenshot of a new sign-in attempt." :::  

## Certificate-based authentication in MostRecentlyUsed (MRU) methods
 
Once a user authenticates successfully using CBA, the user's MostRecentlyUsed (MRU) authentication method is set to CBA. Next time, when the user enters their UPN and selects **Next**, the user is taken to the CBA method directly, and need not select **Use the certificate or smart card**.

To reset the MRU method, the user needs to cancel the certificate picker, select **Other ways to sign in**, and select another method available to the user and authenticate successfully.

## External identity support

An external identity can't perform multifactor authentication to the resource tenant with Microsoft Entra CBA. Instead, have the user perform MFA using CBA in the home tenant, and set up cross tenant settings for the resource tenant to trust MFA from the home tenant.

For more information about how to enable **Trust multifactor authentication from Microsoft Entra tenants**, see [Configure B2B collaboration cross-tenant access](../../external-id/cross-tenant-access-settings-b2b-collaboration.yml).

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
