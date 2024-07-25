---
title: SAML token encryption
description: Learn how to configure Microsoft Entra SAML token encryption.

author: omondiatieno
manager: CelesteDG
ms.service: entra-id
ms.subservice: enterprise-apps

ms.topic: concept-article
ms.date: 06/15/2023
ms.author: jomondi
ms.reviewer: alamaral
ms.collection: M365-identity-device-management
ms.custom: enterprise-apps, has-azure-ad-ps-ref

#customer intent: As an IT admin configuring SAML token encryption for Microsoft Entra ID, I want step-by-step instructions on how to upload an X.509 certificate file and activate token encryption, so that I can ensure the SAML assertions emitted for the application are encrypted and secure.
---

# Configure Microsoft Entra SAML token encryption

> [!NOTE]
> Token encryption is a Microsoft Entra ID P1 or P2 feature. To learn more about Microsoft Entra editions, features, and pricing, see [Microsoft Entra pricing](https://www.microsoft.com/security/business/identity-access-management/azure-ad-pricing).

SAML token encryption enables the use of encrypted SAML assertions with an application that supports it. When configured for an application, Microsoft Entra ID will encrypt the SAML assertions it emits for that application using the public key obtained from a certificate stored in Microsoft Entra ID. The application must use the matching private key to decrypt the token before it can be used as evidence of authentication for the signed in user.

Encrypting the SAML assertions between Microsoft Entra ID and the application provides additional assurance that the content of the token can't be intercepted, and personal or corporate data compromised.

Even without token encryption, Microsoft Entra SAML tokens are never passed on the network in the clear. Microsoft Entra ID requires token request/response exchanges to take place over encrypted HTTPS/TLS channels so that communications between the IDP, browser, and application take place over encrypted links. Consider the value of token encryption for your situation compared with the overhead of managing more certificates.

To configure token encryption, you need to upload an X.509 certificate file that contains the public key to the Microsoft Entra application object that represents the application. To obtain the X.509 certificate, you can download it from the application itself, or get it from the application vendor in cases where the application vendor provides encryption keys or in cases where the application expects you to provide a private key, it can be created using cryptography tools, the private key portion uploaded to the application’s key store and the matching public key certificate uploaded to Microsoft Entra ID.

Microsoft Entra ID uses AES-256 to encrypt the SAML assertion data.

## Prerequisites

To configure SAML token encryption, you need:

- A Microsoft Entra user account. If you don't already have one, you can [Create an account for free](https://azure.microsoft.com/free/?WT.mc_id=A261C142F).
- One of the following roles: Cloud Application Administrator, Application Administrator, or owner of the service principal.

[!INCLUDE [portal updates](~/includes/portal-update.md)]

## Configure enterprise application SAML token encryption

This section describes how to configure enterprise application's SAML token encryption. Applications that have been set up from the **Enterprise applications** blade in the Microsoft Entra admin center, either from the Application Gallery or a Non-Gallery app. For applications registered through the **App registrations** experience, follow the [Configure registered application SAML token encryption](#configure-registered-application-saml-token-encryption) guidance.

To configure enterprise application's SAML token encryption, follow these steps:

1. Obtain a public key certificate that matches a private key that's configured in the application.

    Create an asymmetric key pair to use for encryption. Or, if the application supplies a public key to use for encryption, follow the application's instructions to download the X.509 certificate.

    The public key should be stored in an X.509 certificate file in .cer format. You can copy the contents of the certificate file to a text editor and save it as a .cer file. The certificate file should contain only the public key and not the private key.
    
    If the application uses a key that you create for your instance, follow the instructions provided by your application for installing the private key that the application will use to decrypt tokens from your Microsoft Entra tenant.

1. Add the certificate to the application configuration in Microsoft Entra ID.

### Configure token encryption in the Microsoft Entra admin center

You can add the public cert to your application configuration within the Microsoft Entra admin center.

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **Enterprise applications** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. On the application's page, select **Token encryption**.

    ![Screenshot shows how to select the Token encryption option in the Microsoft Entra admin center.](./media/howto-saml-token-encryption/token-encryption-option-small.png)

    > [!NOTE]
    > The **Token encryption** option is only available for SAML applications that have been set up from the **Enterprise applications** blade in the Microsoft Entra admin center, either from the Application Gallery or a Non-Gallery app. For other applications, this menu option is disabled. 

1. On the **Token encryption** page, select **Import Certificate** to import the .cer file that contains your public X.509 certificate.

    ![Screenshot shows how to import a certificate file using Microsoft Entra admin center.](./media/howto-saml-token-encryption/import-certificate-small.png)

1. Once the certificate is imported, and the private key is configured for use on the application side, activate encryption by selecting the **...** next to the thumbprint status, and then select **Activate token encryption** from the options in the dropdown menu.

1. Select **Yes** to confirm activation of the token encryption certificate.

1. Confirm that the SAML assertions emitted for the application are encrypted.

### To deactivate token encryption in the Microsoft Entra admin center

1. In the Microsoft Entra admin center, go to **Identity** > **Applications** > **Enterprise applications** > **All applications**, and then select the application that has SAML token encryption enabled.

1. On the application's page, select **Token encryption**, find the certificate, and then select the **...** option to show the dropdown menu.

1. Select **Deactivate token encryption**.

## Configure registered application SAML token encryption

This section describes how to configure registered application's SAML token encryption. Applications that have been set up from the **App registrations** blade in the Microsoft Entra admin center. For enterprise application, follow the [Configure enterprise application SAML token encryption](#configure-enterprise-application-saml-token-encryption) guidance.

Encryption certificates are stored on the application object in Microsoft Entra ID with an `encrypt` usage tag. You can configure multiple encryption certificates and the one that's active for encrypting tokens is identified by the `tokenEncryptionKeyID` attribute.

You'll need the application's object ID to configure token encryption using Microsoft Graph API or PowerShell. You can find this value programmatically, or by going to the application's **Properties** page in the Microsoft Entra admin center and noting the **Object ID** value.

When you configure a keyCredential using Graph, PowerShell, or in the application manifest, you should generate a GUID to use for the keyId.

To configure token encryption for an application registration, follow these steps:

# [Portal](#tab/azure-portal)

1. Sign in to the [Microsoft Entra admin center](https://entra.microsoft.com) as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 
1. Browse to **Identity** > **Applications** > **App registrations** > **All applications**.
1. Enter the name of the existing application in the search box, and then select the application from the search results.
1. In the application's page, select **Manifest** to edit the [application manifest](~/identity-platform/reference-app-manifest.md).

    The following example shows an application manifest configured with two encryption certificates, and with the second selected as the active one using the tokenEncryptionKeyId.

    ```json
    { 
      "id": "00aa00aa-bb11-cc22-dd33-44ee44ee44ee",
      "accessTokenAcceptedVersion": null,
      "allowPublicClient": false,
      "appId": "00001111-aaaa-2222-bbbb-3333cccc4444",
      "appRoles": [],
      "oauth2AllowUrlPathMatching": false,
      "createdDateTime": "2017-12-15T02:10:56Z",
      "groupMembershipClaims": "SecurityGroup",
      "informationalUrls": { 
         "termsOfService": null, 
         "support": null, 
         "privacy": null, 
         "marketing": null 
      },
      "identifierUris": [ 
        "https://testapp"
      ],
      "keyCredentials": [ 
        { 
          "customKeyIdentifier": "Tog/O1Hv1LtdsbPU5nPphbMduD=", 
          "endDate": "2039-12-31T23:59:59Z", 
          "keyId": "aaaaaaaa-0b0b-1c1c-2d2d-333333333333", 
          "startDate": "2018-10-25T21:42:18Z", 
          "type": "AsymmetricX509Cert", 
          "usage": "Encrypt", 
          "value": <Base64EncodedKeyFile> 
          "displayName": "CN=SAMLEncryptTest" 
        }, 
        {
          "customKeyIdentifier": "A1bC2dE3fH4iJ5kL6mN7oP8qR9sT0u=",
          "endDate": "2039-12-31T23:59:59Z", 
          "keyId": "bbbbbbbb-1c1c-2d2d-3e3e-444444444444",
          "startDate": "2018-10-25T21:42:18Z", 
          "type": "AsymmetricX509Cert", 
          "usage": "Encrypt", 
          "value": <Base64EncodedKeyFile> 
          "displayName": "CN=SAMLEncryptTest2" 
        } 
      ], 
      "knownClientApplications": [], 
      "logoUrl": null, 
      "logoutUrl": null, 
      "name": "Test SAML Application", 
      "oauth2AllowIdTokenImplicitFlow": true, 
      "oauth2AllowImplicitFlow": false, 
      "oauth2Permissions": [], 
      "oauth2RequirePostResponse": false, 
      "orgRestrictions": [], 
      "parentalControlSettings": { 
         "countriesBlockedForMinors": [], 
         "legalAgeGroupRule": "Allow" 
        }, 
      "passwordCredentials": [], 
      "preAuthorizedApplications": [], 
      "publisherDomain": null, 
      "replyUrlsWithType": [], 
      "requiredResourceAccess": [], 
      "samlMetadataUrl": null, 
      "signInUrl": "https://127.0.0.1:444/applications/default.aspx?metadata=customappsso|ISV9.1|primary|z" 
      "signInAudience": "AzureADMyOrg",
      "tags": [], 
      "tokenEncryptionKeyId": "bbbbbbbb-1c1c-2d2d-3e3e-444444444444" 
    }  
    ```

# [Azure AD PowerShell](#tab/azuread-powershell)

1. Use the latest Azure AD PowerShell module to connect to your tenant. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator). 

1. Set the token encryption settings using the **[Set-AzureApplication](/powershell/module/azuread/set-azureadapplication?view=azureadps-2.0-preview&preserve-view=true)** command.

    ```powershell
    Set-AzureADApplication -ObjectId <ApplicationObjectId> -KeyCredentials "<KeyCredentialsObject>"  -TokenEncryptionKeyId <keyID>
    ```

1. Read the token encryption settings using the following commands.

    ```powershell
    $app=Get-AzureADApplication -ObjectId <ApplicationObjectId>
    $app.KeyCredentials
    $app.TokenEncryptionKeyId
    ```

# [Microsoft Graph PowerShell](#tab/msgraph-powershell)

1. Use the Microsoft Graph PowerShell module to connect to your tenant. You need to sign in as at least a [Cloud Application Administrator](~/identity/role-based-access-control/permissions-reference.md#cloud-application-administrator).

1. Set the token encryption settings using the **[Update-MgApplication](/powershell/module/microsoft.graph.applications/update-mgapplication?view=graph-powershell-1.0&preserve-view=true)** command.

    ```powershell

    Update-MgApplication -ApplicationId <ApplicationObjectId> -KeyCredentials "<KeyCredentialsObject>"  -TokenEncryptionKeyId <keyID>

    ```

1. Read the token encryption settings using the following commands.

    ```powershell

    $app=Get-MgApplication -ApplicationId <ApplicationObjectId>

    $app.KeyCredentials

    $app.TokenEncryptionKeyId

    ```
# [Microsoft Graph](#tab/microsoft-graph)

1. Update the application's `keyCredentials` with an X.509 certificate for encryption. The following example shows a Microsoft Graph JSON payload with a collection of key credentials associated with the application.

    ```HTTP
    PATCH https://graph.microsoft.com/beta/applications/<application objectid>

    { 
       "keyCredentials":[ 
          { 
             "type":"AsymmetricX509Cert","usage":"Encrypt",
             "keyId":"aaaaaaaa-0b0b-1c1c-2d2d-333333333333",    (Use a GUID generator to obtain a value for the keyId)
             "key": "MIICADCCAW2gAwIBAgIQ5j9/b+n2Q4pDvQUCcy3…"  (Base64Encoded .cer file)
          }
        ]
    }
    ```

1. Identify the encryption certificate that's active for encrypting tokens. The following example shows a Microsoft Graph JSON payload with the `tokenEncryptionKeyId` element. The `tokenEncryptionKeyId` element specifies the key ID of a public key from the `keyCredentials` collection. 

    ```HTTP
    PATCH https://graph.microsoft.com/beta/applications/<application objectid> 

    { 
       "tokenEncryptionKeyId":"aaaaaaaa-0b0b-1c1c-2d2d-333333333333" (The keyId of the keyCredentials entry to use)
    }
    ```

---

## Next steps

* Find out [How Microsoft Entra ID uses the SAML protocol](~/identity-platform/saml-protocol-reference.md)
* Learn the format, security characteristics, and contents of [SAML tokens in Microsoft Entra ID](~/identity-platform/reference-saml-tokens.md)
