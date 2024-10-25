---
title: How to configure Microsoft Entra certificate-based authentication
description: Topic that shows how to configure Microsoft Entra certificate-based authentication in Microsoft Entra ID

ms.service: entra-id
ms.subservice: authentication
ms.topic: how-to
ms.date: 10/24/2024

ms.author: justinha
author: vimrang
manager: amycolannino
ms.reviewer: vraganathan
ms.custom: has-adal-ref, has-azure-ad-ps-ref
---
# How to configure Microsoft Entra certificate-based authentication

Microsoft Entra certificate-based authentication (CBA) enables organizations to configure their Microsoft Entra tenants to allow or require users to authenticate with X.509 certificates created by their Enterprise Public Key Infrastructure (PKI) for app and browser sign-in. This feature enables organizations to adopt phishing-resistant modern passwordless authentication by using an x.509 certificate.
 
During sign-in, users also see an option to authenticate with a certificate instead of entering a password. 
If multiple matching certificates are present on the device, the user can pick which one to use. The certificate is validated against the user account and if successful, they sign in.

<!---Clarify plans that are covered --->
Follow these instructions to configure and use Microsoft Entra CBA for tenants in Office 365 Enterprise and US Government plans. You should already have a [public key infrastructure (PKI)](https://aka.ms/securingpki) configured.

## Prerequisites

Make sure that the following prerequisites are in place:

- Configure at least one certificate authority (CA) and any intermediate CAs in Microsoft Entra ID.
- The user must have access to a user certificate (issued from a trusted Public Key Infrastructure configured on the tenant) intended for client authentication to authenticate against Microsoft Entra ID. 
- Each CA should have a certificate revocation list (CRL) that can be referenced from internet-facing URLs. If the trusted CA doesn't have a CRL configured, Microsoft Entra ID won't perform any CRL checking, revocation of user certificates won't work, and authentication won't be blocked.

>[!IMPORTANT]
>Make sure the PKI is secure and can't be easily compromised. In the event of a compromise, the attacker can create and sign client certificates and compromise any user in the tenant, both users whom are synchronized from on-premises and cloud-only users. However, a strong key protection strategy, along with other physical and logical controls, such as HSM activation cards or tokens for the secure storage of artifacts, can provide defense-in-depth to prevent external attackers or insider threats from compromising the integrity of the PKI. For more information, see [Securing PKI](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn786443(v=ws.11)).

>[!IMPORTANT]
>Please visit the [Microsoft recommendations](/security/sdl/cryptographic-recommendations#security-protocol-algorithm-and-key-length-recommendations) for best practices for Microsoft Cryptographic involving algorithm choice, key length and data protection. Please make sure to use one of the recommended algorithms, key length and NIST approved curves.

>[!IMPORTANT]
>As part of ongoing security improvements Azure/M365 endpoints are adding support for TLS1.3 and this process is expected to take a few months to cover the thousands of service endpoints across Azure/M365. This includes the Microsoft Entra endpoint used by Microsoft Entra certificate-based authentication (CBA) `*.certauth.login.microsoftonline.com` and `*.certauth.login.microsoftonline.us`. TLS 1.3 is the latest version of the internet’s most deployed security protocol, which encrypts data to provide a secure communication channel between two endpoints. TLS 1.3 eliminates obsolete cryptographic algorithms, enhances security over older versions, and aims to encrypt as much of the handshake as possible. We highly recommend for developers to start testing TLS 1.3 in their applications and services.

>[!NOTE]
>When evaluating a PKI, it is important to review certificate issuance policies and enforcement. As mentioned, adding certificate authorities (CAs) to Microsoft Entra configuration allows certificates issued by those CAs to authenticate any user in Microsoft Entra ID. For this reason, it is important to consider how and when the CAs are allowed to issue certificates, and how they implement reusable identifiers. Where administrators need to ensure only a specific certificate is able to be used to authenticate a user, admins should exclusively use high-affinity bindings to achieve a higher level of assurance that only a specific certificate is able to authenticate the user. For more information, see [high-affinity bindings](concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-username-binding-policy).

<a name='steps-to-configure-and-test-azure-ad-cba'></a>

## Steps to configure and test Microsoft Entra CBA

Some configuration steps need to be done before you enable Microsoft Entra CBA. First, an admin must configure the trusted CAs that issue user certificates. As seen in the following diagram, we use role-based access control to make sure only least-privileged administrators are needed to make changes. 

[!INCLUDE [Privileged role feature](~/includes/privileged-role-feature-include.md)]

Optionally, you can also configure authentication bindings to map certificates to single-factor or multifactor authentication, and configure username bindings to map the certificate field to an attribute of the user object. [Authentication Policy Administrators](../role-based-access-control/permissions-reference.md#authentication-policy-administrator) can configure user-related settings. Once all the configurations are complete, enable Microsoft Entra CBA on the tenant. 

:::image type="content" border="false" source="./media/how-to-certificate-based-authentication/steps.png" alt-text="Diagram of the steps required to enable Microsoft Entra certificate-based authentication.":::

## Step 1: Configure the certificate authorities with PKI-based trust store (Preview)

Entra has a new public key infrastructure (PKI) based certificate authorities (CA) trust store. The PKI-based CA trust store keeps CAs within a container object for each different PKI. Admins can manage CAs in a container based on PKI easier than one flat list of CAs.

The PKI-based trust store has higher limits for the number of CAs and the size of each CA file. A PKI-based trust store supports up to 250 CAs and 8 KB size for each CA object. We highly recommended you use the new PKI-based trust store for storing CAs, which is scalable and supports new functionality like issuer hints. 

>[!Note]
>If you use [the old trust store to configure CAs](how-to-configure-certificate-authorities.md), we recommended you configure a PKI-based trust store. After you make sure everything works well, you can delete the CAs from old trust store. 

An admin must configure the trusted CAs that issue user certificates. 
As seen in the following diagram, we use role-based access control (RBAC) to make sure only least-privileged administrators are needed to make changes. 
A PKI-based trust store has RBAC roles [Privilege Authentication Administrator](../role-based-access-control/permissions-reference.md#privileged-authentication-administrator) and [Authentication Administrator](../role-based-access-control/permissions-reference.md#authentication-administrator).

A Microsoft Entra ID P1 or P2 license is required to configure the certificate authorities with a PKI-based trust store. If you have a free Microsoft Entra ID license or Microsoft 365 license, you can configure certificate authorities to enable CBA by using the Microsoft Entra admin center. For more information, see [How to configure certificate authorities for Microsoft Entra certificate-based authentication](how-to-configure-certificate-authorities.md).

### Configure certificate authorities by using the Microsoft Entra admin center

1.	Create a PKI container object.
   1. Sign in to the Microsoft Entra admin center as an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
   1. Browse to **Protection** > **Show more** > **Security Center** (or **Identity Secure Score**) > **Public key infrastructure (Preview)**.
   1. Click **+ Create PKI**.
   1. Enter **Display Name**.
   1. Click **Create**.

   :::image type="content" border="false" source="./media/how-to-certificate-based-authentication/new-public-key-infrastructure.png" alt-text="Diagram of the steps required to create a PKI.":::

   1. To delete a PKI, select the PKI and select **Delete**. If the PKI has CAs in it, enter the name of the PKI to acknowledge the deletion of all CAs within it and select **Delete**.

   :::image type="content" border="false" source="./media/how-to-certificate-based-authentication/new-public-key-infrastructure.png" alt-text="Diagram of the steps required to delete a PKI.":::

   1. Select **Columns** to add or delete columns.
   1. Select **Refresh** to refresh the list of PKIs.

1. To upload a CA into the PKI container:
   1. Click on **+ Add certificate authority**.
   1. Select the CA file.
   1. Select **Yes** if the CA is a root certificate, otherwise select **No**.
   1. For **Certificate Revocation List URL**, set the internet-facing URL for the CA base CRL that contains all revoked certificates. If the URL isn't set, authentication with revoked certificates won't fail.
   1. For **Delta Certificate Revocation List URL**, set the internet-facing URL for the CRL that contains all revoked certificates since the last base CRL was published.
   1. The **Issuer hints** flag is enabled by default. Turn off **Issuer hints** if the CA shouldn't be included in issuer hints.
   1. Select **Save**.
   1. To delete a CA certificate, select the certificate and select **Delete**.

   :::image type="content" border="false" source="./media/how-to-certificate-based-authentication/delete-certificate-authority.png" alt-text="Diagram of how to delete a CA certificate.":::
   
   1. Select **Columns** to add or delete columns.
   1. Select **Refresh** to refresh the list of CAs.

1. To upload all CAs at once into the PKI container:
   1. Create a PKI container object, or open one.
   1. Select **Upload PKI**.
   1. Enter the http internet facing URL where the . p7b file is available.
   1. Enter the SHA256 checksum of the file.
   1. Select the upload.
   1. Upload PKI is an asynchronous process. As each CA is uploaded, it's available in the PKI. Completion of PKI upload can take up to 30 minutes.
   1. Select **Refresh** to refresh the CAs.

   To generate the SHA256 checksum of the PKI .p7b file, run the command:

   ```powershell
   Get-FileHash .\CBARootPKI.p7b -Algorithm SHA256
   ```

### Edit a PKI

1. To edit PKI, select **...** on the PKI row and select **Edit**.
1. Enter a new PKI name and select **Save**.


### Edit a CA

1. To edit CA, select **...** on the CA row and select **Edit**.
1. Enter new values for Certificate Authority type (root/intermediate), CRL URL, Delta CRL URL, Issuer Hints enabled flag as necessary and select **Save**.


### Restore a PKI
1. Select the **Deleted PKIs** tab.
1. Select the PKI and select **Restore PKI**.


### Restore a CA
1. Select the **Deleted CAs** tab.
1. Select the CA file and select **Restore certificate authority**.

### Understanding isIssuerHintEnabled attribute on CA

Issuer hints send back a Trusted CA Indication as part of the TLS handshake. 
The trusted CA list is set to subject of the CAs uploaded by the tenant in the Entra trust store. 
For more information about issuer hints, see [Understanding Issuer Hints](concept-certificate-based-authentication-technical-deep-dive.md#understanding-issuer-hints-preview).

By default, the subject names of all the CAs in the Entra trust store are sent as hints. 
If you want only specific CAs to be sent back as a hint, set the issuer hint attribute **isIssuerHintEnabled** to true. 

There's a character limit of 16 KB for the issuer hints (subject name of the CA) that the server can send back to the TLS client. So it would be good to set the attribute **isIssuerHintEnabled** to true only for the CAs that issue user certificates. 

If multiple intermediate CAs from the same root certificate issue the end user certificates, then by default all the certificates would show up in the certificate picker. But if you set **isIssuerHintEnabled** to true for specific CAs, only the proper user certificates appear in the certificate picker. To enable **isIssuerHintEnabled**, edit the CA and update the value to true.

### Configure certificate authorities using the Microsoft Graph APIs 
Microsoft Graph APIs can be used to configure CAs. 

The following examples show how to use Microsoft Graph to run Create, Read, Update, or Delete (CRUD) operations for a PKI or CA.

#### Create a PKI container object

```http
#### Request body


PATCH https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/
Content-Type: application/json
{
   "displayName": "ContosoPKI"
}
```

#### Get all the PKI objects

```msgraph-interactive
GET https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations
ConsistencyLevel: eventual
```

#### Get PKI object by PKI-id

```msgraph-interactive
GET https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{PKI-id}/
ConsistencyLevel: eventual
```

#### Upload CAs with a .p7b file

```http
#### Request body

PATCH https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{PKI-id}/certificateAuthorities/{CA-id}
Content-Type: application/json
{
    	"uploadUrl":"https://CBA/demo/CBARootPKI.p7b,
    	"sha256FileHash": "AAAAAAD7F909EC2688567DE4B4B0C404443140D128FE14C577C5E0873F68C0FE861E6F"
}
```

#### Get all CAs in a PKI

```msgraph-interactive
GET https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{PKI-id}/certificateAuthorities
ConsistencyLevel: eventual
```

#### Get a specific CA within a PKI by CA-id

```msgraph-interactive
GET https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{PKI-id}/certificateAuthorities/{CA-id}
ConsistencyLevel: eventual
```

#### Update specific CA issuer hints flag

```http
#### Request body

PATCH https://graph.microsoft.com/beta/directory/publicKeyInfrastructure/certificateBasedAuthConfigurations/{PKI-id}/certificateAuthorities/{CA-id}
Content-Type: application/json
{
   "isIssuerHintEnabled": true
}
```
Configure certificate authorities (CA) using PowerShell
For this configuration, you can use [Microsoft Graph PowerShell] (/powershell/microsoftgraph/installation).

1. Start PowerShell with administrator privileges.
1. Install and import the Microsoft Graph PowerShell SDK.
   ```powershell
   Install-Module Microsoft.Graph -Scope AllUsers
   Import-Module Microsoft.Graph.Authentication
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```
1. Connect to the tenant and accept all.

   ```powershell
      Connect-MGGraph -Scopes "Directory.ReadWrite.All", "User.ReadWrite.All" -TenantId <tenantId>
   ``` 


### Audit log 
Any CRUD operations on a PKI or CA within the trust store are logged into the Microsoft Entra audit logs. 

:::image type="content" border="false" source="./media/how-to-certificate-based-authentication/audit-logs.png" alt-text="Diagram of Audit logs.":::

### FAQs

**Question**: Why does upload PKI fail?

**Answer**: Check if the PKI file is valid and can be accessed without any issues. The max size of PKI file should be 

**Question**: What is the SLA for PKI upload?

**Answer**: PKI upload is an asynchronous operation and may take up to 30 minutes for completion.

**Question**: How do you generate SHA256 checksum for PKI file?

**Answer**: To generate the SHA256 checksum of the PKI.p7b file, run the command: 

```powershell
Get-FileHash .\CBARootPKI.p7b -Algorithm SHA256
```


## Step 2: Enable CBA on the tenant

>[!IMPORTANT]
>A user is considered capable for **MFA** when the user is in scope for **Certificate-based authentication** in the Authentication methods policy. This policy requirement means a user can't use proof up as part of their authentication to register other available methods. If the users don't have access to certificates, they get locked out and can't register other methods for MFA. Authentication Policy Administrators need to enable CBA only for users who have a valid certificates. Don't include **All users** for CBA. Only use groups of users with valid certificates available. For more information, see [Microsoft Entra multifactor authentication](concept-mfa-howitworks.md).

To enable CBA in the Microsoft Entra admin center, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Groups** > **All groups** > select **New group** and create a group for CBA users
1. Browse to **Protection** > **Authentication methods** > **Certificate-based Authentication**.
1. Under **Enable and Target**, select **Enable**.
1. Select **All users**, or select **Add groups** to select specific groups like the one created above. It is recommended to use specific groups rather than **All users**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/enable.png" alt-text="Screenshot of how to enable CBA.":::
 
Once certificate-based authentication is enabled on the tenant, all users in the tenant see the option to sign in with a certificate. Only users who are enabled for CBA can authenticate by using the X.509 certificate. 

>[!NOTE]
>The network administrator should allow access to certauth endpoint for the customer's cloud environment in addition to `login.microsoftonline.com`. Disable TLS inspection on the certauth endpoint to make sure the client certificate request succeeds as part of the TLS handshake.


## Step 3: Configure authentication binding policy

The authentication binding policy helps determine the strength of authentication to either a single factor or multifactor. The default protection level for the certificates on the tenant is **single-factor authentication**.

An Authentication Policy Administrator can change the default value from single-factor to multifactor and configure custom policy rules. Authentication binding rules map certificate attributes, such as Issuer, or Policy OID, or Issuer and Policy OID, to a value and select default protection level for that rule. You can create multiple rules.

To modify tenant default settings in the Microsoft Entra admin center, complete the following steps:

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Policies**.
1. Under **Manage**, select **Authentication methods** > **Certificate-based Authentication**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/policy.png" alt-text="Screenshot of Authentication policy.":::

1. Select **Configure** to set up authentication binding and username binding.
1. The protection level attribute has a default value of **Single-factor authentication**. Select **Multifactor authentication** to change the default value to MFA.

   >[!NOTE] 
   >The default protection level value is in effect if no custom rules are added. If custom rules are added, the protection level defined at the rule level is honored instead.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/change-default.png" alt-text="Screenshot of how to change the default policy to MFA.":::

1. You can also set up custom authentication binding rules to help determine the protection level for client certificates. It can be configured using either the issuer Subject or Policy OID fields in the certificate.

   Authentication binding rules map the certificate attributes (issuer or Policy OID) to a value, and select default protection level for that rule. Multiple rules can be created.

   To add custom rules, select **Add rule**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-rule.png" alt-text="Screenshot of how to add a rule.":::

   To create a rule by certificate issuer, select **Certificate issuer**.

   1. Select a **Certificate issuer identifier** from the list box.
   1. Select **Multifactor authentication**, **Low** affinity binding, and then click **Add**. When prompted, click **I acknowledge** to finish adding the rule. 

      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/multifactor-issuer.png" alt-text="Screenshot of multifactor authentication policy.":::

   To create a rule by Policy OID, select **Policy OID**.

   1. Enter a value for **Policy OID**.
   1. Select **Multifactor authentication**, **Low** affinity binding, and then click **Add**. When prompted, click **I acknowledge** to finish adding the rule. .

      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/multifactor-policy-oid.png" alt-text="Screenshot of mapping to Policy OID.":::

   To create a rule by Issuer and Policy OID:

   1. Select **Certificate Issuer** and **Policy OID**.
   1. Select an issuer and enter the policy OID.
   1. For Authentication strength, select **Single-factor authentication** or **Multifactor authentication**.
   1. For Affinity binding, select **Low**.
 
      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/issuer-and-policy-oid.png" alt-text="Screenshot of how to select a low affinity binding.":::

   1. Select **Add**.
 
      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-issuer-and-policy-oid.png" alt-text="Screenshot of how to add a low affinity binding.":::

   1. Authenticate with a certificate that has policy OID of 3.4.5.6 and Issued by CN=CBATestRootProd. Authentication should pass and get a multifactor claim.

>[!IMPORTANT]
>There is a known issue where a Microsoft Entra tenant admin configures a CBA authentication policy rule using both Issuer and Policy OID impacts some device registration scenarios including:
>- Windows Hello For Business enrollment
>- Fido2 Security Key registration
>- Windows Passwordless Phone Sign-in
>  
>Device registration with Workplace Join, Microsoft Entra ID and Hybrid Microsoft Entra device join scenarios are not impacted. CBA authentication policy rules using either Issuer OR Policy OID are not impacted.
>To mitigate, admins should :
>- Edit the certificate-based authentication policy rules currently using both Issuer and Policy OID options and remove either the Issuer or OID requirement and save. OR
>- Remove the authentication policy rule currently using both Issuer and Policy OID and create rules using only issuer or policy OID
>  
>We are working to fix the issue.

   To create a rule by Issuer and Serial Number:

   1. Add an authentication binding policy that requires any cert issued by CN=CBATestRootProd with policyOID 1.2.3.4.6 needs only high affinity binding (that is, Issuer and serial number are used).
      
      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/issuer-and-serial-number.png" alt-text="Screenshot of Issuer and Serial Number added the Microsoft Entra admin center.":::

   1. Select the certificate field. In this example, we'll select **Issuer and Serial number**.

      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/select-issuer-and-serial-number.png" alt-text="Screenshot of how to select Issuer and Serial Number.":::

   1. The only user attribute supported is **CertificateUserIds**. Select **Add**.

      :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-issuer-and-serial-number.png" alt-text="Screenshot of how to add Issuer and Serial Number.":::

   1. Select **Save**.

   The sign-in log shows which binding was used and the details from certificate.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/sign-in-logs.png" alt-text="Screenshot of sign-in log.":::

1. Select **Ok** to save any custom rule.

>[!IMPORTANT]
>Enter the PolicyOID by using the [object identifier format](https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.4). For example, if the certificate policy says **All Issuance Policies**, enter the OID as **2.5.29.32.0** when you add the rule. The string **All Issuance Policies** is invalid for the rules editor and won't take effect.

## Step 4: Configure username binding policy

The username binding policy helps validate the certificate of the user. By default, we map Principal Name in the certificate to UserPrincipalName in the user object to determine the user. 

An Authentication Policy Administrator can override the default and create a custom mapping. To determine how to configure username binding, see [How username binding works](concept-certificate-based-authentication-technical-deep-dive.md#understanding-the-username-binding-policy).

For more information on scenarios using certificateUserIds attribute see [Certificate user IDs](~/identity/authentication/concept-certificate-based-authentication-certificateuserids.md).

>[!IMPORTANT]
>If a username binding policy uses synchronized attributes, such as the certificateUserIds, onPremisesUserPrincipalName, and userPrincipalName attribute of the user object, be aware that accounts with administrative privileges in Active Directory (such as those with delegated rights on user objects or administrative rights on the Microsoft Entra Connect Server) can make changes that impact these attributes in Microsoft Entra ID. 

1. Create the username binding by selecting one of the X.509 certificate fields to bind with one of the user attributes. The username binding order represents the priority level of the binding. The first one has the highest priority, and so on.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/username-binding-policy.png" alt-text="Screenshot of a username binding policy.":::

   If the specified X.509 certificate field is found on the certificate, but Microsoft Entra ID doesn't find a user object using that value, the authentication fails. Microsoft Entra ID tries the next binding in the list.


1. Select **Save** to save the changes. 

The final configuration looks like this image:

:::image type="content" border="true" source="./media/how-to-certificate-based-authentication/final.png" alt-text="Screenshot of the final configuration.":::

## Step 5: Test your configuration

This section covers how to test your certificate and custom authentication binding rules.

### Test your certificate

As a first configuration test, you should try to sign in to the [MyApps portal](https://myapps.microsoft.com/) using your on-device browser.

1. Enter your User Principal Name (UPN).

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/name.png" alt-text="Screenshot of the User Principal Name.":::

1. Select **Next**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/certificate.png" alt-text="Screenshot of sign-in with certificate.":::

   If you enabled other authentication methods like Phone sign-in or FIDO2, users might see a different sign-in screen.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/alternative.png" alt-text="Screenshot of the alternative sign-in.":::

1. Select **Sign in with a certificate**.

1. Pick the correct user certificate in the client certificate picker UI and select **OK**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/picker.png" alt-text="Screenshot of the certificate picker UI.":::

1. Users should be signed into [MyApps portal](https://myapps.microsoft.com/). 

If your sign-in is successful, then you know that:

- The user certificate has been provisioned into your test device.
- Microsoft Entra ID is configured correctly with trusted CAs.
- Username binding is configured correctly, and the user is found and authenticated.

### Test custom authentication binding rules

Let's walk through a scenario where we validate strong authentication. We'll create two authentication policy rules, one by using issuer subject to satisfy single-factor authentication, and another by using policy OID to satisfy multifactor authentication. 

1. Create an issuer Subject rule with protection level as single-factor authentication and value set to your CAs Subject value. For example: 

   `CN = WoodgroveCA`

1. Create a policy OID rule, with protection level as multifactor authentication and value set to one of the policy OIDs in your certificate. For example, 1.2.3.4.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/policy-oid-rule.png" alt-text="Screenshot of the Policy OID rule.":::

1. Create a Conditional Access policy for the user to require multifactor authentication by following steps at [Conditional Access - Require MFA](../conditional-access/policy-all-users-mfa-strength.md#create-a-conditional-access-policy).
1. Navigate to [MyApps portal](https://myapps.microsoft.com/). Enter your UPN and select **Next**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/name.png" alt-text="Screenshot of the User Principal Name.":::

1. Select **Sign in with a certificate**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/certificate.png" alt-text="Screenshot of sign-in with certificate.":::

   If you enabled other authentication methods like Phone sign-in or security keys, users might see a different sign-in screen.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/alternative.png" alt-text="Screenshot of the alternative sign-in.":::

1. Select the client certificate and select **Certificate Information**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/client-picker.png" alt-text="Screenshot of the client picker.":::

1. The certificate appears, and you can verify the issuer and policy OID values. 
   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/issuer.png" alt-text="Screenshot of the issuer.":::

1. To see Policy OID values, select **Details**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/authentication-details.png" alt-text="Screenshot of the authentication details.":::

1. Select the client certificate and select **OK**.

1. The policy OID in the certificate matches the configured value of **1.2.3.4**, and satisfies multifactor authentication. Similarly, the issuer in the certificate matches the configured value of **CN=WoodgroveCA**, and satisfies single-factor authentication.
1. Because the policy OID rule takes precedence over the issuer rule, the certificate satisfies multifactor authentication.
1. The Conditional Access policy for the user requires MFA and the certificate satisfies multifactor, so the user can sign in to the application.

<a name='enable-azure-ad-cba-using-microsoft-graph-api'></a>


### Test username binding policy

The username binding policy helps validate the certificate of the user. There are three bindings that are supported for the username binding policy:

- IssuerAndSerialNumber > CertificateUserIds 
- IssuerAndSubject > CertificateUserIds 
- Subject > CertificateUserIds 

By default, Microsoft Entra ID maps Principal Name in the certificate to UserPrincipalName in the user object to determine the user. An Authentication Policy Administrator can override the default and create a custom mapping, as explained earlier in Step 4.

Before enabling the new bindings, an Authentication Policy Administrator must make sure the correct values for the bindings are updated in the user object attribute Certificate UserIds for the corresponding username bindings. 

- For cloud only users, use the [Microsoft Entra admin center](/azure/active-directory/authentication/concept-certificate-based-authentication-certificateuserids#update-certificate-user-ids-in-the-azure-portal) or [Microsoft Graph APIs](/azure/active-directory/authentication/concept-certificate-based-authentication-certificateuserids#update-certificateuserids-using-microsoft-graph-queries) to update the value in CertificateUserIds. 
- For on-premises synced users, use Microsoft Entra Connect to sync the values from on-premises by following [Microsoft Entra Connect Rules](/azure/active-directory/authentication/concept-certificate-based-authentication-certificateuserids#update-certificate-user-ids-using-azure-ad-connect) or [syncing AltSecId value](/azure/active-directory/authentication/concept-certificate-based-authentication-certificateuserids#synchronize-alternativesecurityid-attribute-from-ad-to-azure-ad-cba-certificateuserids). 

>[!Important] 
>The format of the values of Issuer, Subject, and SerialNumber should be in the reverse order of their format in the certificate. Don't add any space in the Issuer or Subject. 

#### Issuer and Serial Number manual mapping

Here's an example for Issuer and Serial Number manual mapping. The Issuer value to be added is: 

`C=US,O=U.SGovernment,OU=DoD,OU=PKI,OU=CONTRACTOR,CN=CRL.BALA.SelfSignedCertificate` 

:::image type="content" border="true" source="./media/how-to-certificate-based-authentication/issuer-value.png" alt-text="Screenshot of the Issuer value.":::

To get the correct value for serial number, run the following command, and store the value shown in CertificateUserIds. The command syntax is: 

```
Certutil –dump –v [~certificate path~] >> [~dumpFile path~] 
```

For example: 

```
certutil -dump -v firstusercert.cer >> firstCertDump.txt
```

Here is an example for certutil command: 

```
certutil -dump -v C:\save\CBA\certs\CBATestRootProd\mfausercer.cer 

X509 Certificate: 
Version: 3 
Serial Number: 48efa06ba8127299499b069f133441b2 

   b2 41 34 13 9f 06 9b 49 99 72 12 a8 6b a0 ef 48 
```
 
The SerialNumber value to be added in CertificateUserId is:

**b24134139f069b49997212a86ba0ef48** 

CertificateUserId: 

```
X509:<I>C=US,O=U.SGovernment,OU=DoD,OU=PKI,OU=CONTRACTOR,CN=CRL.BALA.SelfSignedCertificate<SR> b24134139f069b49997212a86ba0ef48 
```

#### Issue and Subject manual mapping
Here's an example for Issue and Subject manual mapping. The Issuer value is:

:::image type="content" border="true" source="./media/how-to-certificate-based-authentication/issuer-multiple.png" alt-text="Screenshot of the Issuer value when used with multiple bindings.":::

The Subject value is:

:::image type="content" border="true" source="./media/how-to-certificate-based-authentication/subject-value.png" alt-text="Screenshot of the Subject value.":::


CertificateUserId:

```
X509:<I>C=US,O=U.SGovernment,OU=DoD,OU=PKI,OU=CONTRACTOR,CN=CRL.BALA.SelfSignedCertificate<S> DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=FirstUserATCSession
```
#### Subject manual mapping

Here's an example for Subject manual mapping. The Subject value is:

:::image type="content" border="true" source="./media/how-to-certificate-based-authentication/subject-2-value.png" alt-text="Screenshot of another Subject value.":::


CertificateUserId:

```
X509:<S>DC=com,DC=contoso,DC=corp,OU=UserAccounts,CN=FirstUserATCSession
```

### Test affinity binding

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least an [Authentication Policy Administrator](../role-based-access-control/permissions-reference.md#authentication-policy-administrator).
1. Browse to **Protection** > **Authentication methods** > **Policies**.
1. Under **Manage**, select **Authentication methods** > **Certificate-based Authentication**.
1. Select **Configure**.
1. Set **Required Affinity Binding** at the tenant level.

   >[!Important]
   > Be careful with the tenant-wide affinity setting. You can lock out the entire tenant if you change the **Required Affinity Binding** for the tenant and you don't have proper values in the user object. Similarly, if you create a custom rule that applies to all users and requires high affinity binding, users in the tenant can get locked out.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/affinity-binding.png" alt-text="Screenshot of how to set required affinity binding.":::

1. To test, select **Required Affinity Binding** to be **Low**.
1. Add a high affinity binding like SKI. Select **Add rule** under **Username binding**.
1. Select **SKI** and select **Add**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-ski.png" alt-text="Screenshot of how to add an affinity binding.":::

   When finished, the rule looks like this screenshot:

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-ski-done.png" alt-text="Screenshot of a completed affinity binding.":::

1. Update all user objects CertificateUserIds attribute to have the correct value of SKI from the user certificate. For more information, see [Supported patterns for CertificateUserIDs](/azure/active-directory/authentication/concept-certificate-based-authentication-certificateuserids#supported-patterns-for-certificate-user-ids).
1. Create a custom rule for Authentication binding. 
1. Select **Add**.

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/custom-authentication-binding.png" alt-text="Screenshot of a custom authentication binding.":::

   When finished, the rule looks like this screenshot:

   :::image type="content" border="true" source="./media/how-to-certificate-based-authentication/add-custom-done.png" alt-text="Screenshot of a custom rule.":::

1. Update the user CertificateUserIds with correct SKI value from the certificate with policy OID 9.8.7.5.
1. Test with a certificate with policy OID 9.8.7.5 and the user should be authenticated with SKI binding and get MFA with only the certificate.

## Enable CBA using Microsoft Graph API

To enable CBA and configure username bindings using Graph API, complete the following steps.

1. Go to [Microsoft Graph Explorer](https://developer.microsoft.com/graph/graph-explorer).
1. Select **Sign into Graph Explorer** and sign in to your tenant.
1. Follow the steps to [consent to the *Policy.ReadWrite.AuthenticationMethod* delegated permission](/graph/graph-explorer/graph-explorer-features#consent-to-permissions).
1. GET all authentication methods:

   ```http
   GET  https://graph.microsoft.com/v1.0/policies/authenticationmethodspolicy
   ```

1. GET the configuration for the x509 Certificate authentication method:

   ```http
   GET https://graph.microsoft.com/v1.0/policies/authenticationmethodspolicy/authenticationMethodConfigurations/X509Certificate
   ```

1. By default, the x509 Certificate authentication method is disabled. To allow users to sign in with a certificate, you must enable the authentication method and configure the authentication and username binding policies through an update operation. To update policy, run a PATCH request.
    
    #### Request body:

    ```http
    PATCH https: //graph.microsoft.com/v1.0/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/x509Certificate
    Content-Type: application/json
    
    {
        "@odata.type": "#microsoft.graph.x509CertificateAuthenticationMethodConfiguration",
        "id": "X509Certificate",
        "state": "enabled",
        "certificateUserBindings": [
            {
                "x509CertificateField": "PrincipalName",
                "userProperty": "onPremisesUserPrincipalName",
                "priority": 1
            },
            {
                "x509CertificateField": "RFC822Name",
                "userProperty": "userPrincipalName",
                "priority": 2
            }, 
            {
                "x509CertificateField": "PrincipalName",
                "userProperty": "certificateUserIds",
                "priority": 3
            }
        ],
        "authenticationModeConfiguration": {
            "x509CertificateAuthenticationDefaultMode": "x509CertificateSingleFactor",
            "rules": [
                {
                    "x509CertificateRuleType": "issuerSubject",
                    "identifier": "CN=WoodgroveCA ",
                    "x509CertificateAuthenticationMode": "x509CertificateMultiFactor"
                },
                {
                    "x509CertificateRuleType": "policyOID",
                    "identifier": "1.2.3.4",
                    "x509CertificateAuthenticationMode": "x509CertificateMultiFactor"
                }
            ]
        },
        "includeTargets": [
            {
                "targetType": "group",
                "id": "all_users",
                "isRegistrationRequired": false
            }
        ]
    }
    ```

1. You get a `204 No content` response code. Rerun the GET request to make sure the policies are updated correctly.
1. Test the configuration by signing in with a certificate that satisfies the policy.

## Enable CBA using Microsoft Power Shell

1. Open a power shell command window
1. Connect to Microsoft Graph
    ```powershell
    Connect-MgGraph -Scopes "Policy.ReadWrite.AuthenticationMethod"
    ```
1. Create a variable for defining group for CBA users
   ```powershell
   $group = Get-MgGroup -Filter "displayName eq 'CBATestGroup'"
   ```
1. Define the request body
    ```powershell
    $body = @{
    "@odata.type" = "#microsoft.graph.x509CertificateAuthenticationMethodConfiguration"
    "id" = "X509Certificate"
    "state" = "enabled"
    "certificateUserBindings" = @(
        @{
            "@odata.type" = "#microsoft.graph.x509CertificateUserBinding"
            "x509CertificateField" = "SubjectKeyIdentifier"
            "userProperty" = "certificateUserIds"
            "priority" = 1
        },
        @{
            "@odata.type" = "#microsoft.graph.x509CertificateUserBinding"
            "x509CertificateField" = "PrincipalName"
            "userProperty" = "UserPrincipalName"
            "priority" = 2
        },
        @{
            "@odata.type" = "#microsoft.graph.x509CertificateUserBinding"
            "x509CertificateField" = "RFC822Name"
            "userProperty" = "userPrincipalName"
            "priority" = 3
        }
    )
    "authenticationModeConfiguration" = @{
        "@odata.type" = "#microsoft.graph.x509CertificateAuthenticationModeConfiguration"
        "x509CertificateAuthenticationDefaultMode" = "x509CertificateMultiFactor"
        "rules" = @(
            @{
                "@odata.type" = "#microsoft.graph.x509CertificateRule"
                "x509CertificateRuleType" = "policyOID"
                "identifier" = "1.3.6.1.4.1.311.21.1"
                "x509CertificateAuthenticationMode" = "x509CertificateMultiFactor"
            }
        )
    }
    "includeTargets" = @(
        @{
            "targetType" = "group"
            "id" = $group.Id
            "isRegistrationRequired" = $false
        }
    ) } | ConvertTo-Json -Depth 5
    ```
1. Execute the PATCH request
      ```powershell
       Invoke-MgGraphRequest -Method PATCH -Uri "https://graph.microsoft.com/v1.0/policies/authenticationMethodsPolicy/authenticationMethodConfigurations/x509Certificate" -Body $body -ContentType "application/json"
      ```

## Next steps 

- [Overview of Microsoft Entra CBA](concept-certificate-based-authentication.md)
- [Technical deep dive for Microsoft Entra CBA](concept-certificate-based-authentication-technical-deep-dive.md)   
- [Limitations with Microsoft Entra CBA](concept-certificate-based-authentication-limitations.md)
- [Windows SmartCard logon using Microsoft Entra CBA](concept-certificate-based-authentication-smartcard.md)
- [Microsoft Entra CBA on mobile devices (Android and iOS)](./concept-certificate-based-authentication-mobile-ios.md)
- [Certificate user IDs](concept-certificate-based-authentication-certificateuserids.md)
- [How to migrate federated users](concept-certificate-based-authentication-migration.md)
- [FAQ](certificate-based-authentication-faq.yml)
