---
title: Microsoft Entra CBA Technical Concepts
description: Learn how Microsoft Entra certificate-based authentication (CBA) works and the technical concepts you need to set up and manage CBA.
ms.service: entra-id
ms.subservice: authentication
ms.topic: concept-article
ms.date: 03/04/2025
ms.author: justinha
author: vimrang
manager: dougeby
ms.reviewer: vraganathan
ms.custom: has-adal-ref, sfi-image-nochange
ms.localizationpriority: high
---

# Microsoft Entra certificate-based authentication technical concepts

This article describes technical concepts to explain how Microsoft Entra certificate-based authentication (CBA) works. Get the technical background to better know how to set up and manage Microsoft Entra CBA in your tenant.

## How does Microsoft Entra certificate-based authentication work?

The following figure depicts what happens when a user tries to sign in to an application in a tenant that has Microsoft Entra CBA configured.

:::image type="content" border="false" source="./media/concept-certificate-based-authentication-technical-deep-dive/how-it-works.png" alt-text="Diagram that shows an overview of the steps in Microsoft Entra certificate-based authentication." :::

The following steps summarize the Microsoft Entra CBA process:

1. A user tries to access an application, such as the [MyApps portal](https://myapps.microsoft.com/).
1. If the user isn't already signed in, they're redirected to the Microsoft Entra ID user sign-in page at `https://login.microsoftonline.com/`.
1. They enter their username on the Microsoft Entra sign-in page, and then select **Next**. Microsoft Entra ID completes home realm discovery by using the tenant name. It uses the username to look up the user in the tenant.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in.png" alt-text="Screenshot that shows the sign-in page for the MyApps portal.":::
  
1. Microsoft Entra ID checks whether CBA is set up for the tenant. If CBA is set up, the user sees a link to **Use a certificate or smart card** on the password page. If the user doesn't see the sign-in link, make sure that CBA is set up for the tenant.

   For more information, see [How do we turn on Microsoft Entra CBA?](./certificate-based-authentication-faq.yml#how-do-we-turn-on-microsoft-entra-cba-).

   > [!NOTE]
   > If CBA is set up for the tenant, all users see the **Use a certificate or smart card** link on the password sign-in page. However, only users who are in scope for CBA can successfully authenticate for an application that uses Microsoft Entra ID as their identity provider.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-cert.png" alt-text="Screenshot that shows the option to use a certificate or smart card.":::

   If you make other authentication methods available, like phone sign-in or security keys, your users might see a different sign-in dialog.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-alt.png" alt-text="Screenshot that shows the sign-in dialog if FIDO2 authentication is also available.":::

1. After the user selects CBA, the client redirects to the certificate authentication endpoint. For public Microsoft Entra ID, the certificate authentication endpoint is `https://certauth.login.microsoftonline.com`. For [Azure Government](/azure/azure-government/compare-azure-government-global-azure#guidance-for-developers), the certificate authentication endpoint is `https://certauth.login.microsoftonline.us`.  

   The endpoint performs Transport Layer Security (TLS) mutual authentication and requests the client certificate as part of the TLS handshake. An entry for this request appears in the sign-in log.

   > [!NOTE]
   > An administrator should allow access to the user sign-in page and to the `*.certauth.login.microsoftonline.com` certificate authentication endpoint for your cloud environment. Turn off TLS inspection on the certificate authentication endpoint to ensure that the client certificate request succeeds as part of the TLS handshake.
   >
   > Make sure that turning off TLS inspection also works for issuer hints with the new URL. Don't hard-code the URL with the tenant ID. The tenant ID might change for business-to-business (B2B) users. Use a regular expression to allow both the previous URL and the new URL to work when you turn off TLS inspection. For example, depending on the proxy, use `*.certauth.login.microsoftonline.com` or `*certauth.login.microsoftonline.com`. In Azure Government, use `*.certauth.login.microsoftonline.us` or `*certauth.login.microsoftonline.us`.

   Unless access is allowed, CBA fails if you turn on [issuer hints](#issuer-hints-preview).

1. Microsoft Entra ID requests a client certificate. The user selects the client certificate, and then selects **OK**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png" alt-text="Screenshot that shows the certificate picker." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png":::

1. Microsoft Entra ID verifies the certificate revocation list (CRL) to make sure that the certificate isn't revoked and that it's valid. Microsoft Entra ID identifies the user by using the [username binding configured](how-to-certificate-based-authentication.md#step-4-configure-username-binding-policy) on the tenant to map the certificate field value to the user attribute value.
1. If a unique user is found via a Microsoft Entra Conditional Access policy that requires multifactor authentication (MFA) and the [certificate authentication binding rule](how-to-certificate-based-authentication.md#step-3-configure-an-authentication-binding-policy) satisfies MFA, Microsoft Entra ID signs in the user immediately. If MFA is required but the certificate satisfies only a single factor, if the user is already registered, passwordless sign-in and FIDO2 are offered as second factors.
1. Microsoft Entra ID completes the sign-in process by sending a primary refresh token back to indicate successful sign-in.

If user sign-in is successful, the user can access the application.

## Issuer hints (preview)

Issuer hints send back a *trusted CA* indicator as part of the TLS handshake. The trusted CA list is set to the subject of the CAs that the tenant uploads to the Microsoft Entra trust store. A browser client or native application client can use the hints that the server sends back to filter the certificates shown in the certificate picker. The client shows only the authentication certificates issued by the CAs in the trust store.

### Turn on issuer hints

To turn on issuer hints, select the **Issuer Hints** checkbox. An [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) should select **I Acknowledge** after making sure that the proxy that has TLS inspection set up is updated correctly, and then save the changes.

> [!NOTE]
> If your organization has firewalls or proxies that use TLS inspection, acknowledge that you turned off TLS inspection of the CA endpoint that is capable of matching any name under `[*.]certauth.login.microsoftonline.com`, customized according to the specific proxy in use.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/issuer-hints.png" alt-text="Screenshot that shows how to turn on issuer hints." lightbox="media/concept-certificate-based-authentication-technical-deep-dive/issuer-hints.png":::

> [!NOTE]
> After you turn on issuer hints, the CA URL has the format `<tenantId>.certauth.login.microsoftonline.com`.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/issuer-hints-picker.png" alt-text="Screenshot that shows the certificate picker after you turn on issuer hints.":::

### CA trust store update propagation

After you turn on issuer hints and add, update, or delete CAs from the trust store, a delay of up to 10 minutes might occur while issuer hints propagate back to the client. An Authentication Policy Administrator should sign in with a certificate after issuer hints are made available to initiate propagation.

Users can't authenticate by using certificates that are issued by new CAs until hints are propagated. Users see the following error message when CA trust store updates are being propagated:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/propagation-error.png" alt-text="Screenshot that shows the error users see if updates are in progress.":::

## MFA with single-factor CBA

Microsoft Entra CBA qualifies for both first-factor authentication and second-factor authentication.

Here are some supported combinations:

- CBA (first factor) and [passkeys](../authentication/how-to-enable-authenticator-passkey.md) (second factor)
- CBA (first factor) and [passwordless phone sign-in](../authentication/howto-authentication-passwordless-phone.md#enable-passwordless-phone-sign-in-authentication-methods) (second factor)
- CBA (first factor) and [FIDO2 security keys](../authentication/howto-authentication-passwordless-security-key-windows.md) (second factor)
- Password (first factor) and CBA (second factor) (preview)

> [!NOTE]
> Currently, using CBA as a second factor on iOS has [known issues](./concept-certificate-based-authentication-mobile-ios.md#known-issues) and is blocked on iOS. We're working to resolve the issues.

Users must have a way to get MFA and register passwordless sign-in or FIDO2 in advance of signing in by using Microsoft Entra CBA.

> [!IMPORTANT]
> A user is considered MFA capable if their username appears in the CBA method settings. In this scenario, the user can't use their identity as part of their authentication to register other available methods. Make sure that users without a valid certificate aren't included in the CBA method settings. For more information about how authentication works, see [Microsoft Entra multifactor authentication](../authentication/concept-mfa-howitworks.md).

## Options to get MFA capability with single-factor certificates

Microsoft Entra CBA can be either single-factor or multifactor depending on the tenant configuration. Turning on CBA makes a user potentially capable of completing MFA. A user that has a single-factor certificate must use another factor to complete MFA.

We don't allow registration of other methods without first satisfying MFA. If the user doesn't have any other MFA method registered and is in scope for CBA, the user can't use identity proof to register other authentication methods and get MFA.

If the CBA-capable user has only a single-factor certificate and needs to complete MFA, choose *one* of these options to authenticate the user:

- The user can enter a password and use a single-factor certificate.
- An Authentication Policy Administrator can issue a temporary access pass.
- An Authentication Policy Administrator can add a phone number and allow voice or text message authentication for the user account.

If the CBA-capable user hasn't been issued a certificate and needs to complete MFA, choose *one* of these options to authenticate the user:

- An Authentication Policy Administrator can issue a temporary access pass.
- An Authentication Policy Administrator can add a phone number and allow voice or text message authentication for the user account.

If the CBA-capable user can't use a multifactor certificate, such as if they're using a mobile device without smart card support but they need to complete MFA, choose *one* of these options to authenticate the user:

- An Authentication Policy Administrator can issue a temporary access pass.
- The user can register another MFA method (when the user *can* use a multifactor certificate on a device).
- An Authentication Policy Administrator can add a phone number and allow voice or text message authentication for the user account.

### Set up passwordless phone sign-in with CBA

For passwordless phone sign-in to work, first turn off legacy notification through mobile app for the user.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).

1. Complete the steps described in [Enable passwordless phone sign-in authentication](../authentication/howto-authentication-passwordless-phone.md#enable-passwordless-phone-sign-in-authentication-methods).

   > [!IMPORTANT]
   > Make sure that you select the **Passwordless** option. For any groups you add to passwordless phone sign-in, you must change the value for **Authentication mode** to **Passwordless**. If you select **Any**, CBA and passwordless sign-in don't work.

1. Select **Entra ID** > **Multifactor authentication** > **Additional cloud-based multifactor authentication settings**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/configure.png" alt-text="Screenshot that shows how to configure the MFA settings.":::

1. Under **Verification options**, clear the **Notification through mobile app** checkbox, and then select **Save**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/clear-notification.png" alt-text="Screenshot that shows how to remove the notification through mobile app option.":::

## MFA authentication flow by using single-factor certificates and passwordless sign-in

Consider an example of a user who has a single-factor certificate and is configured for passwordless sign-in. As the user, you would complete these steps:

1. Enter your user principal name (UPN), and then select **Next**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/user-principal-name.png" alt-text="Screenshot that shows how to enter a user principal name.":::

1. Select **Use a certificate or smart card**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-cert.png" alt-text="Screenshot that shows how to sign in with a certificate.":::

   If you make other authentication methods available, like phone sign-in or security keys, your users might see a different sign-in dialog.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-alt.png" alt-text="Screenshot that shows an alternative way to sign in with a certificate.":::

1. In the client certificate picker, select the correct user certificate, and then select **OK**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-picker.png" alt-text="Screenshot that shows how to select a certificate.":::

1. Because the certificate is configured to be the strength of single-factor authentication, you need a second factor to meet MFA requirements. Available second factors are shown in the sign-in dialog. In this case, it's passwordless sign-in. Select **Approve a request on my Microsoft Authenticator app**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/second-factor-request.png" alt-text="Screenshot that shows completing a second-factor request.":::

1. You get a notification on your phone. Select **Approve sign-in?**.
   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/approve.png" alt-text="Screenshot that shows the phone approval request.":::

1. In Microsoft Authenticator, enter the number you see in the browser or app.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/number.png" alt-text="Screenshot that shows a number match." lightbox="media/concept-certificate-based-authentication-technical-deep-dive/number.png":::

1. Select **Yes**, and you can authenticate and sign in.

## Authentication binding policy

The authentication binding policy helps set the strength of authentication as either single-factor or multifactor. An Authentication Policy Administrator can change the default method from single-factor to multifactor. An admin also can set up custom policy configurations either by using `IssuerAndSubject`, `PolicyOID`, or `Issuer` and `PolicyOID` in the certificate.

### Certificate strength

Authentication Policy Administrators can determine whether the certificate strength is single-factor or multifactor. For more information, see the documentation that maps [NIST Authentication Assurance Levels to Microsoft Entra auth Methods](https://aka.ms/AzureADNISTAAL), which builds upon [NIST 800-63B SP 800-63B, Digital Identity Guidelines: Authentication and Lifecycle Mgmt](https://csrc.nist.gov/publications/detail/sp/800-63b/final).

### Multifactor certificate authentication

When a user has a multifactor certificate, they can perform MFA only by using certificates. However, an Authentication Policy Administrator should make sure that the certificates are protected by a PIN or biometric to be considered multifactor.

### Multiple authentication policy binding rules

You can create multiple custom authentication binding policy rules by using different certificate attributes. An example is using the issuer and the policy OID, or just the policy OID, or just the issuer.

The following sequence determines the authentication protection level when custom rules overlap:

1. Issuer and policy OID rules take precedence over policy OID rules. Policy OID rules take precedence over certificate issuer rules.
1. Issuer and policy OID rules are evaluated first. If you have a custom rule with issuer CA1 and policy OID `1.2.3.4.5` with MFA, only certificate A that satisfies both the issuer value and the policy OID is given MFA.
1. Custom rules that use policy OIDs are evaluated. If you have a certificate A with policy OID of `1.2.3.4.5` and a derived credential B based on that certificate that has a policy OID  of `1.2.3.4.5.6`, and the custom rule is defined as a policy OID that has the value `1.2.3.4.5` with MFA, only certificate A satisfies MFA. Credential B satisfies only single-factor authentication. If the user used a derived credential during sign-in and was configured for MFA, the user is asked for a second factor for successful authentication.
1. If there's a conflict between multiple policy OIDs (such as when a certificate has two policy OIDs, where one binds to single-factor authentication and the other binds to MFA), then treat the certificate as single-factor authentication.
1. Custom rules that use issuer CAs are evaluated. If a certificate has matching policy OID and issuer rules, the policy OID is always checked first. If no policy rule is found, then the issuer bindings are checked. The policy OID has a higher strong-authentication binding priority than the issuer.
1. If one CA binds to MFA, all user certificates that the CA issues qualify as MFA. The same logic applies to single-factor authentication.
1. If one policy OID binds to MFA, all user certificates that include this policy OID as one of the OIDs  qualify as MFA. (A user certificate can have multiple policy OIDs.)
1. One certificate issuer can only have one valid strong-authentication binding (that is, a certificate can't bind to both single-factor authentication and to MFA).

> [!IMPORTANT]
> Currently, in a known issue that is being addressed, if an Authentication Policy Administrator creates a CBA policy rule by using both the issuer and the policy OID, some device registration scenarios are affected.
>
> The affected scenarios include:
>
> - Windows Hello for Business enrollment
> - FIDO2 security key registration
> - Windows passwordless phone sign-in
>  
> Device registration with Workplace Join, Microsoft Entra ID, and Microsoft Entra hybrid joined scenarios aren't affected. CBA policy rules that use either the issuer *or* the policy OID aren't affected.
>
> To mitigate the issue, an Authentication Policy Administrator should complete *one* of the following options:
>
> - Edit the CBA policy rule that currently uses both the issuer and the policy OID to remove either the issuer or the policy ID requirement.
> - Remove the authentication policy rule that currently uses both the issuer and the policy OID, and then create a rule that uses only the issuer or the policy OID.

## Username binding policy

The username binding policy helps validate the certificate of the user. By default, the subject alternative name (SAN) Principal Name in the certificate is mapped to the `userPrincipalName` attribute of the user object to identify the user.

### Achieve higher security by using certificate bindings

Microsoft Entra support seven methods for using certificate bindings. In general, mapping types are considered high affinity if they're based on identifiers that you can't reuse, such as `SubjectKeyIdentifier` (`SKI`) or `SHA1PublicKey`. These identifiers convey a higher assurance that only a single certificate can be used to authenticate a user.

Mapping types based on usernames and email addresses are considered low affinity. Microsoft Entra ID implements three mappings that are considered low-affinity based on reusable identifiers. The others are considered high-affinity bindings. For more information, see [`certificateUserIds`](concept-certificate-based-authentication-certificateuserids.md).

| Certificate mapping field | Examples of values in `certificateUserIds` | User object attributes | Type |
|:--------------------------|:----------------------------------------:|:----------------------:|:----:|
|`PrincipalName` | `X509:<PN>bob@woodgrove.com` | `userPrincipalName` <br> `onPremisesUserPrincipalName` <br> `certificateUserIds` | Low affinity |
|`RFC822Name` | `X509:<RFC822>user@woodgrove.com` | `userPrincipalName` <br> `onPremisesUserPrincipalName` <br> `certificateUserIds` | Low affinity |
|`IssuerAndSubject` | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest` | `certificateUserIds` | Low affinity |
|`Subject` | `X509:<S>DC=com,DC=contoso,OU=UserAccounts,CN=mfatest`  | `certificateUserIds` | Low affinity |
|`SKI` | `X509:<SKI>aB1cD2eF3gH4iJ5kL6-mN7oP8qR=` | `certificateUserIds` | High affinity |
|`SHA1PublicKey` | `X509:<SHA1-PUKEY>aB1cD2eF3gH4iJ5kL6-mN7oP8qR` <br> The `SHA1PublicKey` value (SHA1 hash of the entire certificate content, including the public key) is in the **Thumbprint** property of the certificate.| `certificateUserIds` | High affinity |
|`IssuerAndSerialNumber` | `X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT` <br> To get the correct value for the serial number, run this command and store the value shown in `certificateUserIds`:<br> **Syntax**:<br> `certutil –dump –v [~certificate path~] >> [~dumpFile path~]` <br> **Example**: <br> `certutil -dump -v firstusercert.cer >> firstCertDump.txt` | `certificateUserIds` | High affinity |

> [!IMPORTANT]
> You can use the [`CertificateBasedAuthentication` PowerShell module](concept-certificate-based-authentication-certificateuserids.md#how-to-find-the-correct-certificateuserids-values-for-a-user-from-the-end-user-certificate-using-powershell-module) to find the correct `certificateUserIds` value for a user in a certificate.

### Define and override affinity binding

An Authentication Policy Administrator can configure whether users can authenticate by using low-affinity or high-affinity username binding mapping.

Set **Required affinity binding** for the tenant, which applies to all users. To override the tenant-wide default value, create custom rules based on the issuer and the policy OID, or just the policy OID, or just the issuer.

### Multiple username policy binding rules

To resolve multiple username policy binding rules, Microsoft Entra ID uses the highest priority (lowest number) binding:

1. Looks up the user object by using the username or UPN.
1. Gets the list of all username bindings set up by the Authentication Policy Administrator in the CBA method configuration ordered by the `priority` attribute. Currently, priority isn't shown in the admin center. Microsoft Graph returns the `priority` attribute for each binding. Then, priorities are used in the evaluation process.
1. If the tenant has high-affinity binding configured or if the certificate value matches a custom rule that requires high-affinity binding, removes all the low-affinity bindings from the list.
1. Evaluates each binding in the list until a successful authentication occurs.
1. If the X.509 certificate field of the configured binding is on the presented certificate, Microsoft Entra ID matches the value in the certificate field to the user object attribute value.
   - If a match is found, user authentication is successful.
   - If a match isn't found, moves to the next priority binding.
1. If the X.509 certificate field isn't on the presented certificate, moves to the next priority binding.
1. Validates all configured username bindings until one of them results in a match and user authentication is successful.
1. If a match isn't found on any of the configured username bindings, user authentication fails.

## Secure Microsoft Entra configuration by using multiple username bindings

Each of the Microsoft Entra user object attributes available to bind certificates to Microsoft Entra user accounts (`userPrincipalName`, `onPremiseUserPrincipalName`, and `certificateUserIds`) has a unique constraint to ensure that a certificate only matches a single Microsoft Entra user account. However, Microsoft Entra CBA supports multiple binding methods in the username binding policy. An Authentication Policy Administrator can accommodate one certificate used in multiple Microsoft Entra user accounts configurations.

> [!IMPORTANT]
> If you configure multiple bindings, Microsoft Entra CBA authentication is only as secure as your lowest-affinity binding because CBA validates each binding to authenticate the user. To prevent a scenario where a single certificate matches multiple Microsoft Entra accounts, an Authentication Policy Administrator can:
>
> - Configure a single binding method in the username binding policy.
> - If a tenant has multiple binding methods configured and doesn't want to allow one certificate to map to multiple accounts, an Authentication Policy Administrator must ensure that all allowable methods configured in the policy map to the same Microsoft Entra account. All user accounts should have values that match all the bindings.
> - If a tenant has multiple binding methods configured, an Authentication Policy Administrator should ensure that they don't have more than one low-affinity binding.

For example, you have two username bindings on `PrincipalName` mapped to `UPN`, and `SubjectKeyIdentifier` (`SKI`) is mapped to `certificateUserIds`. If you want a certificate to be used for only a single account, an Authentication Policy Administrator must make sure that the account has the UPN that is present in the certificate. Then, the admin implements the `SKI` mapping in the `certificateUserIds` attribute of the same account.

### Support for multiple certificates with one Microsoft Entra user account (M:1)

In some scenarios, an organization issues multiple certificates for a single identity. It might be a derived credential for a mobile device, but it also might be for a secondary smart card or X.509 credential holder-capable device such as a YubiKey.

#### Cloud-only accounts (M:1)

For cloud-only accounts, you can map up to five certificates to use by populating the `certificateUserIds` field with unique values to identify each certificate. To map the certificates, in the admin center, go to the **Authorization info** tab.

If the organization uses high-affinity bindings like `IssuerAndSerialNumber`, values in `certificateUserIds` might look like the following example:

`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8-qR9sT0uV`

In this example, the first value represents *X509Certificate1*. The second value represents *X509Certificate2*. The user can present either certificate at sign-in. If the CBA username binding is set to point to the `certificateUserIds` field to look for the specific binding type (in this example, `IssuerAndSerialNumber`), the user successfully signs in.

#### Hybrid synchronized accounts (M:1)

For synchronized accounts, you can map multiple certificates. In on-premises Active Directory, populate the `altSecurityIdentities` field with the values that identify each certificate. If your organization uses high-affinity bindings (that is, strong authentication) like `IssuerAndSerialNumber`, the values might look like these examples:

`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>eF3gH4iJ5kL6mN7oP8-qR9sT0uV`

In this example, the first value represents *X509Certificate1*. The second value represents *X509Certificate2*. The values must then be synced to the `certificateUserIds` field in Microsoft Entra ID.  

### Support for one certificate with multiple Microsoft Entra user accounts (1:M)

In some scenarios, an organization requires a user to use the same certificate to authenticate into multiple identities. It might be for an administrative account or for a developer or temporary duty account.

In on-premises Active Directory, the `altSecurityIdentities` field populates the certificate values. A hint is used during sign-in to direct Active Directory to the intended account to check for sign-in.

Microsoft Entra CBA has a different process, and no hint is included. Instead, Home realm discovery identifies the intended account and checks the certificate values. Microsoft Entra CBA also enforces uniqueness in the `certificateUserIds` field. Two accounts can't populate the same certificate values.

> [!IMPORTANT]
> Using the same credentials to authenticate into different Microsoft Entra accounts isn't a secure configuration. We recommend that you don't allow a single certificate to be used for multiple Microsoft Entra user accounts.

#### Cloud-only accounts (1:M)

For cloud-only accounts, create multiple username bindings and map unique values to each user account  that uses the certificate. Access to each account is authenticated by using a different username binding. This authentication level applies to the boundary of a single directory or tenant. An Authentication Policy Administrator can map the certificate to use it in another directory or tenant if the values remain unique per account.  

Populate the `certificateUserIds` field with a unique value that identifies the certificate. To populate the field, in the admin center, go to the **Authorization info** tab.

If the organization uses high-affinity bindings (that is, strong authentication) like `IssuerAndSerialNumber` and `SKI`, the values might look like the following example:

Username bindings:

- `IssuerAndSerialNumber` > `certificateUserIds`
- `SKI` > `certificateUserIds`

User account `certificateUserIds` values:\
`X509:<I>DC=com,DC=contoso,CN=CONTOSO-DC-CA<SR>aB1cD2eF3gH4iJ5kL6-mN7oP8qR`\
`X509:<SKI>cD2eF3gH4iJ5kL6mN7-oP8qR9sT`

Now, when either user presents the same certificate at sign-in, the user successfully signs in because their account matches a unique value on that certificate. One account is authenticated by using `IssuerAndSerialNumber` and the other by using `SKI` binding.

> [!NOTE]
> The number of accounts that can be used in this manner is limited by the number of username bindings configured on the tenant. If the organization uses only high-affinity bindings, the maximum number of accounts supported is three. If the organization also uses low-affinity bindings, the number increases to seven accounts: one `PrincipalName`, one `RFC822Name`, one `SKI`, one `SHA1PublicKey`, one `IssuerAndSubject`, one `IssuerAndSerialNumber`, and one `Subject`.

#### Hybrid synchronized accounts (1:M)

Synchronized accounts require a different approach. Although an Authentication Policy Administrator can map unique values to each user account that uses the certificate, the common practice of populating all values to each account in Microsoft Entra ID makes this approach difficult. Instead, Microsoft Entra Connect should filter the values per account to unique values populated into the account in Microsoft Entra ID. The uniqueness rule applies to the boundary of a single directory or tenant. An Authentication Policy Administrator can map the certificate to use it in another directory or tenant if the values remain unique per account.

The organization might also have multiple Active Directory forests that contribute users to a single Microsoft Entra tenant. In this case, Microsoft Entra Connect applies the filter to each of the Active Directory forests with the same goal: populate only a specific, unique value to the cloud account.

Populate the `altSecurityIdentities` field in Active Directory with the values that identify the certificate. Include the specific certificate value for that user account type (such as `detailed`, `admin`, or `developer`). Select a key attribute in Active Directory. The attribute tells synchronization which user account type the user is evaluating (such as `msDS-cloudExtensionAttribute1`). Populate this attribute with the user type value you want to use, such as `detailed`, `admin`, or `developer`. If the account is the user’s primary account, the value can be empty or NULL.

Check that the accounts look similar to these examples:

Forest 1: Account1 (<bob@woodgrove.com>):\
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`

Forest 1: Account2 (<bob-admin@woodgrove.com>): \
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`

Forest 2: ADAccount1 (<bob-tdy@woodgrove.com>):\
`X509:<SKI>aB1cD2eF3gH4iJ5kL6mN7oP8qR`\
`X509:<SHA1-PUKEY>cD2eF3gH4iJ5kL6mN7oP8qR9sT`\
`X509:<PN>bob@woodgrove.com`

You must then sync these values to the `certificateUserIds` field in Microsoft Entra ID.

To sync to `certificateUserIds`:

1. Configure Microsoft Entra Connect to add the `alternativeSecurityIds` field to the metaverse.
1. For each on-premises Active Directory forest, configure a new custom inbound rule with a high precedence (a low number, below 100). Add an `Expression` transform with the `altSecurityIdentities` field as the source. The target expression uses the key attribute that you selected and populated, and it uses the mapping to the user types you defined.

For example:

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

In this example, `altSecurityIdentities` and the key attribute `msDS-cloudExtensionAttribute1` are first checked to see if they're populated. If they aren't populated, `altSecurityIdentities` is checked to see if it's populated. If it's empty, set it to NULL. Otherwise, the account is a default scenario.

Also in this example, filter only on the `IssuerAndSerialNumber` mapping. If the key attribute is populated, then the value is checked to see if it's equal to one of your defined user types. In the example, if that value is `detailed`, filter on the `SHA1PublicKey` value from `altSecurityIdentities`. If the value is `developer`, filter on the `SubjectKeyIssuer` value from `altSecurityIdentities`.

You might encounter multiple certificate values of a specific type. For example, you might see multiple `PrincipalName` values or multiple `SKI` or `SHA1-PUKEY` values. The filter gets all the values and syncs them in Microsoft Entra ID, not just the first one that it finds.

Here's a second example that shows how to push an empty value if the control attribute is empty:

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

If the value in `altSecurityIdentities` doesn't match any of the search values in the control attribute, an `AuthoritativeNull` value is passed. This value ensures that prior or subsequent rules that populate `alternativeSecurityId` are ignored. The result is empty in Microsoft Entra ID.

To sync an empty value:

1. Configure a new custom outbound rule with a low precedence (a high number, above 160 but from the bottom of the list).
1. Add a direct transform with the `alternativeSecurityIds` field as the source and the `certificateUserIds` field as the target.
1. Run a synchronization cycle to complete data population in Microsoft Entra ID.

Ensure that CBA in each tenant is configured with the username bindings pointing to the `certificateUserIds` field for the field types that you mapped from the certificate. Now any of these users can present the certificate at sign-in. After the unique value from the certificate is validated against the `certificateUserIds` field, the user is successfully signed in.


## Certificate Authority (CA) Scoping (Preview)

CA scoping in Microsoft Entra allows tenant administrators to restrict the use of specific CAs to defined user groups. This feature enhances the security and manageability of CBA by ensuring that only authorized users can authenticate by using certificates issued by specific CAs.

CA scoping is useful in multi-PKI or B2B scenarios where multiple CAs are used across different user populations. It helps prevent unintended access and supports compliance with organizational policies.

### Key benefits

- Restricts certificate use to specific user groups
- Supports complex PKI environments through multiple CAs
- Provides enhanced protection against certificate misuse or compromise
- Gives visibility into CA usage via sign-in logs and monitoring tools

An admin can use CA scoping to define rules that associate a CA (identified by its SKI) with a specific Microsoft Entra group. When a user attempts to authenticate by using a certificate, the system checks whether the issuing CA for the certificate is scoped to a group that includes the user. Microsoft Entra proceeds up the CA chain. It applies all scope rules until the user is found in one of the groups in all the scope rules. If the user isn't in the scoped group, authentication fails, even if the certificate is otherwise valid.

### Set up the CA scoping feature

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Go to **Entra ID** > **Authentication methods** > **Certificate-based authentication**.
1. Under **Configure**, go to **Certificate issuer scoping policy**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-config.png" alt-text="Screenshot that shows CA scoping policy.":::

1. Select **Add rule**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-add-rule.png" alt-text="Screenshot that shows how to add a CA scoping rule.":::

1. Select **Filter CAs by PKI**.

   **Classic CAs** shows all the CAs from the classic CA store. Selecting a specific PKI shows all the CAs from the selected PKI.

1. Select a PKI.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-pki-filter.png" alt-text="Screenshot that shows the CA scoping PKI filter.":::

1. The **Certificate issuer** list shows all the CAs from the selected PKI. Select a CA to create a scope rule.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-select-cert.png" alt-text="Screenshot that shows how to select a CA in CA scoping.":::

1. Select **Add group**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-add-group.png" alt-text="Screenshot that shows the add group option in CA scoping.":::

1. Select a group.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-select-group.png" alt-text="Screenshot that shows the select group option in CA scoping.":::

1. Select **Add** to save the rule.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-save-rule.png" alt-text="Screenshot that shows the save rule option in CA scoping.":::

1. Select the **I Acknowledge** checkbox, and then select **Save**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-save-cbaconfig.png" alt-text="Screenshot that shows the save CBA configuration option in CA scoping.":::

1. To edit or delete a CA scoping policy, select "..." on the rule row. To edit the rule, select **Edit**. To delete the rule, select **Delete**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-policy-edit-delete.png" alt-text="Screenshot that shows how to edit or delete in CA scoping.":::

### Known limitations

- Only one group can be assigned per CA.
- A maximum of 30 scoping rules is supported.
- Scoping is enforced at the intermediate CA level.
- Improper configuration might result in user lockouts if no valid scoping rules exist.

### Sign-in log entries

- The sign-in log shows success. On the **Additional Details** tab, the SKI of the CA from the scoping policy rule appears.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-log-success.png" alt-text="Screenshot that shows a CA scoping rule sign-in log success.":::

- When a CBA fails due to a CA scoping rule, the **Basic info** tab in the sign-in log shows the error code **500189**.

  :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/sign-in-log-error.png" alt-text="Screenshot that shows a CA scoping sign-in log error.":::

  End users see the following error message:

  :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-policy-user-error.png" alt-text="Screenshot that shows a CA scoping user error." lightbox="media/concept-certificate-based-authentication-technical-deep-dive/ca-scoping-policy-user-error.png":::

## How CBA works with a Conditional Access authentication strength policy

You can use the built-in Microsoft Entra *Phishing-resistant MFA* authentication strength to create a Conditional Access authentication policy that specifies to use CBA to access a resource. The policy allows only authentication methods that are phishing-resistant, like CBA, FIDO2 security keys, and Windows Hello for Business.

You can also create a custom authentication strength to allow only CBA to access sensitive resources. You can allow CBA as single-factor authentication, MFA, or both. For more information, see [Conditional Access authentication strength](concept-authentication-strengths.md).

### CBA strength with advanced options

In the CBA method policy, an Authentication Policy Administrator can determine the strength of the certificate by using an [authentication binding policy](#authentication-binding-policy) on the CBA method. Now you can require a specific certificate to be used based on issuer and policy OIDs when users perform CBA to access certain sensitive resources. When you create a custom authentication strength, go to **Advanced options**. The feature provides a more precise configuration to determine the certificates and users that can access resources. For more information, see [Advanced options for Conditional Access authentication strength](concept-authentication-strength-advanced-options.md).

## Sign-in logs

Sign-in logs provide information about sign-ins and how your resources are used in the organization. For more information, see [Sign-in logs in Microsoft Entra ID](../monitoring-health/concept-sign-ins.md).

Next, consider two scenarios. In one scenario, the certificate satisfies single-factor authentication. In the second scenario, the certificate satisfies MFA.

For the test scenarios, select a user who has a Conditional Access policy that requires MFA.

Configure the user binding policy by mapping **Subject Alternative Name** and **Principal Name** to the `userPrincipalName` user object.

The user certificate should be configured like the example shown in this screenshot:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/user-certificate.png" alt-text="Screenshot that shows the user certificate." :::  

### Troubleshoot sign-in issues with dynamic variables in sign-in logs

Although sign-in logs typically provide all the information you need to debug a sign-in issue, sometimes specific values are required. Sign-in logs don't support dynamic variables, so in some cases, the sign-in logs don't have the information you need for debugging.

For example, the failure reason in the sign-in logs might show `"The Certificate Revocation List (CRL) failed signature validation. Expected Subject Key Identifier <expectedSKI> doesn't match CRL Authority Key <crlAK>. Request your tenant administrator to check the CRL configuration."` In this scenario,`<expectedSKI>` and `<crlAKI>` aren't populated with correct values.

When user sign-in with CBA fails, you can copy the log details from the **More Details** link on the error page. For more information, see [Understanding the CBA error page](./concept-certificate-based-authentication-technical-deep-dive.md#cba-error-page).

### Test single-factor authentication

For the first test scenario, configure the authentication policy where the `IssuerAndSubject` rule satisfies single-factor authentication.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/single-factor.png" alt-text="Screenshot that shows the Authentication policy configuration and single-factor authentication required." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/single-factor.png":::  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as the test user by using CBA. The authentication policy is set where the `IssuerAndSubject` rule satisfies single-factor authentication.
1. Search for and then select **Sign-in logs**.

   The next figure shows some of the entries you can find in the sign-in logs.

   The first entry requests the X.509 certificate from the user. The **Interrupted** status means that Microsoft Entra ID validated that CBA is set up for the tenant. A certificate is requested for authentication.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/entry-one.png" alt-text="Screenshot that shows single-factor authentication entry in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/entry-one.png":::  

   **Activity Details** shows that the request is part of the expected sign-in flow in which the user selects a certificate.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/cert-activity-details.png" alt-text="Screenshot that shows activity details in the sign-in logs." :::  

   **Additional Details** shows the certificate information.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/additional-details.png" alt-text="Screenshot that shows multifactor additional details in the sign-in logs." :::  

   The other entries show that the authentication is complete, a primary refresh token is sent back to the browser, and the user is granted access to the resource.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/refresh-token.png" alt-text="Screenshot that shows a refresh token entry in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/refresh-token.png":::  

### Test MFA

For the next test scenario, configure the authentication policy where the `policyOID` rule satisfies MFA.

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/multifactor.png" alt-text="Screenshot that shows the Authentication policy configuration showing MFA required." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/multifactor.png":::  

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) by using CBA. Because the policy was set to satisfy MFA, the user sign-in is successful without a second factor.
1. Search for and then select **Sign-ins**.

   Several entries in the sign-in logs appear, including an entry with an **Interrupted** status.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/several-entries.png" alt-text="Screenshot that shows several entries in the sign-in logs." lightbox="./media/concept-certificate-based-authentication-technical-deep-dive/several-entries.png":::  

   **Activity Details** shows that the request is part of the expected sign-in flow in which the user selects a certificate.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/mfacert-activity-details.png" alt-text="Screenshot that shows second-factor sign-in details in the sign-in logs." :::  

   The entry with an **Interrupted** status displays more diagnostic information on the **Additional Details** tab.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/interrupted-user-details.png" alt-text="Screenshot that shows interrupted attempt details in the sign-in logs." :::  

   The following table has a description of each field.

   | Field   | Description  |
   |---------|--------------|
   | **User certificate subject name** | Refers to the subject name field in the certificate. |
   | **User certificate binding** | Certificate: `PrincipalName`; user attribute: `userPrincipalName`; Rank: 1<br>This field shows which SAN `PrincipalName` certificate field was mapped to the `userPrincipalName` user attribute and was priority 1. |
   | **User certificate authentication level** | `multiFactorAuthentication` |
   | **User certificate authentication level type** | `PolicyId`<br>This field shows that the policy OID was used to determine the authentication strength. |
   | **User certificate authentication level identifier** | `1.2.3.4`<br>This shows the value of the identifier policy OID from the certificate. |

## CBA error page

CBA might fail for multiple reasons. Examples include an invalid certificate, the user selected the wrong certificate or an expired certificate, or a CRL issue occurs. When certificate validation fails, the user sees this error message:

:::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/validation-error.png" alt-text="Screenshot that shows a certificate validation error." :::  

If CBA fails on a browser, even if the failure is because you cancel the certificate picker, close the browser session. Open a new session to try CBA again. A new session is required because browsers cache certificates. When CBA is retried, the browser sends a cached certificate during the TLS challenge, which then causes sign-in failure and the validation error.

1. To get logging information to send to an Authentication Policy Administrator for more information from the sign-in logs, select **More details**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/details.png" alt-text="Screenshot that shows error details." :::  

1. Select **Other ways to sign in** and try other available authentication methods to sign in.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/new-sign-in.png" alt-text="Screenshot that shows a new sign-in attempt." :::  

## Reset the certificate choice in Microsoft Edge

The Microsoft Edge browser added a feature that [resets the certificate selection without restarting the browser](concept-certificate-based-authentication-technical-deep-dive.md#reset-the-certificate-choice-in-microsoft-edge). 

The user completes the following steps:

1. When CBA fails, the error page appears.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/validation-error.png" alt-text="Screenshot that shows a certificate validation error." :::  

1. To the left of the address URL, select the lock icon, and then select **Your certificate choices**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/edge-certificate-choice.png" alt-text="Screenshot that shows the Microsoft Edge browser certificate choice." :::  

1. Select **Reset certificate choices**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/edge-certificate-choice-reset.png" alt-text="Screenshot that shows the Microsoft Edge browser certificate choice reset." :::

1. Select **Reset choices**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/edge-certificate-choice-reset-accept.png" alt-text="Screenshot that shows the Microsoft Edge browser certificate choice reset acceptance." :::

1. Select **Other ways to sign in**.

   :::image type="content" border="true" source="./media/concept-certificate-based-authentication-technical-deep-dive/validation-error.png" alt-text="Screenshot that shows a certificate validation error." :::

1. Select **Use a certificate or smart card** and continue with CBA authentication.

## CBA in MostRecentlyUsed methods

After a user authenticates successfully by using CBA, the user's `MostRecentlyUsed` (MRU) authentication method is set to CBA. The next time the user enters their UPN and selects **Next**, they see the CBA method and don't need to select **Use the certificate or smart card**.

To reset the MRU method, cancel the certificate picker, and then select **Other ways to sign in**. Select another available method, and then complete authentication.

The MRU authentication method is set at the user level. If a user successfully signs in on a different device by using a different authentication method, the MRU is reset for the user to the currently signed-in method.

## External identity support

An external identity B2B guest user can use CBA on the home tenant. If the cross-tenant settings for the resource tenant are set up to trust MFA from the home tenant, the user's CBA on the home tenant is honored. For more information, see [Configure B2B collaboration cross-tenant access](../../external-id/cross-tenant-access-settings-b2b-collaboration.yml). Currently, CBA on a resource tenant isn't supported.

## Related content

- [Overview of Microsoft Entra CBA](concept-certificate-based-authentication.md)
- [Set up Microsoft Entra CBA](how-to-certificate-based-authentication.md)
- [Microsoft Entra CBA on iOS devices](concept-certificate-based-authentication-mobile-ios.md)
- [Microsoft Entra CBA on Android devices](concept-certificate-based-authentication-mobile-android.md)
- [Windows smart card sign-in by using Microsoft Entra CBA](concept-certificate-based-authentication-smartcard.md)
- [Certificate user IDs](concept-certificate-based-authentication-certificateuserids.md)
- [Migrate federated users](concept-certificate-based-authentication-migration.md)
- [FAQ](certificate-based-authentication-faq.yml)
- [Troubleshoot Microsoft Entra CBA](./certificate-based-authentication-faq.yml)
